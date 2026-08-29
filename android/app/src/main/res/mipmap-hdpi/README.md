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
Running `flutter create .` inside the `snaphome/` project on a machine with the
Flutter SDK (including CI) regenerates the default launcher icons. Replace them
later with your own branded icons.
