# Game mode

## Agents

If you are an agent (or any tool) reading this repository, **read this file first** before you read code, edit files, or propose a design. This file is the source of what the owner wants. Do not infer the game from the repo name, from DotA, or from empty mod folders. If this file and another file disagree, stop and ask the owner.

The owner's ideas change. This file is the **current** direction, not a history of every old idea.

- When the owner states a new idea, update this file in the same turn, before you code.
- When you code, follow the latest text in this file. Do not follow an older chat message, an older commit, or a section you remember if this file now says something else.
- If a new idea replaces an old one, rewrite the old section. Do not leave both as if both are still true. Put the fact that it changed into `CHANGES.log`, not as a second design.
- Code that contradicts this file is wrong, even if that code was agreed yesterday.

Two duties on every change you make:

1. If the owner agrees an idea, write that idea in this file before or in the same commit as the work. A new agent must be able to learn the game from this file alone.
2. Append what you changed to `CHANGES.log` in the same commit. Date, what changed, and why. Do not delete older entries.

How to run or zip the game is `PACKAGING.log`, not this file.

Working rules the owner set:

- Do not write or commit code until the owner says **grok code it**, unless the owner clearly tells you to create or change the game in that message.
- Every commit message starts with `code from man_grok`, then what changed, then the date and time. Example: `code from man_grok — short what [2026-10-02 14:42 BST]`.

## What this project is

`luanti_dotA` is a new game mode on the [Luanti](https://www.luanti.org/) voxel engine.

The shape follows the 2002 real-time strategy, not a lane-only match and not a copy of any commercial RTS:

- one hero you level
- a base you build
- a hall you defend
- tasks you complete on the map

Factions, buildings, and ability names are original. The story is not original. It follows Homer's *Odyssey*.

The owner rejected these readings:

- not a mining sandbox
- not a pure lane MOBA, even though the repo name says dotA
- not World of Warcraft
- not a port of Warcraft III names, races, heroes, maps, UI, or campaign
- not a retelling that swaps the poem for a new plot

## Story

Odysseus is trying to get home to Ithaca after the war. The hall must still be standing when he arrives.

Use the poem's order. Do not paste a copyrighted translation into the repo. The poem is ancient and public domain. A modern printed translation is not. Write our own short task text.

- The hero is Odysseus.
- The keep is his hall on Ithaca.
- The opposing force is the suitors wearing the house down.
- Telemachus can exist as an ally already at the hall. Penelope is why the hall must not fall. Neither is a second player-hero in the first slice.

Tasks, in poem order:

1. Leave Troy's shore. The fleet is the start, not a base you keep.
2. The lotus-eaters. Refuse the easy stop and move on.
3. The cyclops. A camp fight, then escape, not a fair duel.
4. The bag of winds. You can fail by opening the wrong thing. Failure sends you back.
5. The cannibal shore. Do not land what you cannot hold.
6. Circe's island. Companions are turned aside until the hero undoes it.
7. The land of the dead. Speak to the dead and learn the way home. No new plot.
8. The sirens. Pass a point without stopping.
9. Scylla and Charybdis. The path costs something even if you play well.
10. The cattle of the sun. Do not touch them. Breaking the rule is a loss.
11. Calypso's island. A long hold. The task is to leave.
12. The Phaeacians. They carry him home. This unlocks Ithaca.
13. Ithaca. The hall is under siege by the suitors. Defend it, then end the match in the hall.

RTS verbs sit under that plot: gather, build, defend the hall, clear a stop. The voyage is a chain of tasks. Ithaca is where the hall matters. Later stops must follow this list. The first playable slice does not need all 13.

## Journal, items, and skills

Agreed: during the journal the player picks new items and gains skills, then levels up and picks again. The feel is a hero who can kill a normal enemy or a boss more easily after a good pick. Do not copy skill names or kits from DotA or from any other commercial game. Invent names here.

Picks happen when the match starts, and again each time the hero levels. A level costs 10 experience. Kills and finished tasks give experience. An item can be taken once. More than one item can be owned.

The four agreed items, and the skills now in the game:

| Kind | Item | Skill | Effect |
| --- | --- | --- | --- |
| armor | Banded hide | Bronze voice | The suitor you look at stops for 3 seconds. Their hits on you are weaker. |
| weapon | Ash brand | Brand | For 8 seconds punches hit much harder. This is how the lead suitor dies quickly. |
| fruit | Lotus fruit | Bitter fruit | Heal to full and take a little gold. |
| blood | Dark blood | Cut the vein | A wounded suitor nearby dies. A healthy one only takes a deep cut. |

Open the journal by punching it or with `/journal`. Cast with the journal buttons or `/skill armor`, `/skill weapon`, `/skill fruit`, `/skill blood`.

More items of these kinds (armor, weapon, fruit, blood, and later others) are allowed. New ones must be written into this table when the owner agrees them. They must stay original names.

## What a full match is

A match is a small battlefield of voxels.

- You control one hero, Odysseus. He gains experience, levels, items, and skills. He is the only unit that takes hard fights alone.
- You also run a hall: workers gather, buildings unlock units and upgrades, and the hall is what you must not lose. Workers and the build menu are agreed and **not built**.
- Waves and camps pressure the hall. Defending is part of the match.
- Tasks follow the story list. They pay gold, experience, or a building unlock, or they open the next stop.
- The match ends when the hall falls, or when the last task in the hall is done.

Camera, movement, and the world stay Luanti: a real 3D voxel map, not a flat sprite field. The owner wants a pulled-back view so the hall, the approach, and the hero are visible together. The engine will not give a locked 2002 isometric camera. The slice only tilts the look and tells the player to press F7 twice. Do not claim a locked camera exists.

What Luanti will not be asked to fake:

- box-select of many units, formations, and strong pathfinding
- dozens of units fighting at once
- lockstep multiplayer
- Blizzard art or names

A bad single-player slice is the plan. A real Warcraft III is not.

## Built slice

What actually runs today:

- singlenode pad, the hall, two gold stones, a lotus stand
- the player is Odysseus, with a sword, gold, experience, a text HUD, and the voyage journal in slot 2
- one wave: three suitors plus one lead suitor (more life, harder hit, more hall damage)
- suitors hurt the player if they stand on him
- win if the lotus is refused, all four are dead, and the hall is above 0
- lose if the hall reaches 0
- `/ml` prints status. `/ml_reset` (server privilege) resets the slice and opens the journal again

Gold stones stand in for workers. Only the lotus stop exists. The next stop the text points at is the cyclops, and it is not built.

Not built, and do not describe them as done: workers, build menu, towers, stops after the lotus, a second player, a real isometric camera.

## Repository map

| Path | Role |
| --- | --- |
| `GAME_MODE.md` | What the owner wants **now**. Read first. Replace a section when the idea changes. |
| `CHANGES.log` | What agents changed. Append only. |
| `PACKAGING.log` | Local test, zip layout, why ContentDB will reject this repo. |
| `ml_core` | Hall life, gold, experience, levels, lotus flag, win and loss |
| `ml_journal` | Item picks and the four skills |
| `ml_camera` | Look tilt at spawn. Not a real isometric camera |
| `ml_map` | Pad, hall, gold stones, lotus stand |
| `ml_creeps` | Three suitors and one lead suitor |
| `ml_heroes` | The player as Odysseus, plus a sword. `heroes/hero_example.lua` is not loaded |
| `ml_items` | One voyage token when the lotus is refused |
| `ml_ui` | Text HUD: gold, level, hall, task, skills |

## One match, in the order the owner agreed

1. The hero starts on the shore after the war. The hall on Ithaca already exists and is already under pressure.
2. The journal offers an item before the fight.
3. Workers at the hall gather one resource. Buildings spend it. Not in the slice. Gold stones stand in.
4. The hero clears voyage stops in the story order. Only the lotus exists.
5. Waves walk an authored path toward the hall. One wave exists. No towers.
6. Level-ups open the journal again.
7. The match ends in the hall, or earlier if the hall falls.

Numbers that are not written here (exact costs of future buildings, map size of later stops) get decided when that system is built, then written into this file.

## Rules for content

- Invent building names and ability names. Do not reuse names from commercial games.
- Poem names stay poem names: Odysseus, Ithaca, Penelope, Telemachus, and the stops listed above.
- Each new task is data on the map: where, which poem beat, reward, next stop.
- Agreed ideas go in this file. Done work goes in `CHANGES.log`.
- If the owner changes an idea, this file changes with it. The next coding step reads this file again.

## Copyright and publishing

Copyright (C) 2026 atongsa. All rights reserved.

The game mode and its code are proprietary. See `README.md`. The story outline follows Homer's *Odyssey*, which is in the public domain. Do not copy a modern translation into this repository.

ContentDB only accepts free licenses. This repo is all rights reserved, so it is not for ContentDB unless the owner later chooses a free license on purpose. Local test and a zip are the way to share it. Details are in `PACKAGING.log`.
