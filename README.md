# EasyFind: Questie Extension

Questie's quests in EasyFind's search bar. Type a quest's name and the row shows where you stand with it, its level, zone and giver, with the game's quest mark for its state (grayed while you cannot take it yet). A click asks EasyFind's GPS for directions: to the giver when you have not picked the quest up, to the first open objective while it is in your log, and to the turn-in once it is complete. Hovering a row shows the objectives.

Requires Questie and EasyFind.

## What it adds

- Quest rows in EasyFind's search results, and an `@quest` scope that lists only quests.
- A Quests row in the filter menu: Show (Not turned in, Available to me, In my log, Turned in, All) and Near me.
- A Questie tile in the extensions menu, with the same settings in Options > Extensions.

## Dependencies

- EasyFind 4.0.1 or later (extension API 1.1). With an older EasyFind the addon says so in chat and stays off.
- Questie, which this addon reads at runtime through its API and its quest database. Nothing of Questie's is copied into this addon.

## How it reads Questie

The addon waits for `Questie.API.RegisterOnReady`, then looks for Questie's quest database functions. If a function it needs is missing in the installed Questie version, quest search turns itself off with one line in chat and nothing else changes. Questie's settings are never written.
