# Web icons

This directory holds the PWA icons referenced by `../manifest.json`:

- `Icon-192.png` (192x192)
- `Icon-512.png` (512x512)
- `Icon-maskable-192.png` (192x192, maskable)
- `Icon-maskable-512.png` (512x512, maskable)

These are binary PNG files that ship with the standard Flutter web template
(`flutter create`). They could not be authored as text in this environment.

Running `flutter create .` inside the `snaphome/` project on any machine with
the Flutter SDK (including CI) will regenerate the default SnapHome/Flutter web
icons here. The app builds and renders without them; browsers simply fall back
when an icon file is missing. Replace them later with your own branded icons.
