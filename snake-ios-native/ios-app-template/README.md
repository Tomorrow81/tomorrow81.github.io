# iOS App Scaffold Notes

This folder documents how to wire `SnakeEngine` into an iPhone SwiftUI app target.

## Create App Target in Xcode

1. Open Xcode.
2. `File` -> `New` -> `Project...` -> iOS `App`.
3. Product name: `SnakeNativeApp`
4. Interface: `SwiftUI`
5. Language: `Swift`
6. Save it inside this folder (or sibling folder).

## Add Local Package

1. In Xcode, select your project.
2. `Package Dependencies` -> `+` -> `Add Local...`
3. Select:
   - `/Users/macbookpro23/Library/Mobile Documents/com~apple~CloudDocs/Documents/Russ/Square Game/snake-ios-native`
4. Link product `SnakeEngine` to your app target.

## Included Template Files

- `SnakeNativeApp.swift`
- `ContentView.swift`
- `GameViewModel.swift`
- `GameBoardView.swift`

Copy these into your Xcode iOS app target and replace the default SwiftUI files.
