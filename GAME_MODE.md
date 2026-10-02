# Game mode

This file is the idea and the coding direction. It is not a chat log. Do not paste conversations into it.

Keep every idea. Add a new idea as its own line or section when it does not overlap an old one. If a new idea overlaps an old one (same topic, a change, or a contradiction), update that old idea in place. Do not keep two versions of the same idea.

## Agents

Read this file before you code. Code follows this file, not an older chat.

- Keep ideas that still stand.
- Overlap: rewrite the old idea. The new wording is the one to code.
- No overlap: add the idea. Do not delete unrelated ideas to "clean up."
- Do not record ideas here as chat. `CHANGES.log` is only for repo changes.
- If this file and another file disagree about the game, this file wins. If you are unsure what the current idea is, ask. Do not invent a direction.
- Do not write code until the owner says **grok code it**, unless that message already tells you to build.
- Commit messages start with `code from man_grok`, then what changed, then the date and time.

How to run or zip the game is `PACKAGING.log`.

## What this project is

`luanti_dotA` is a game you play inside [Luanti](https://www.luanti.org/). Install it on a laptop or a desktop. The world is Luanti's 3D voxel sandbox. The match on top of that world is the game.

The shape is a 2002-style real-time strategy, not a lane-only match and not a copy of any commercial RTS:

- one hero you level
- a base you build
- a hall you defend
- tasks you complete on the map

The look is Greek: stone, bronze, sea, the poem. Do not copy a film's costumes or a commercial game's units.

Factions, buildings, and ability names are original. The story follows Homer's *Odyssey*.

Not this:

- not a separate engine or a flat 2D game
- not "win by digging the world away"
- not a pure lane MOBA, even though the repo name says dotA
- not World of Warcraft
- not a port of Warcraft III names, races, heroes, maps, UI, or campaign
- not a new plot in place of the poem

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

## Hero skills

Odysseus has four skills. No fifth. A skill point learns one or raises it. Highest rank is 3. This is the 2002 hero pattern: one point per level, spent on a skill. It replaces the older rule that each level only handed you a new item.

You start with one point. Each level (10 experience) gives another point. Kills and finished tasks give experience.

| Slot | Skill | Ranks |
| --- | --- | --- |
| armor | Bronze voice | Stun lasts longer. Hits you take get smaller. |
| weapon | Brand | Punches hit harder, and the buff lasts longer. |
| fruit | Bitter fruit | Heals more, and pays a little more gold. |
| blood | Cut the vein | The cut is deeper, so a hurt enemy dies more easily. |

Open the journal and press Learn or Upgrade. Cast with Cast, or `/skill armor`, `/skill weapon`, `/skill fruit`, `/skill blood`. Names stay original.

## What a full match is

A match is a small battlefield of voxels inside the Luanti sandbox.

- You control one hero, Odysseus. He gains experience, levels, and spends points on the four skills. He is the only unit that takes hard fights alone.
- You also run a hall: workers gather, buildings unlock units and upgrades, and the hall is what you must not lose. Workers and the build menu are not built yet.
- Waves and camps pressure the hall. Defending is part of the match.
- Tasks follow the story list. They pay gold, experience, or a building unlock, or they open the next stop.
- The match ends when the hall falls, or when the last task in the hall is done.

Camera, movement, and the world stay Luanti: a real 3D voxel map, not a flat sprite field. The view should show the hall, the approach, and the hero together. The engine will not give a locked 2002 isometric camera. The slice only tilts the look and tells the player to press F7 twice. Do not claim a locked camera exists.

Do not pretend Luanti can do these:

- box-select of many units, formations, and strong pathfinding
- dozens of units fighting at once
- lockstep multiplayer
- Blizzard art or names

A rough single-player slice is the plan. A real Warcraft III is not.

## Built now

- singlenode pad, the hall, two gold stones, a lotus stand
- the player is Odysseus, with a sword, gold, experience, a text HUD, and the journal in slot 2
- four skills, each rank 0 to 3, one point to learn or upgrade
- one wave: three suitors plus one lead suitor
- suitors hurt the player if they stand on him
- win if the lotus is refused, all four are dead, and the hall is above 0
- lose if the hall reaches 0
- `/ml` prints status. `/ml_reset` (server privilege) resets the slice and gives one skill point

Gold stones stand in for workers. Only the lotus stop exists. The cyclops is next in the story and is not built.

Not built: workers, build menu, towers, stops after the lotus, a second player, a real isometric camera, Greek models (the pad is still flat colors).

## Repository map

| Path | Role |
| --- | --- |
| `GAME_MODE.md` | All current ideas. Add new ones. Update an old one only when a new idea overlaps it. Not a chat log. |
| `CHANGES.log` | Repo changes only. Append. Not an idea diary. |
| `PACKAGING.log` | Local test and zip layout. |
| `LICENSE` | MIT. This game is open source. |
| `ml_core` | Hall life, gold, experience, levels, skill points, win and loss |
| `ml_journal` | The four skills and their ranks |
| `ml_camera` | Look tilt at spawn. Not a real isometric camera |
| `ml_map` | Pad, hall, gold stones, lotus stand |
| `ml_creeps` | Three suitors and one lead suitor |
| `ml_heroes` | The player as Odysseus, plus a sword. `heroes/hero_example.lua` is not loaded |
| `ml_items` | One voyage token when the lotus is refused |
| `ml_ui` | Text HUD: gold, level, hall, task, skill ranks |

## One match

1. The hero starts on the shore after the war. The hall on Ithaca already exists and is already under pressure.
2. One skill point is waiting. Spend it on one of the four skills.
3. Workers at the hall gather one resource. Buildings spend it. Not in the slice. Gold stones stand in.
4. The hero clears voyage stops in the story order. Only the lotus exists.
5. Waves walk an authored path toward the hall. One wave exists. No towers.
6. Each level gives one more skill point.
7. The match ends in the hall, or earlier if the hall falls.

Numbers that are not written here get decided when that system is built, then written into this file in place of this sentence.

## Content rules

- Invent building names and ability names. Do not reuse names from commercial games.
- Poem names stay poem names: Odysseus, Ithaca, Penelope, Telemachus, and the stops listed above.
- Each new task is data on the map: where, which poem beat, reward, next stop.
- The game is MIT so it can be published where Luanti requires a free license, and so it can be installed from a copy on a laptop or a desktop.

## Copyright and publishing

Code copyright (C) 2026 atongsa, under the MIT license. See `LICENSE` and `README.md`.

The story outline follows Homer's *Odyssey*, which is in the public domain. Do not copy a modern translation into this repository.

Luanti's own program is GNU LGPL v2.1. That is the engine, not this game.

Publishing on ContentDB is allowed only while this MIT grant stays in place. Local install is in `PACKAGING.log`: copy the folder into Luanti's `games` directory and make a new world.
