# FinapseX Script For Webfishing

A comprehensive gameplay enhancement mod for Webfishing featuring unlockables, cheats, and quality-of-life improvements.

![Banner Image](https://raw.githubusercontent.com/geringverdien/TeamFishnet/refs/heads/main/Finapse%20X/screenshot.png)

## Features

- **Unlock System**: Cosmetics, props, achievements, and tags
- **Stat Manipulation**: Infinite money, XP, and fishing stats
- **Teleportation**: Pre-set locations and player teleportation
- **Advanced Movement**: Flight system with adjustable speed
- **Item Spawning**: Generate any fish/item with custom parameters
- **Social Features**: Mail system manipulation and server commands
- **Combat System**: Player punching mechanics and spam modes

## Installation

1. Ensure you have a mod loader installed for Webfishing
2. Place `Cry4pt.gd` in your mods folder
3. Launch the game with mod support enabled

## Configuration

Edit these values in the script header:
```gdscript
var config = {
    "unlock_key": KEY_END,
    "stop_key": KEY_DELETE,
    "enable_logs": true,
    "enable_notifications": false,
    "infinite_values": false
}
