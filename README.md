# SnapHome

SnapHome is a home decor app powered by AI. The idea: point your phone at a
room and get design and decor ideas for it. This project is a **work in
progress** and the starter version currently shows a simple home screen so
that previews show something real. Screens, layouts, and features will be
added over time.

You do not need to be a coder to use this guide. Everything below can be done
from a phone.

---

## Live web preview (the easy way to see the app)

There is a free, always-on web preview of the app's screens here:

**https://mkkaushik5852-coder.github.io/snaphome/**

- Every time a change is saved to the project (a "push" to the `main` branch),
  the preview **rebuilds and redeploys itself automatically**.
- To see the newest version, just **open that link on your phone and refresh
  it**. That is the mobile-friendly version of a live/hot reload: no PC needed.
- It usually takes a couple of minutes after a change for the new version to
  appear, so if you do not see the update right away, wait a moment and refresh
  again.

> The preview is a website, so a few "native only" phone features will not work
> there. See [What works in the web preview vs. the app](#what-works-in-the-web-preview-vs-the-installed-app) below.

---

## One-time setup: turn on the web preview (do this once, in a browser)

The web preview link above only works after GitHub Pages is switched on. This
is a setting inside GitHub's website. It **cannot be done from the code** and
has to be toggled **once**, by hand, in your browser. You only ever do this a
single time.

1. Make sure the deploy workflow has run at least once. Open the repo's
   **Actions** tab, look for the **Deploy Web Preview** workflow, and confirm it
   has finished at least one run. (It runs automatically after a push to
   `main`. If you do not see a run, you can start one: open **Deploy Web
   Preview** and tap **Run workflow**.)
2. In the repo, tap **Settings** (the gear).
3. In the left menu, tap **Pages**.
4. Under **Build and deployment**, find **Source**.
5. Change **Source** to **GitHub Actions**.
6. That is it. Within a few minutes the preview link at the top of this README
   will start working. Open it on your phone and refresh.

If the link shows an error at first, give it a couple of minutes after the
first successful deploy and refresh again.

---

## Install the real Android app (debug APK) from your phone

The web preview is great for looking at screens, but to test the **real
Android app** on your phone you install an APK. A fresh APK is built
automatically and saved as a downloadable file after every push. Here is how to
get it, all from your phone:

1. Open the repo's **Actions** tab.
2. Tap the **Build Debug APK** workflow, then open the **latest run** at the top
   (a green check means it succeeded).
3. Scroll down to the **Artifacts** section.
4. Download the artifact named **snaphome-debug-apk**. It downloads as a `.zip`
   file.
5. **Unzip** it (most phones can do this from the Files app by tapping the zip).
   Inside you will find `app-debug.apk`.
6. **Tap the `.apk` file** to install it.
7. Your phone will likely warn you and ask permission to **install from unknown
   sources** (or "install unknown apps"). Allow it for your browser or Files
   app, then continue. This is normal for apps installed outside the Play Store.
8. Once installed, open **SnapHome** from your app list.

> A "debug" APK is a test build. It is meant for trying the app out, not for
> publishing to the store.

---

## What works in the web preview vs. the installed app

- The **web preview** is a website. Features that need real phone hardware,
  such as the **camera** and **AR (augmented reality)**, will **not work**
  there. You will still see the layout and screens.
- The **installed Android app (the APK)** runs natively on your phone, so those
  **camera and AR features will work** once they are added.

So: use the web preview to check how screens look, and use the installed APK to
test real native features.

---

## Publishing to the app stores (coming later)

Store publishing is **deferred** on purpose so we can focus on building the app
first. When the time comes:

- **Apple App Store (iOS):** requires a **Mac computer** and a **paid Apple
  Developer account** (about **$99 per year**). This is set up later.
- **Google Play Store (Android):** requires a **one-time Google Play Developer
  account** (about **$25, paid once**). The release build (an AAB file) and app
  signing are set up at that point. A ready-to-enable, commented template for
  the release build already lives in the APK workflow file.

None of this is needed to preview or test the app today.

---

## What's here (file map)

- `lib/` - the app's screens and code (Dart). `lib/main.dart` is the starting
  point and holds the starter home screen.
- `web/` - the files that let the app run as a website (used by the preview).
- `android/` - the Android version of the app (used to build the APK).
- `ios/` - the iOS version of the app (for the App Store later).
- `test/` - automated checks that run in the cloud.
- `pubspec.yaml` - the app's settings and list of add-on packages.
- `.github/workflows/deploy-web.yml` - the automation that builds and publishes
  the web preview to GitHub Pages.
- `.github/workflows/build-apk.yml` - the automation that builds the debug APK
  you install on your phone.
- `README.md` - this guide.

> **About the app icons and graphics:** the small binary image files (the
> Android launcher icon, the website favicon, and the web app icons) are not
> stored in the project. Instead, both automations regenerate the standard
> default images automatically each time they build, so nothing is missing when
> the web preview and APK are created. You can replace them with your own
> branded artwork later.
