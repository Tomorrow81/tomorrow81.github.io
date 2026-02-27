# Xcode Setup (Do This After Xcode Finishes Installing)

## 1) Verify Xcode is active

```bash
xcodebuild -version
```

If it still points to Command Line Tools, switch it:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

Then open Xcode once and accept license/components if prompted.

## 2) Create iOS App Project

1. Xcode -> `File` -> `New` -> `Project...`
2. Choose iOS `App`
3. Product Name: `SnakeNativeApp`
4. Interface: `SwiftUI`
5. Language: `Swift`
6. Save it anywhere you prefer

## 3) Copy app template files

Replace default app files with the template from this repo:

```bash
cd "/Users/macbookpro23/Library/Mobile Documents/com~apple~CloudDocs/Documents/Russ/Square Game/snake-ios-native"
chmod +x scripts/bootstrap_ios_target.sh
./scripts/bootstrap_ios_target.sh "/ABSOLUTE/PATH/TO/YOUR/XCODE_APP_SOURCE_FOLDER"
```

Example source folder:
- `/Users/you/Developer/SnakeNativeApp/SnakeNativeApp`

## 4) Add the local package dependency in Xcode

1. Select your Xcode project.
2. `Package Dependencies` -> `+` -> `Add Local...`
3. Choose:
   - `/Users/macbookpro23/Library/Mobile Documents/com~apple~CloudDocs/Documents/Russ/Square Game/snake-ios-native`
4. Attach product `SnakeEngine` to app target `SnakeNativeApp`.

## 5) Build and run on Simulator

1. Select iPhone Simulator (e.g., iPhone 16).
2. Press `Cmd+R`.
3. Verify:
   - Snake board renders.
   - Swipe changes direction.
   - Score increments on food.
   - Game over appears on collision.

## 6) Run on your iPhone

1. Connect iPhone and trust device.
2. In Xcode target signing settings:
   - Choose your Apple ID Team.
   - Use unique bundle id (e.g., `com.tomorrow81.snakenative`).
3. Select your iPhone and run (`Cmd+R`).

## Notes

- Engine code lives in:
  - `Sources/SnakeEngine/SnakeEngine.swift`
- SwiftUI app template files live in:
  - `ios-app-template/`
