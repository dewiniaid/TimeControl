# TimeControl
KSP-like time warp for Factorio using keybindings, from 0.25x to 64x speed (if your game can handle it).  Inspired
by [TimeTools](https://mods.factorio.com/mods/binbinhfr/TimeTools), but using keyboard shortcuts rather than the UI
display and intentionally ignoring all of the other things that mod adds.
  
Time warp affects all players.  TimeControl only allows players with console access to change the game speed (i.e. 
those who could just type `/c game.speed=2` anyways, but TimeControl won't disable achievements.)

All players will be notified via console message when the game speed is changed, who changed it and the new speed. 

## Default Keybindings

Factorio's Controls UI doesn't show various keyboard keys correctly (they'll just read as "KEY61", etc.).  Here's the 
actual keybindings in use by default.  Like all mods, you can change these in **Options -> Controls -> Mods**

 - `-` Halves the current game speed, with a minimum speed of 0.25x.
 - `+` Doubles the current game speed, with a maximum speed of 64x. 
 - `BACKSPACE` - Resets game speed to normal.
 
These all reference the keys on the top row of a US keyboard layout, *not* those on the numpad.
 
## TODO

Make minimum and maximum timewarp amounts configurable.

## Changelog

### 0.1.3 (2017-12-13)
* Fix crash on new games or players joining multiplayer games.

### 0.1.2 (2017-12-13)
* Update for Factorio 0.16
* Made the time indicator display configurable: It can now be always shown, always hidden, or only shown while warping.

### 0.1.1 (2017-12-11)
 
* Add a simple indicator in the upper-left when timewarp is active.
