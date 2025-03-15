# Brick Jumper

A 2D vertical platformer where a nimble character leaps up randomly sized stairs on a brick-walled tower, aiming to reach 200 stairs to win, while avoiding falls that reset progress.

## Game Overview

- Jump up randomly generated stairs
- Reach stair 200 to win
- Fall 3+ stairs and it's game over
- Score increases as you climb higher

## Controls

- **Jump**: Spacebar
- **Move Left**: A or Left Arrow
- **Move Right**: D or Right Arrow
- **Restart**: R (after game over or winning)
- **Debug Teleport**: T (jumps to stair 199 for testing)

## Game Rules

- Falling down 1-2 stairs is safe
- Falling 3+ stairs results in game over
- Reach stair 200 to win the game
- Score increases as you climb higher
- Character speed increases over time for added challenge

## How to Run

1. Open the project in Godot Engine (latest stable version)
2. Click the "Play" button in the editor or press F5
3. The game will start with the player at the bottom

## Implementation Details

The game is built using Godot Engine with the following components:

- Player (KinematicBody2D): With jumping and movement controls
- Stairs (StaticBody2D): 200 randomly generated platforms
- Camera: Follows the player as they climb
- UI: Score display, Game Over and Win screens
- Debug: T key teleports player near the top for testing

## Development Status

This is the base implementation of Brick Jumper. Future updates may include:
- Character sprites and animations
- Sound effects and music
- Enhanced visuals for stairs and background
- Power-ups and obstacles

## Credits

Based on the game design in the memory-bank folder. 