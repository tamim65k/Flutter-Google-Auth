# Flutter Google Auth - Flutter App

A modern Flutter application with Google Sign-In and email-password authentication, featuring a beautiful neumorphic UI design.

## Features

- 🔐 **Authentication**: Google Sign-In and Email/Password authentication
- 🎨 **Modern UI**: Neumorphic design with soft shadows and gradients
- 📱 **Responsive**: Works on all screen sizes
- 🔄 **State Management**: Riverpod for efficient state management
- 🚀 **Firebase Integration**: Real-time authentication with Firebase

## Screenshots

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <img src="assets/images/flutter_01.png" alt="Login Screen" width="300" style="border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
  <img src="assets/images/flutter_02.png" alt="Home Screen" width="300" style="border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
</div>

## Setup Instructions

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase account

### 1. FlutterFire CLI Configuration

#### Step 1: Install FlutterFire CLI
```bash
dart pub global activate flutterfire_cli
```

#### Step 2: Login to Firebase
```bash
firebase login
```

#### Step 3: Configure Firebase for your project
```bash
flutterfire configure
```

This will:
- Create a new Firebase project (or select existing)
- Enable Authentication, Firestore, and Storage
- Generate `firebase_options.dart` file
- Configure platform-specific settings

### 2. Firebase Console Setup

#### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name (e.g., "flutter-google-auth")
4. Enable Google Analytics (optional)
5. Click "Create project"

#### Step 2: Enable Authentication
1. In Firebase Console, go to **Authentication**
2. Click **Get started**
3. Go to **Sign-in method** tab
4. Enable **Email/Password**
5. Enable **Google** provider
6. Configure Google OAuth consent screen

#### Step 3: Configure Google Sign-In

**For Android:**
1. Go to **Project Settings** > **General**
2. Download `google-services.json`
3. Place it in `android/app/`
4. Add your SHA-1 fingerprint:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
5. Copy SHA-1 to Firebase Console > Project Settings > General > Your apps > Android app > Add fingerprint

**For iOS:**
1. Go to **Project Settings** > **General**
2. Download `GoogleService-Info.plist`
3. Place it in `ios/Runner/`
4. Add your Bundle ID to Firebase Console

#### Step 4: Get Server Client ID
1. Go to **Project Settings** > **General**
2. Scroll to **Your apps** section
3. Find the **Web app** configuration
4. Copy the **Client ID** (ends with `.apps.googleusercontent.com`)

### 3. Flutter Setup

#### Step 1: Clone the Repository
```bash
git clone <your-repo-url>
cd flutter-google-auth
```

#### Step 2: Install Dependencies
```bash
flutter pub get
```

#### Step 3: Configure Server Client ID
Create a `.env` file in the root directory:
```env
GOOGLE_SERVER_CLIENT_ID=your-server-client-id-here.apps.googleusercontent.com
```

#### Step 4: Run the App
```bash
flutter run
```

## Project Structure

```
lib/
├── features/
│   └── auth/
│       ├── pages/
│       │   └── login_page.dart
│       └── repository/
│           └── auth_service.dart
├── firebase_options.dart
└── main.dart
```

## Dependencies

- **firebase_auth**: Firebase Authentication
- **firebase_core**: Firebase Core
- **google_sign_in**: Google Sign-In
- **flutter_riverpod**: State Management
- **cupertino_icons**: iOS-style icons

## Authentication Flow

1. **Login Page**: Users can sign in with email/password or Google
2. **Form Validation**: Real-time validation with error messages
3. **Authentication**: Firebase handles user authentication
4. **Home Screen**: Displays user profile and quick actions
5. **Sign Out**: Users can sign out from the home screen

## Features

### Login Screen
- ✅ Email/password authentication
- ✅ Google Sign-In integration
- ✅ Real-time form validation
- ✅ Modern neumorphic design
- ✅ Error handling and user feedback

### Home Screen
- ✅ User profile display
- ✅ Authentication method indicator
- ✅ Quick action buttons
- ✅ Statistics cards
- ✅ Sign out functionality

## Troubleshooting

### Common Issues

1. **Google Sign-In fails**
   - Check SHA-1 fingerprint in Firebase Console
   - Verify `google-services.json` is in correct location
   - Ensure Google Sign-In is enabled in Firebase Console

2. **Build errors**
   - Run `flutter clean` and `flutter pub get`
   - Check Firebase configuration files
   - Verify all dependencies are installed

3. **Authentication errors**
   - Check Firebase Console for enabled providers
   - Verify server client ID in `.env` file
   - Test with different Google accounts

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support, please open an issue on GitHub or contact the development team.
