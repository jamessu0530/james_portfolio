## James Portfolio (Flutter iOS)

Minimal iOS-style portfolio app for **James Su** with a draggable **life timeline**.

### Features

- **About Me**: bilingual (繁體中文 / English) profile, education, skills, projects.
- **Interactive Timeline**: year-based sections, drag to reorder, auto-update year, create earlier years by dragging to top.
- **Images**:
  - Timeline events: supports both `Image.asset` and gallery images via `image_picker`.
  - Avatar: tap profile avatar to pick your own photo from the gallery.
- **Theming**: light / dark mode toggle, Apple-like colors and glassy cards.

### Main Structure

- `lib/main.dart` – app entry, language + theme + avatar state.
- `lib/data/profile_data.dart` – all profile content (text, skills, projects, experience).
- `lib/screens/home_screen.dart` – scrollable portfolio home (profile + sections).
- `lib/widgets/`:
  - `profile_header.dart` – avatar, name, social links (GitHub / LinkedIn / Medium).
  - `glass_card.dart`, `section_title.dart`, `skill_section.dart`, `project_card.dart`, `info_sections.dart`.
  - `timeline_card.dart`, `timeline_image.dart`, `timeline_year_header.dart`, `timeline_editor_dialog.dart`.
- `lib/pages/timeline_page.dart` – draggable year-based timeline screen.
- `lib/models/` – `AppLanguage`, `L10n`, `TimelineEvent` data models.
- `lib/services/timeline_storage.dart` – in-memory timeline storage (ready to swap to Hive / SharedPreferences).

### Run

```bash
flutter pub get
flutter run
```

