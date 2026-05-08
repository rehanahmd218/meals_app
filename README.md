# Nosh

A Flutter meal planning app that makes cooking easier. Browse recipes, save your favorites, filter by dietary preferences, and plan your week ahead.

## What's Included

**Kitchen** - Your home dashboard with quick access to everything

**Categories** - Browse meals organized by type. Pick a category and see all the recipes available

**Favorites** - Tap the star icon on any recipe to save it. Build your personal collection of go-to meals

**Filters** - Narrow down recipes by dietary needs. Whether you're vegetarian, gluten-free, or watching calories, filter to find what works for you

**Weekly Planner** - Plan out your meals for the week. Stay organized and avoid the "what's for dinner?" scramble

**Shopping List** - Add ingredients you need to buy. Check them off as you shop, or clear the list when you're done

**Dark Mode** - Switch between light and dark themes based on your preference

## Getting Started

### Requirements

- Flutter 3.11.5 or higher
- Dart 3.11.5 or higher

### Installation

1. Clone the repo or extract the project
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to launch the app

## Tech Stack

- **Flutter** - UI framework
- **Riverpod** - State management
- **Google Fonts** - Typography

## Building APK or iOS App

```bash
# Android release build
flutter build apk --release

# iOS release build
flutter build ios --release
```

## How to Use

- **Browse**: Start in Kitchen or Categories to explore recipes
- **Save**: Found something you like? Tap the star to save it to Favorites
- **Filter**: Use the filter menu to narrow down recipes by your dietary preferences
- **Plan**: Head to Weekly Planner to organize your meals
- **Shop**: Add ingredients to your Shopping List while planning meals

## Project Structure

```
lib/
├── main.dart              # App entry point
├── screens/               # App pages
├── widgets/               # Reusable UI components
├── providers/             # State management with Riverpod
├── models/                # Data models
├── data/                  # Dummy data
├── theme/                 # Color and styling
└── utils/                 # Helper functions
```

## Feedback

This is a work in progress. More features and improvements coming soon!
