# Web icons

This directory holds the PWA icons referenced by `../manifest.json`:

- `Icon-192.png` (192x192)
- `Icon-512.png` (512x512)
- `Icon-maskable-192.png` (192x192, maskable)
- `Icon-maskable-512.png` (512x512, maskable)

These are binary PNG files that ship with the standard Flutter web template
(`flutter create`). They could not be authored as text in this environment.

You do **not** need to do anything: the "Deploy Web Preview" GitHub Actions
workflow (`.github/workflows/deploy-web.yml`) runs `flutter create .` before it
builds, which regenerates these default web icons automatically on every CI
run. This is why the icons are not committed to the repo and the web build
still succeeds.

If you want to work on the project locally, running `flutter create .` inside
the `snaphome/` project on any machine with the Flutter SDK regenerates them the
same way. Replace them later with your own branded icons.
