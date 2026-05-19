# 💸 Expense Tracker

A sleek, modern, and intuitive expense tracking application built with Flutter. Manage your finances effortlessly with beautiful visualizations, dark mode support, and multi-currency options.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Flutter](https://img.shields.io/badge/Flutter-v3.0+-02569B?logo=flutter)

## ✨ Features

- **📊 Visual Insights**: View your spending habits through interactive pie charts and linear progress bars.
- **🌍 Multi-Currency Support**: Track expenses in **USD ($)**, **INR (₹)**, **AED (AED)**, or **EUR (€)**.
- **🌓 Adaptive Theme**: Seamlessly switch between Light and Dark modes with smooth animations.
- **📂 Categorization**: Organize expenses into categories like Food, Transport, Shopping, Bills, Entertainment, Health, and more.
- **📝 Detailed Logs**: Add titles, amounts, dates, and optional notes to every transaction.
- **💾 Local Persistence**: All data is stored securely on your device using SQLite.
- **⚡ Fast & Fluid**: Built with a focus on performance and smooth UX transitions.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Database**: [sqflite](https://pub.dev/packages/sqflite) (SQLite)
- **Charts**: [fl_chart](https://pub.dev/packages/fl_chart)
- **Persistence**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **UI/UX**: Custom animations, Google Fonts, and Material 3 design.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Android Studio / VS Code
- An Android/iOS Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/expense_tracker.git
   cd expense_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📸 Screenshots

| Home Screen | Statistics | Add Expense | Dark Mode |
| :---: | :---: | :---: | :---: |
| ![Home](https://via.placeholder.com/200x400?text=Home+Screen) | ![Stats](https://via.placeholder.com/200x400?text=Statistics) | ![Add](https://via.placeholder.com/200x400?text=Add+Expense) | ![Dark](https://via.placeholder.com/200x400?text=Dark+Mode) |

*(Note: Replace placeholders with actual screenshots from the app)*

## 📂 Project Structure

```text
lib/
├── database/     # SQLite helper classes
├── models/       # Data models (Expense, Category)
├── providers/    # State management (Expense, Theme, Currency)
├── screens/      # Main UI screens
├── theme/        # App styling and themes
└── widgets/      # Reusable UI components
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! If you have any ideas or find a bug, please open an issue or submit a pull request.

---
Made with ❤️ by Aman Singh
