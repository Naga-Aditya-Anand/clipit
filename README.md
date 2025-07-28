# ClipIt

**ClipIt** is a Universal Clipboard Flutter application that allows users to copy and share content seamlessly across devices and platforms. This project is intended as a starting point for building clipboard synchronization functionality with Flutter.

## Features

- Universal clipboard: Copy and share data across devices.
- Firebase integration: Uses Firestore, Auth, and Storage for real-time data sync and authentication.
- Multi-platform support: Runs on Android, iOS, Windows, and Web.
- Modern Flutter architecture: Follows best practices, allowing easy customization and extension.

## Getting Started

This is a Flutter application. If you're new to Flutter, check out the following resources:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- A Firebase project ([instructions here](https://firebase.google.com/docs/flutter/setup?platform=ios))
- Dart installed (comes with Flutter)
- Platform SDKs (Android Studio/Xcode/Visual Studio for respective platforms)

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Naga-Aditya-Anand/clipit.git
   cd clipit
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Configure Firebase:**
   - Replace `lib/firebase_options.dart` with your Firebase credentials. You can use the [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/) to generate this file.

4. **Run the app:**
   - For Android/iOS:
     ```sh
     flutter run
     ```
   - For Web:
     ```sh
     flutter run -d chrome
     ```
   - For Windows:
     ```sh
     flutter run -d windows
     ```

## Usage

- Register or log in using your Firebase account.
- Copy content on one device; it is instantly available on other signed-in devices.
- Supports images and text (with Firebase Storage).
- Designed for easy and intuitive sharing.

## Project Structure

- `lib/` - Main application logic
  - `Screen/` - UI screens (e.g., home.dart)
  - `firebase_options.dart` - Firebase configuration
- `android/`, `ios/`, `web/`, `windows/` - Platform-specific code and build files
- `assets/` - Images and static assets

## Dependencies

- [`cloud_firestore`](https://pub.dev/packages/cloud_firestore)
- [`firebase_auth`](https://pub.dev/packages/firebase_auth)
- [`firebase_core`](https://pub.dev/packages/firebase_core)
- [`firebase_storage`](https://pub.dev/packages/firebase_storage)
- [`irondash_engine_context`](https://pub.dev/packages/irondash_engine_context)
- [`super_native_extensions`](https://pub.dev/packages/super_native_extensions)

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the [MIT License](LICENSE).

## Author

Made by [Naga-Aditya-Anand](https://github.com/Naga-Aditya-Anand)
