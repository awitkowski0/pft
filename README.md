# PFT Path

Flutter fitness companion with AI-powered briefings, phased workout progression, and cloud-backed session tracking.

## Setup

1. Install Flutter 3.27+ and Dart SDK 3.12+
2. `flutter pub get`
3. Copy `.env.example` to `.env` and fill in:
   ```
   OPENROUTER_API_KEY=sk-or-v1-your-key-here
   ```
4. (Optional) Firebase for cloud backup:
   - Go to https://console.firebase.google.com/ and create a project
   - Register an iOS app with bundle ID `com.alexw.pft`
   - Download `GoogleService-Info.plist` and drag it into `ios/Runner/`
   - **Authentication > Sign-in method > Anonymous** → Enable
   - **Firestore > Create Database** → Production mode → paste [`firestore.rules`](firestore.rules) → Publish

## Run

```bash
flutter run
```

## GitHub Remote Config

Set in `.env`:
```
REMOTE_CONFIG_URL=https://raw.githubusercontent.com/you/repo/main/config/ai.json
```

That JSON can contain:
- `models` — per-prompt model mapping (e.g., `{"briefing": "openrouter/free", "plan": "openrouter/free"}`)
- `prompts` — system prompts with `{{variable}}` injection (see [`assets/config/ai.json`](assets/config/ai.json) for format)
- `workouts_url` — URL to an external workout definitions JSON
- `weather_exercises` — exercise IDs for weather skip sessions
- `base_url` — API base URL override

All remote config fields are optional. Missing fields fall back to local defaults.

## Build for Device

### iOS (requires Apple Developer account)

```bash
open ios/Runner.xcworkspace
```
Set signing team in Xcode, then build from Xcode or:
```bash
flutter build ios --release
```

### Android

```bash
flutter build apk --release
```

## Project Structure

```
lib/
  core/
    progression_math.dart   Phase/streak calculations
    sanitize_response.dart  AI output cleanup
    theme/                  AppColors, AppTheme
  database/
    schemas/                Isar collection definitions
    isar_service.dart       DB initialization & migration
    exercise_loader.dart    Seeds exercises from JSON assets
    seed_demo_data.dart     Demo data generator
  services/
    openrouter_service.dart     AI API calls
    remote_config_service.dart  Live config from GitHub
    firestore_service.dart      Cloud backup (Firebase)
  state/
    progression_notifier.dart   Phase/streak/tier state machine
    session_notifier.dart       Active workout session state
    briefing_notifier.dart      AI briefing state with caching
  ui/
    pages/                  Dashboard, Workout, Journal, Progress, Settings
    widgets/                Reusable components
```

## Architecture

- **Data**: Isar v3 (embedded, local-first) + Firestore (cloud backup)
- **State**: Riverpod 2.x with Notifier/AsyncNotifier pattern
- **AI**: OpenRouter with configurable model per prompt type, `{{variable}}` injection, output sanitization
- **Config**: Local `assets/config/ai.json` + optional GitHub remote override
- **Exercises**: 80 exercises across 7 categories, loaded from JSON assets or remote URL
- **Auth**: Anonymous Firebase Auth (no sign-up, data survives reinstall)
- **Progression**: 5 phases, session-based with streak tracking and regression logic
