# Meals App 🍽️

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

A beautiful and feature-rich recipe and meal tracking application built with Flutter. This app allows users to browse different categories of meals, view detailed recipes, and manage their favorite dishes. 

## ✨ Features

*   **Categorized Meals**: Browse meals by diverse categories (e.g., Italian, Quick & Easy, Hamburgers).
*   **Meal Details**: Detailed view for each meal including ingredients, steps, duration, complexity, and affordability.
*   **Favorites System**: Users can mark meals as favorites to easily access them later.
*   **Filters**: Advanced filtering options (Gluten-free, Lactose-free, Vegetarian, Vegan) to tailor the meal selection to specific dietary requirements.
*   **Tab Navigation**: Seamless navigation between categories and favorite meals using a bottom tab bar.
*   **Side Drawer**: Easy access to the filters screen via a custom navigation drawer.
*   **Modern UI**: Beautiful dark theme utilizing Material 3 design and Google Fonts (Lato).

## 📱 Screenshots

> Add screenshots of your app here.
> 
> | Categories | Meals List | Meal Details | Filters |
> |:---:|:---:|:---:|:---:|
> | <img src="screenshots/categories.png" width="200"> | <img src="screenshots/meals.png" width="200"> | <img src="screenshots/details.png" width="200"> | <img src="screenshots/filters.png" width="200"> |

## 🏗️ Project Structure

The project follows a standard Flutter folder structure with a clean separation of concerns:

*   `lib/`
    *   `data/`: Contains dummy data or data providers.
    *   `models/`: Data models (`category.dart`, `meal.dart`).
    *   `screens/`: Application screens (`categories.dart`, `meals.dart`, `meal_details.dart`, `filters.dart`, `tabs_screen.dart`).
    *   `widgets/`: Reusable UI components (`category_grid_item.dart`, `meal_item.dart`, `main_drawer.dart`, etc.).
    *   `main.dart`: Entry point of the application and theme configuration.

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.7.2 or higher)
*   [Dart SDK](https://dart.dev/get-dart)
*   An IDE like [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter plugins installed.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/meals_app.git
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd meals_app
    ```
3.  **Get Flutter packages:**
    ```bash
    flutter pub get
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

## 📦 Dependencies

*   [`cupertino_icons`](https://pub.dev/packages/cupertino_icons): ^1.0.8 - iOS style icons.
*   [`google_fonts`](https://pub.dev/packages/google_fonts): ^6.2.1 - Typography utilizing the Lato font family.
*   [`transparent_image`](https://pub.dev/packages/transparent_image): ^2.0.1 - Used for smooth image loading placeholders.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check [issues page](https://github.com/yourusername/meals_app/issues).

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.
