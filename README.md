# 🍲 Nosh - Meal Planning & Recipe Discovery App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

Nosh is a beautiful, modern Flutter application that simplifies your daily meal planning and cooking routines. Discover new recipes, organize your favorites, manage dietary preferences, and keep track of your weekly meal schedule and grocery needs—all in one seamless, intuitive interface. ✨

## 🎥 Video Demo

*(Upload your video demo here)*

## 🌟 Key Features

- **🏠 Kitchen Dashboard**: A comprehensive home screen featuring quick searches, meal statistics, and featured picks to inspire your daily cooking.
- **📚 Categorized Recipes**: Browse through a curated collection of meals neatly organized by category (e.g., Italian, Quick & Easy, Breakfast).
- **❤️ Favorites Management**: Easily bookmark recipes you love and build your personal collection of go-to meals for quick access.
- **🥗 Dietary Filters**: Powerful filtering options that allow you to exclude recipes based on your dietary requirements, including Gluten-Free, Lactose-Free, Vegetarian, and Vegan preferences.
- **📅 Weekly Planner**: Organize your upcoming meals day by day, making it easy to see exactly what you're cooking for the week.
- **🛒 Smart Shopping List**: Keep track of the ingredients you need. Add items directly to your shopping list, check them off as you shop, or clear them when done.
- **🌓 Adaptive Theming**: Full support for both Light and Dark modes, ensuring an optimal viewing experience in any lighting condition.

## 🛠️ Technologies & Architecture

Nosh is built using modern Flutter development practices and robust state management.

- **Framework**: [Flutter](https://flutter.dev/) 🚀 (SDK ^3.11.5)
- **Language**: [Dart](https://dart.dev/) 🎯
- **State Management**: [Riverpod](https://riverpod.dev/) 🌊 (`flutter_riverpod` ^3.3.1) - ensures scalable, testable, and robust state propagation throughout the app.
- **Typography**: [Google Fonts](https://pub.dev/packages/google_fonts) 🔤 for sleek, customizable typography across all platforms.
- **Images**: `transparent_image` 🖼️ package used for smooth and aesthetically pleasing image loading transitions.

## 📂 Project Structure

The project directory follows a clean, feature-driven architecture to keep code maintainable:

```text
lib/
├── data/                  # 🗄️ Static dummy data and initialization assets
├── models/                # 🧩 Core domain data models (Meal, Category)
├── providers/             # 📡 Riverpod state providers (Favorites, Filters, Planner, Search)
├── screens/               # 📱 Main application pages and navigation routes
├── theme/                 # 🎨 Global UI themes, colors, and dimension constants
├── utils/                 # ⚙️ Utility functions and helper classes
├── widgets/               # 🧱 Reusable UI components segmented by feature (e.g., home, meal)
└── main.dart              # 🚀 Application entry point and ProviderScope setup
```

## 🚀 Getting Started

### 📋 Prerequisites

Ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 🐦 (3.11.5 or higher)
- [Dart SDK](https://dart.dev/get-dart) 🎯

### 💻 Installation

1. **Clone the repository**:
   ```bash
   git clone <repository_url>
   cd new_meals_app
   ```

2. **Fetch dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

## 🏗️ Building for Production

To generate release builds for your specific platform:

**🤖 Android (APK):**
```bash
flutter build apk --release
```

**🍎 iOS:**
```bash
flutter build ios --release
```

## 🔒 Privacy & Security

- **💾 Local Storage**: Currently, Nosh stores user preferences and saved data (favorites, planner, shopping list) locally on your device.
- **🛡️ Data Collection**: Nosh does not collect or transmit personal user data to any external servers. All operations remain entirely on-device, ensuring complete privacy.

---
*Nosh - Making cooking easier, one meal at a time.* 👨‍🍳👩‍🍳
