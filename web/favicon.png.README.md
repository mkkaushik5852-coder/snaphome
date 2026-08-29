# favicon.png

`web/favicon.png` is a binary PNG from the standard Flutter web template and
could not be authored as text in this environment.

You do **not** need to do anything: the "Deploy Web Preview" GitHub Actions
workflow (`.github/workflows/deploy-web.yml`) runs `flutter create .` before it
builds, which regenerates this favicon automatically on every CI run. This is
why it is not committed to the repo and the web build still succeeds.

If you want to work on the project locally, running `flutter create .` inside
the `snaphome/` project regenerates it the same way.
