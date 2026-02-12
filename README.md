# Balde of Dawn

**Balde of Dawn** is a 2D action‑adventure prototype built in **Godot 4.5.1**.  
You explore small areas and dungeons, fight enemies, talk to NPCs, open chests, and test basic combat and interaction systems.  
Most sprites, tiles and other assets are taken from online resources.

---

## Features

- Top‑down 2D movement and combat
- Player sword attack and returning boomerang weapon
- Enemies (slimes, goblins) with simple AI and vision areas
- NPCs with wandering behaviour
- Treasure chests and other dungeon interactables
- Item drops, item magnet, hitbox / hurtbox system
- Global managers for audio, saves, player data and level transitions
- HUD, pause menu, and scene transition UI

---

## Controls

- **Move**: `W A S D` or **Arrow Keys**
- **Attack**: `Z`
- **Boomerang**: `X`
- **Pause Menu**: `Esc`

You can change these in **Project → Project Settings → Input Map**.

---

## Game Flow Map

A general view of how the game works in Godot:

```text
Start project
   ↓
Main scene (playground / Test.tscn)
   ↓
GlobalLevelManager (00_Globals/GlobalLevelManager.gd)
   ↓
Loads a Level scene (Levels/Area01 or Levels/Dungeon01)
   ↓
In each Level:
   ├─ Player (Player/player.tscn)
   │    ├─ Movement (WASD / Arrows)
   │    ├─ Attack (Z)
   │    └─ Boomerang (X)
   │
   ├─ Enemies (Enemies/Slime, Enemies/goblin)
   │    ├─ Vision areas (Enemies/vision_area.tscn)
   │    └─ Hitbox / HurtBox from GeneralNodes/
   │
   ├─ NPCs (Npc/npc.tscn)
   │    └─ Wander behaviour + interaction logic
   │
   ├─ Interactables (Interactables/TreasureChest, dungeon/)
   │    └─ Spawn items via ItemDropper, affected by ItemMagnet
   │
   ├─ GUI (GUI/player_hud, GUI/pause_menu)
   │    └─ Shows health, items, pause options
   │
   └─ Scene transitions
        └─ Levels/level_transition.tscn + GUI/scene_transition