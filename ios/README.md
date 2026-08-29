# iOS project

This folder contains the essential, hand-authored iOS files that
`flutter create --org com.snaphome --platforms=ios` produces:

- `Runner/Info.plist` (display name `SnapHome`, bundle name `snaphome`)
- `Runner/AppDelegate.swift`
- `Runner/Runner-Bridging-Header.h`
- `Flutter/AppFrameworkInfo.plist`
- `Flutter/Debug.xcconfig`, `Flutter/Release.xcconfig`
- `Runner.xcodeproj/project.pbxproj`

The bundle identifier is `com.snaphome.app` (set as `PRODUCT_BUNDLE_IDENTIFIER`
in the Xcode project and referenced from `Info.plist`).

## Caveats

The Xcode project file (`project.pbxproj`), asset catalogs
(`Assets.xcassets`, launch/app icon PNGs), and storyboards
(`LaunchScreen.storyboard`, `Main.storyboard`) contain binary assets and
tightly-coupled Xcode object graphs that cannot be perfectly hand-authored in a
text-only, SDK-less environment.

Running `flutter create .` inside the `snaphome/` project on a Mac (or in CI
with the Flutter SDK) regenerates and repairs any missing or incomplete iOS
project files without disturbing the Dart code or the values set above. iOS
build/signing is deferred per the project constraints, so this is expected and
safe for now.
