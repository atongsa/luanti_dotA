BUILD.md
Read GAME_MODE.md first. This file is only how to continue the build. It is not a second design.

Last session: 2026-10-02. Repo atongsa/luanti_dotA, branch main.
Not run inside Luanti from the agent side. The owner tests on a laptop or desktop.

--------------------------------------------------------------------------------
START HERE TOMORROW
--------------------------------------------------------------------------------

1. Read GAME_MODE.md. If the owner changed an idea, that file wins.
2. Read this file.
3. Do not rebuild the slice. It already runs.
4. Next unfinished work, in this order, unless GAME_MODE.md now says otherwise:
   a. Greek look. The pad is still flat color squares, not Greek models.
   b. Workers and a build menu. Agreed. Not built. Gold stones stand in for workers.
   c. The next story stop only: the cyclops. Do not jump ahead in the poem list.
5. Same commit rules: message starts with "code from man_grok", then what, then the time.
6. New idea with no overlap: add it to GAME_MODE.md. Overlap: rewrite that old idea only.
7. Append CHANGES.log when the repo changes. Do not paste the chat into GAME_MODE.md.

--------------------------------------------------------------------------------
WHAT ALREADY RUNS
--------------------------------------------------------------------------------

Luanti game. Copy the repo folder into the user games directory as luanti_dotA.
New world. Game name luanti_dotA. Mapgen is forced to singlenode in ml_map.
Details of paths and the zip: PACKAGING.log. License is MIT (LICENSE, README.md).

Player is Odysseus. Spawn near the hall, around 0,10,-6.
Slot 1 sword ml_heroes:ash_sword. Slot 2 journal ml_journal:book.
Punch gold stones for +5. Right-click the lotus stand to refuse it.
About 12s later: 3 suitors plus 1 lead suitor walk +z toward the hall.
Win: lotus refused, all four dead, hall above 0. Lose: hall at 0.
Commands: /ml  /journal  /skill armor|weapon|fruit|blood  /ml_reset (priv server).

--------------------------------------------------------------------------------
FOUR SKILLS
--------------------------------------------------------------------------------

Code: mods/ml_journal/init.lua. Points are added in mods/ml_core/init.lua ml.add_xp.
One point at the start. One more point each time xp crosses 10.
Ranks 0 to 3. Meta keys: ml_points, ml_rank_armor, ml_rank_weapon, ml_rank_fruit, ml_rank_blood.
Old saves that only had ml_owned get rank 1 on join.

armor  Bronze voice   stun 2/3/4s. Touch damage falls with rank. ml.touch_damage in ml_creeps.
weapon Brand          bonus punch 6/10/16 for 6/8/10s. ml.punch_bonus, applied in ml_creeps on_punch.
fruit  Bitter fruit   heal 12/16/20 toward a cap of 20, plus a little gold.
blood  Cut the vein   cut 12/18/24. If current hp is at or under the cut, the suitor dies.

--------------------------------------------------------------------------------
FILES
--------------------------------------------------------------------------------

mods/ml_core/init.lua     hall, gold, xp, levels, points, win/lose, /ml, /ml_reset
mods/ml_journal/init.lua  the four skills
mods/ml_map/init.lua      singlenode pad, hall, gold, lotus. ml.build_map
mods/ml_creeps/init.lua   suitors, lead, stun, wave. entity ml_creeps:suitor
mods/ml_heroes/init.lua   sword, nametag, respawn
mods/ml_ui/init.lua       one HUD text line
mods/ml_items/init.lua    voyage token on the lotus
mods/ml_camera/init.lua   look tilt, tells the player to press F7 twice
mods/ml_heroes/heroes/hero_example.lua   not loaded

Mod storage (world): hall, wave (0 none, 1 running, 2 cleared), creeps_alive, lotus, outcome, map_built, ready.

--------------------------------------------------------------------------------
DO NOT REDO
--------------------------------------------------------------------------------

Do not turn this back into a lane MOBA.
Do not paste a modern translation of the Odyssey.
Do not copy Warcraft or DotA names.
Do not claim a locked isometric camera. F7 is the pulled-back view.
Do not switch the license off MIT unless the owner says so. ContentDB needs a free license.

--------------------------------------------------------------------------------
LEFT UNFINISHED ON PURPOSE
--------------------------------------------------------------------------------

Greek meshes and textures.
Workers, buildings, towers.
Poem stops after the lotus. Next one is the cyclops.
Second player.
A real ContentDB upload. The MIT grant is in the repo. The package was not submitted.
