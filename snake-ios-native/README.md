# Snake Native iPhone App

This folder is the native foundation for a Snake iPhone app.

Current status:
- Step 1 complete: game spec (`SPEC.md`)
- Step 2 complete: clean module layout
- Step 3 complete: testable Swift game engine (`SnakeEngine`)
- Step 4 complete: SwiftUI iOS app template files for wiring

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
- `SETUP_XCODE.md`
  - Exact checklist to connect everything once Xcode is installed.
- `scripts/bootstrap_ios_target.sh`
  - Copies template Swift files into your new Xcode app target folder.

## Run Local Tests

```bash
cd "/Users/macbookpro23/Library/Mobile Documents/com~apple~CloudDocs/Documents/Russ/Square Game/snake-ios-native"
swift test
```

## Next Steps

1. Run through `SETUP_XCODE.md`.
2. Launch on simulator and iPhone.
3. Add high-score persistence (`UserDefaults`).
4. Tune speed curve and control sensitivity.
