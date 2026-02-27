# Snake iPhone App Spec (v1)

## Goal

Ship a native iPhone Snake app with responsive controls and reliable game rules.

## Core Gameplay

- Grid: `20 x 20`
- Initial snake length: `3`
- Initial direction: `right`
- Tick cadence: starts at `160 ms`
- Food:
  - Spawn in any unoccupied tile.
  - Eating food increases score by `1`.
  - Eating food grows snake by `1` segment.
- Movement:
  - One tile per tick.
  - Reverse-direction input is ignored (cannot directly turn into yourself).
- Game over:
  - Snake collides with wall (v1 uses no wrapping).
  - Snake collides with its own body.
- Win condition:
  - Snake occupies all grid cells.

## Controls

- Swipe up/down/left/right.
- Ignore direction changes that are opposite to current movement.

## UI (v1)

- Main board view (single-screen).
- Score display.
- Start/Restart button.
- Pause/Resume button.
- Game-over banner.

## Persistence (v1.1)

- Save high score locally with `UserDefaults`.

## Technical Architecture

- `SnakeEngine` (pure Swift, no UI dependencies)
  - Deterministic logic, easy unit testing.
- `SnakeApp` (SwiftUI iOS target)
  - UI rendering and gesture input.
- `SnakeViewModel`
  - Owns timer and maps engine state to UI.

## Out of Scope (for first release)

- Online multiplayer.
- Leaderboards.
- Themes/skins.
- Monetization.
