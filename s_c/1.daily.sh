#!/usr/bin/env bash


# make structure
mkdir -p mobalike/menu
mkdir -p mobalike/textures

mkdir -p mobalike/mods/ml_core
mkdir -p mobalike/mods/ml_map
mkdir -p mobalike/mods/ml_camera
mkdir -p mobalike/mods/ml_heroes/heroes
mkdir -p mobalike/mods/ml_creeps
mkdir -p mobalike/mods/ml_ui
mkdir -p mobalike/mods/ml_items

touch mobalike/game.conf
touch mobalike/README.md
touch mobalike/LICENSE

touch mobalike/mods/ml_core/mod.conf
touch mobalike/mods/ml_core/init.lua

touch mobalike/mods/ml_map/mod.conf
touch mobalike/mods/ml_map/init.lua
touch mobalike/mods/ml_map/nodes.lua

touch mobalike/mods/ml_camera/mod.conf
touch mobalike/mods/ml_camera/init.lua

touch mobalike/mods/ml_heroes/mod.conf
touch mobalike/mods/ml_heroes/init.lua
touch mobalike/mods/ml_heroes/heroes/hero_example.lua

touch mobalike/mods/ml_creeps/mod.conf
touch mobalike/mods/ml_creeps/init.lua

touch mobalike/mods/ml_ui/mod.conf
touch mobalike/mods/ml_ui/init.lua

touch mobalike/mods/ml_items/mod.conf
touch mobalike/mods/ml_items/init.lua

echo "mobalike structure created."

# push
git init
git add .
git commit -m "Initial project structure"
git branch -M main
git remote add origin git@github.com:atongsa/luanti_dotA.git
git push -u origin main

# kk
