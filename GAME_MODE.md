# Game mode

`luanti_dotA` is a new game mode on the [Luanti](https://www.luanti.org/) voxel engine.

The shape it tries to follow is the 2002 real-time strategy: one hero you level, a base you build, a keep you defend, and tasks you complete on the map. It is **not** a lane-only match, and it is **not** a copy of any existing commercial RTS. Names, factions, heroes, buildings, items, maps, and story in this project are original.

## What the match is

A match is a small battlefield made of voxels.

- You control **one hero**. The hero gains experience, levels, and items, and is the only unit that takes on hard fights alone.
- You also run a **base**: workers gather, buildings unlock units and upgrades, and a **keep** is the thing you must not lose.
- **Waves and camps** pressure the keep. Defending is part of the match, not a side activity.
- The map gives **tasks**: go somewhere, clear a camp, hold a point, escort, bring an object back. Tasks pay gold, experience, or a building unlock. They are how the match moves forward when nobody is fighting the keep.
- The other side (another player, or the map's opposing force) does the same. The match ends when a keep falls, or when the map's final task is done.

Camera, movement, and the world stay Luanti: a true 3D voxel map, not a flat sprite battlefield. The camera is pulled back and angled so you can see the base, the lanes of approach, and the hero at once.

## What this is not

- Not a mining sandbox. Players do not win by digging or by placing freeform blocks as the main verb. The map is authored.
- Not a pure lane MOBA. Creeps and lanes can exist, but the hero also builds, defends, and does tasks.
- Not a port of another game's factions, heroes, abilities, UI, or campaign.

## How it maps onto this repository

These folders are the mode's parts. They are still empty scaffolds.

| Folder | Role in this mode |
| --- | --- |
| `ml_core` | Match clock, sides, gold, experience, keep health, win and loss |
| `ml_camera` | Pulled-back view over hero and base |
| `ml_map` | Authored ground, keep sites, approach paths, task markers, nodes |
| `ml_creeps` | Camps and timed waves that walk toward a keep |
| `ml_heroes` | Hero definitions. `heroes/hero_example.lua` is the template, not a finished hero |
| `ml_items` | Gear that changes hero stats |
| `ml_ui` | Health, mana, gold, task list, build menu |

Workers, buildings, and task scripts do not have their own mods yet. They will hang off `ml_core` and `ml_map` until a split is actually needed.

## One match, in order

1. Both sides spawn at a keep with a hero and a few workers.
2. Workers gather a single resource from nodes near the keep. Buildings spend that resource.
3. The hero leaves the base to clear a camp or finish the first task.
4. A wave walks an authored path toward the keep. Towers and the hero answer it.
5. Later tasks open the far side of the map. The match ends at the enemy keep, or at the last task.

Numbers (wave timing, costs, map size) are not fixed in this file. They get decided when that system is actually built.

## Rules for content

- Invent factions, unit names, and ability names here. Do not reuse names from other games.
- One hero template first (`hero_example`), then more heroes only after that template can level, fight, and pick up an item.
- Tasks are data on the map (where, what, reward), not hardcoded story from somewhere else.

## Copyright

Copyright (C) 2026 atongsa. All rights reserved.

This file describes an original mode. It does not grant a license to copy this repository. See `README.md`.
