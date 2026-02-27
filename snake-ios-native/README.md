# Snake Native iPhone App

This folder is the native foundation for a Snake iPhone app.

Current status:
- Step 1 complete: game spec (`SPEC.md`)
- Step 2 complete: clean module layout
- Step 3 complete: testable Swift game engine (`SnakeEngine`)

## Layout

- `SPEC.md`
  - Product/gameplay rules and release scope.
- `Package.swift`
  - Swift package manifest for the engine.
- `Sources/SnakeEngine/`
  - Pure Swift engine logic (no UI).
- `Tests/SnakeEngineTests/`
  - Unit tests for rules and state transitions.
- `ios-app-template/`
  - SwiftUI app scaffold notes for wiring the engine into an iOS target.

## Run Local Tests

```bash
cd "/Users/macbookpro23/Library/Mobile Documents/com~apple~CloudDocs/Documents/Russ/Square Game/snake-ios-native"
swift test
```

## Next Steps

1. Create an iOS SwiftUI app target in Xcode.
2. Add this package as a local dependency.
3. Build `GameViewModel` + `GameBoardView` around `SnakeGame`.
4. Add swipe input, pause/restart, and high-score persistence.
5. Run on a physical iPhone and tune controls/tick speed.
