#!/bin/zsh
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <path-to-ios-app-source-folder>"
  echo "Example:"
  echo "  $0 \"/Users/you/Projects/SnakeNativeApp/SnakeNativeApp\""
  exit 1
fi

TARGET_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$ROOT_DIR/ios-app-template"

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Error: target directory not found: $TARGET_DIR"
  exit 1
fi

for file in SnakeNativeApp.swift ContentView.swift GameViewModel.swift GameBoardView.swift; do
  if [[ ! -f "$TEMPLATE_DIR/$file" ]]; then
    echo "Error: missing template file: $TEMPLATE_DIR/$file"
    exit 1
  fi
done

cp "$TEMPLATE_DIR/SnakeNativeApp.swift" "$TARGET_DIR/SnakeNativeApp.swift"
cp "$TEMPLATE_DIR/ContentView.swift" "$TARGET_DIR/ContentView.swift"
cp "$TEMPLATE_DIR/GameViewModel.swift" "$TARGET_DIR/GameViewModel.swift"
cp "$TEMPLATE_DIR/GameBoardView.swift" "$TARGET_DIR/GameBoardView.swift"

echo "Copied SwiftUI app template files into:"
echo "  $TARGET_DIR"
echo
echo "Next in Xcode:"
echo "1) Remove default template files if still present."
echo "2) Add local package dependency:"
echo "   $ROOT_DIR"
echo "3) Link product: SnakeEngine to your app target."
