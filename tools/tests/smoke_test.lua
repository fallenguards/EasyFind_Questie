-- Loads an addon's toc files against a stubbed game and a recording EasyFind.API, then checks what it
-- registered. Usage: lua smoke_test.lua <addon dir> <toc> <addon name> [noapi|oldapi|questie|old]
-- noapi: no EasyFind; oldapi: EasyFind before API MINOR 1; questie: Questie says it is ready without its
-- quest data; old: settings saved before the Show choice.
-- luacheck: std lua54
-- luacheck: ignore 111 112 113 121 122 212
local dir, tocName, addon, mode = arg[1], arg[2], arg[3], arg[4] or "normal"

local Stub
local stubMeta = {}
stubMeta.__index = function(t, k)
    if k == "GetName" then return function() return nil end end
    if k == "GetWidth" or k == "GetHeight" or k == "GetScale" or k == "GetStringWidth" then
        return function() return 1 end
    end
    if k == "IsShown" or k == "IsVisible" or k == "GetChecked" or k == "IsEventRegistered" then
        return function() return false end
    end
    local v = Stub()
    rawset(t, k, v)
    return v
end
stubMeta.__call = function() return Stub() end
stubMeta.__concat = function(a, b) return tostring(type(a) == "table" and "" or a) .. tostring(type(b) == "table" and "" or b) end
for _, op in ipairs({ "__add", "__sub", "__mul", "__div", "__unm", "__mod", "__pow" }) do stubMeta[op] = function() return 0 end end
stubMeta.__lt = function() return false end
stubMeta.__le = function() return false end
stubMeta.__len = function() return 0 end
function Stub() return setmetatable({}, stubMeta) end

local frames = {}
local function NewFrame(_, name)
    local f = Stub()
    local scripts, events = {}, {}
    rawset(f, "SetScript", function(self, which, fn) scripts[which] = fn end)
    rawset(f, "HookScript", function(self, which, fn) scripts[which] = scripts[which] or fn end)
    rawset(f, "RegisterEvent", function(self, e) events[e] = true end)
    rawset(f, "UnregisterEvent", function(self, e) events[e] = nil end)
    rawset(f, "IsEventRegistered", function(self, e) return events[e] == true end)
    f.scripts, f.events = scripts, events
    frames[#frames + 1] = f
    return f
end

local toc = assert(io.open(dir .. "/" .. tocName)):read("a")
-- Saved variables start empty, as on a first login.
local saved = {}
for list in toc:gmatch("## SavedVariables[%w]*:%s*([^\r\n]+)") do
    for name in list:gmatch("[%w_]+") do saved[name] = true end
end

-- The game's own strings (QUESTS_LABEL and the like) are absent here, so the addon's English fallbacks show.
local env = setmetatable({}, { __index = function(t, k)
    local v = rawget(_G, k)
    if v ~= nil or saved[k] or k:match("^[A-Z][A-Z0-9_]+$") then return v end
    v = Stub()
    rawset(t, k, v)
    return v
end })
_G.CreateFrame = NewFrame
_G.GetLocale = function() return "enUS" end
_G.GetTime = function() return 100 end
_G.InCombatLockdown = function() return false end
_G.UnitLevel = function() return 10 end
_G.wipe = function(t) for k in pairs(t) do t[k] = nil end return t end
_G.C_Timer = { After = function() end, NewTicker = function() return Stub() end, NewTimer = function() return Stub() end }
_G.strsplit = function(sep, s) local out = {} for p in s:gmatch("[^" .. sep .. "]+") do out[#out + 1] = p end return table.unpack(out) end
_G.unpack = table.unpack
_G.tinsert, _G.tremove = table.insert, table.remove

local printed = {}
_G.print = function(...)
    local parts = {}
    for i = 1, select("#", ...) do parts[i] = tostring(select(i, ...)) end
    printed[#printed + 1] = table.concat(parts, " ")
end
local function Say(s) io.stdout:write(s, "\n") end

-- EasyFind.API as an extension sees it, every registration kept.
local registered = { extensions = {}, providers = {} }
if mode ~= "noapi" then
    local API = { VERSION = 1, MINOR = mode == "oldapi" and 0 or 1 }
    function API.RegisterExtension(def) registered.extensions[def.id] = def return true end
    function API.RegisterSearchProvider(def) registered.providers[def.key] = def return true end
    function API.RefreshSearchProvider() end
    function API.HasAction() return false end
    function API.CallAction() end
    _G.EasyFind = { API = API }
end
local onReady
if mode == "questie" then
    _G.Questie = { API = { RegisterOnReady = function(fn) onReady = fn end } }
end
if mode == "old" then _G.EasyFindQuestieDB = { inLog = true } end

local ns = {}
local count = 0
for line in toc:gmatch("[^\r\n]+") do
    if line:match("%.lua$") and not line:match("^#") then
        local path = dir .. "/" .. line:gsub("\\", "/")
        local chunk, err = loadfile(path, "t", env)
        if not chunk then Say("LOAD " .. err) os.exit(1) end
        local ok, runErr = pcall(chunk, addon, ns)
        if not ok then Say("RUN " .. line .. ": " .. tostring(runErr)) os.exit(1) end
        count = count + 1
    end
end
Say("loaded " .. count .. " files (" .. mode .. ")")

local failed = false
local function Check(ok, what)
    Say((ok and "PASS " or "FAIL ") .. what)
    if not ok then failed = true end
end

local ext, provider = registered.extensions.questie, registered.providers.questie
if mode == "noapi" or mode == "oldapi" then
    Check(ext == nil and provider == nil, "nothing registered without EasyFind API 1.1")
    if mode == "oldapi" then
        Check(printed[1] ~= nil and printed[1]:find("newer EasyFind", 1, true) ~= nil, "says EasyFind needs an update")
    end
    os.exit(failed and 1 or 0)
end

Check(ext ~= nil and type(ext.name) == "string" and ext.icon ~= nil, "the extension, with its name and icon")
Check(provider ~= nil and provider.extension == "questie", "its search provider, under the extension")
Check(provider ~= nil and type(provider.label) == "string", "the provider's label is text: " .. tostring(provider and provider.label))
for _, fn in ipairs({ "rows", "select", "tooltip", "hint", "place", "menu", "browse" }) do
    Check(provider ~= nil and type(provider[fn]) == "function", "provider." .. fn)
end
if provider then
    local ok, rows = pcall(provider.rows)
    Check(ok and type(rows) == "table" and #rows == 0, "no rows before Questie is ready")
    local choice
    for _, o in ipairs(provider.options or {}) do if o.choice then choice = o end end
    Check(choice ~= nil, "the Show choice on its filter row")
    if choice then
        Check(choice.get() == (mode == "old" and "inLog" or "notDone"),
            "Show reads " .. tostring(choice.get()) .. (mode == "old" and " from the old In log switch" or ""))
        ok = pcall(choice.set, "all")
        Check(ok and choice.get() == "all", "Show takes a new value")
    end
end
if ext and ext.settings then
    local kit = setmetatable({}, { __index = function() return function() return Stub() end end })
    local ok, err = pcall(ext.settings, Stub(), kit)
    Check(ok, "the settings page builds" .. (ok and "" or (": " .. tostring(err))))
end
if mode == "questie" then
    Check(onReady ~= nil, "waits for Questie's ready signal")
    local ok = onReady and pcall(onReady)
    Check(ok and printed[#printed] ~= nil and printed[#printed]:find("not available", 1, true) ~= nil,
        "no quest data: says quest search is off")
end
for i = 1, #frames do
    local f = frames[i]
    if f.scripts.OnEvent then
        for _, e in ipairs({ "PLAYER_LOGIN", "PLAYER_LEVEL_UP", "ZONE_CHANGED_NEW_AREA" }) do
            local ok, err = pcall(f.scripts.OnEvent, f, e)
            if not ok then Check(false, "event " .. e .. ": " .. tostring(err)) end
        end
    end
end
os.exit(failed and 1 or 0)
