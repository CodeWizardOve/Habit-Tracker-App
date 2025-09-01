# habit_tracker_app

📱 Habit Tracker App

A simple and intuitive Flutter-based Habit Tracker to help users build and maintain good habits consistently.
The app allows users to create habits, track daily progress, and view statistics over time.

🚀 Features

✅ User Authentication (Login & Signup with Firebase)

📅 Add, Edit, and Delete Habits

⏰ Daily/Weekly habit progress tracking

📊 Habit streaks and progress visualization

🌙 Light & Dark Mode support

🔔 (Optional) Push Notifications/Reminders

🛠️ Tech Stack

Framework: Flutter (Dart)

Backend/Database: Firebase (Authentication & Firestore/Realtime DB)

State Management: Provider / Riverpod / GetX (depending on your project)

Other Tools: SharedPreferences (local storage), Cloud Firestore

assets/
│── images/                # App images/icons
⚙️ Installation & Setup
Follow these steps to run the project locally:

Clone the repository

bash
Copy code
git clone https://github.com/your-username/habit-tracker-app.git
cd habit-tracker-app
Install dependencies

bash
Copy code
flutter pub get
Connect Firebase

Create a Firebase project in Firebase Console.

Enable Authentication and Firestore Database.

Download google-services.json (for Android) and GoogleService-Info.plist (for iOS).

Place them in the respective platform folders:

android/app/google-services.json

ios/Runner/GoogleService-Info.plist

Run the app

bash
Copy code
flutter run

🤝 Contributing

Contributions are welcome!

Fork the repository

Create a new branch (feature/your-feature)

Commit your changes

Push and open a Pull Request

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
