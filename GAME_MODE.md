# Game mode

## Agents

If you are an agent (or any tool) reading this repository, **read this file first** before you read code, edit files, or propose a design. This file is the source of what the owner wants. Do not infer the game from the repo name, from DotA, or from empty mod folders. If this file and another file disagree, stop and ask the owner.

## What this project is

`luanti_dotA` is a new game mode on the [Luanti](https://www.luanti.org/) voxel engine.

The shape it tries to follow is the 2002 real-time strategy: one hero you level, a base you build, a keep you defend, and tasks you complete on the map. It is **not** a lane-only match, and it is **not** a copy of any existing commercial RTS. Factions, buildings, and abilities are original. The **story is not**: it follows Homer's *Odyssey*.

## Story

The story line follows the poem: Odysseus trying to get home to Ithaca after the war, and the hall that must still be standing when he arrives.

Use the poem's order. Do not invent a different plot, and do not paste a copyrighted translation into the repo. The poem itself is ancient and public domain; a modern printed translation is not. Write our own short task text.

The hero is Odysseus. The keep is his hall on Ithaca. The opposing force is the suitors wearing the house down while he is away. Tasks are the voyage, in poem order, not a random quest list:

1. Leave Troy's shore. The fleet is the start, not a base you keep.
2. The lotus-eaters. A task to refuse the easy stop and move on.
3. The cyclops. A camp fight, then escape, not a fair duel.
4. The bag of winds. A task you can fail by opening the wrong thing; failure sends you back.
5. The cannibal shore. A defense: do not land what you cannot hold.
6. Circe's island. A task that turns companions aside until the hero undoes it.
7. The land of the dead. A task to speak to the dead and learn the way home. No new plot.
8. The sirens. A task to pass a point without stopping.
9. Scylla and Charybdis. A forced loss: the path costs something even if you play well.
10. The cattle of the sun. A task with one rule: do not touch them. Breaking it is a loss.
11. Calypso's island. A long hold. The task is to leave.
12. The Phaeacians. They carry him home. This unlocks Ithaca.
13. Ithaca. The keep is under siege by the suitors. Defend it, then end the match in the hall.

Telemachus can exist as an ally already at the keep. Penelope is the reason the hall must not fall. They are not a second player-hero in the first slice.

RTS verbs stay underneath this plot: gather, build, defend the hall, clear a stop on the voyage. The voyage is a chain of tasks. Ithaca is where the keep actually matters.

## What the match is

A match is a small battlefield made of voxels.

- You control **one hero**, Odysseus. He gains experience, levels, and items, and is the only unit that takes on hard fights alone.
- You also run a **hall**: workers gather, buildings unlock units and upgrades, and the hall is the thing you must not lose.
- **Waves and camps** pressure the hall, especially once the voyage reaches Ithaca. Defending is part of the match, not a side activity.
- **Tasks** follow the list in Story. They pay gold, experience, or a building unlock, or they open the next stop.
- The match ends when the hall falls, or when the last task in the hall is done.

Camera, movement, and the world stay Luanti: a true 3D voxel map, not a flat sprite battlefield. The camera is pulled back and angled so you can see the hall, the approach, and the hero at once.

## What this is not

- Not a mining sandbox. Players do not win by digging or by placing freeform blocks as the main verb. The map is authored.
- Not a pure lane MOBA. Creeps and lanes can exist, but the hero also builds, defends, and does tasks.
- Not a port of another game's factions, heroes, abilities, UI, or campaign.
- Not a retelling that swaps the poem for a new plot.

## How it maps onto this repository

These folders are the mode's parts. They are still empty scaffolds.

| Folder | Role in this mode |
| --- | --- |
| `ml_core` | Match clock, sides, gold, experience, hall health, win and loss, which voyage stop is current |
| `ml_camera` | Pulled-back view over hero and hall |
| `ml_map` | Authored ground, Ithaca hall, approach paths, one stop per task |
| `ml_creeps` | Camps and timed waves, including the suitors at the hall |
| `ml_heroes` | Odysseus. `heroes/hero_example.lua` is only a template until that hero exists |
| `ml_items` | Gear from the voyage that changes his stats |
| `ml_ui` | Health, mana, gold, the current poem task, build menu |

Workers, buildings, and task scripts do not have their own mods yet. They will hang off `ml_core` and `ml_map` until a split is actually needed.

## One match, in order

1. The hero starts on the shore after the war. The hall on Ithaca already exists and is already under pressure.
2. Workers at the hall gather one resource. Buildings spend it.
3. The hero clears voyage stops in the order in Story.
4. Waves walk an authored path toward the hall. Towers and anyone still there answer them.
5. The last stop returns him to Ithaca. The match ends in the hall, or earlier if the hall falls.

Numbers (wave timing, costs, map size) are not fixed in this file. They get decided when that system is actually built.

The first playable slice does not need all 13 stops. It needs the hall, one voyage stop, and a pointer to the next. The order above is still the law for every stop added later.

## Rules for content

- Invent building names and ability names. Do not reuse names from commercial games.
- Poem names stay poem names: Odysseus, Ithaca, Penelope, Telemachus, and the stops listed above.
- One hero template first, then Odysseus only after that template can level, fight, and pick up an item.
- Each task is data on the map (where, what the poem beat is, reward, next stop).

## Copyright

Copyright (C) 2026 atongsa. All rights reserved.

The game mode and its code are proprietary. See `README.md`. The story outline follows Homer's *Odyssey*, which is in the public domain. Do not copy a modern translation into this repository.
