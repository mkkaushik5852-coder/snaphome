# Launcher icons (mipmap)

The `ic_launcher.png` files referenced by `AndroidManifest.xml`
(`@mipmap/ic_launcher`) live in the density-specific `mipmap-*` folders that
`flutter create` generates:

- `mipmap-mdpi/ic_launcher.png`
- `mipmap-hdpi/ic_launcher.png`
- `mipmap-xhdpi/ic_launcher.png`
- `mipmap-xxhdpi/ic_launcher.png`
- `mipmap-xxxhdpi/ic_launcher.png`

These are binary PNGs and could not be authored as text in this environment.

You do **not** need to do anything: the "Build Debug APK" GitHub Actions
workflow (`.github/workflows/build-apk.yml`) runs `flutter create .` before it
builds, which regenerates these default launcher icons automatically on every
CI run. This is why the icons are not committed to the repo and the APK build
still succeeds.

If you want to work on the project locally, running `flutter create .` inside
the `snaphome/` project on a machine with the Flutter SDK regenerates them the
same way. Replace them later with your own branded icons.
