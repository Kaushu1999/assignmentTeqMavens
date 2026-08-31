# Assignment

A Flutter hotel booking UI assignment with a dark visual style, custom image assets, and bottom-tab navigation across the main app sections.

## Features

- Dashboard with greeting, location search, and resort/property cards.
- Hotel resort detail screen with a swipeable hero image gallery, host details, rating, dates, address, and description.
- Booking screen with a month calendar powered by `table_calendar`.
- Profile screen and slide-out side menu.
- Shared app background, color, spacing, text-style, and asset constants.

## Tech Stack

- Flutter
- Dart SDK `^3.10.8`
- `google_fonts`
- `table_calendar`
- `cupertino_icons`

## Project Structure

```text
lib/
  main.dart
  core/
    constants/
    widgets/
  features/
    booking_hotel/
    dashboard/
    hotel_resort/
    profile/
assets/
  icons/
  images/
test/
```

## Getting Started

Make sure Flutter is installed and available in your terminal.

```bash
flutter pub get
flutter run
```

To run tests:

```bash
flutter test
```

To analyze the project:

```bash
flutter analyze
```

## Assets

Image and icon assets are registered in `pubspec.yaml`:

```yaml
assets:
  - assets/images/
  - assets/icons/
```

Add new images or icons to these folders so Flutter can bundle them automatically.
