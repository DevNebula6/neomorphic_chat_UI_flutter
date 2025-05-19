# Neomorphic Chat Flutter

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/BLoC-13B9FD?style=for-the-badge&logo=flutter&logoColor=white" alt="BLoC"/>
  <img src="https://img.shields.io/badge/Clean_Architecture-16A085?style=for-the-badge" alt="Clean Architecture"/>
</p>

A modern Flutter chat application with a beautiful neomorphic design. This project showcases clean architecture, BLoC state management, and elegant minimalist UI design principles.

![App Preview](assets/app_preview.png)

## 🌟 Features

- 🎨 **Neomorphic UI Design**: Soft, elegant, and modern interface following neomorphic design principles
- 🤖 **Simple Chatbot**: Hardcoded responses to common questions for demonstration
- 🔐 **Authentication System**: Email/password authentication with registration capability
- 🔄 **State Management**: BLoC pattern for clean, predictable state management
- 💾 **Local Storage**: Persistence using Shared Preferences
- 🏗️ **Clean Architecture**: Separation of concerns, maintainable and testable code

## 📱 App Showcase

### Authentication Screens
- Smooth onboarding experience
- Registration with input validation
- Login with secure authentication
- Persistent sessions

### Chat Interface
- Clean, minimalist chat bubbles
- Neomorphic input field and buttons
- Automated responses
- Conversation management

## 🏗️ Architecture

This project follows **Clean Architecture** principles to ensure:
- Separation of concerns
- Code maintainability
- Testability
- Scalability

### Architecture Layers

#### 1. Presentation Layer
- UI components (screens, widgets)
- BLoC for state management
- Handling user interactions

#### 2. Domain Layer
- Business logic
- Models (User, ChatMessage)
- Repository interfaces

#### 3. Data Layer
- Repository implementations
- Data sources (local storage)
- External services

## 📋 State Management with BLoC

The app uses the BLoC (Business Logic Component) pattern for state management, which:
- Separates business logic from UI
- Provides unidirectional data flow
- Makes the app more testable and maintainable

### Key BLoC Components:

#### Authentication BLoC
- `AuthBloc`: Main BLoC class handling authentication logic
- `AuthEvent`: Represents actions like SignIn, Register, SignOut
- `AuthState`: Represents various states (LoggedIn, LoggedOut, etc.)

## 📱 Neomorphic Design

This app showcases **Neomorphic Design**, a modern UI approach that:
- Creates soft UI elements that appear to extrude from the background
- Uses subtle shadows to create depth
- Maintains a minimalist and clean aesthetic

### Neomorphic Components:
- Custom buttons with pressed/unpressed states
- Soft input fields
- Chat bubbles with depth
- Dialog boxes with 3D effect
- Neomorphic app logo

## 🔐 Authentication System

The app implements a demo authentication system using:
- Shared Preferences for local data storage
- BLoC pattern for business logic
- Mock backend service for demonstration

### Features:
- User registration with validation
- Email/password login
- Session persistence
- Secure logout

## 📁 Project Structure

```
lib/
├── Auth/                   # Authentication components
│   ├── bloc/               # BLoC pattern implementation
│   │   ├── auth_bloc.dart  # Auth business logic
│   │   ├── auth_event.dart # Events to trigger state changes
│   │   └── auth_state.dart # Different auth states
│   ├── auth_provider.dart  # Auth provider interface
│   ├── auth_service.dart   # Auth service implementation
│   ├── cache_manager.dart  # Local storage management
│   ├── exception.dart      # Custom auth exceptions
│   └── mock_auth_provider.dart # Mock implementation for demo
│
├── models/                 # Data models
│   ├── chat_message.dart   # Chat message structure
│   └── user_model.dart     # User data structure
│
├── screens/                # UI screens
│   ├── home_screen.dart    # Main chat screen
│   ├── onboarding_page.dart # Initial onboarding
│   ├── register_page.dart  # User registration
│   └── sign_in_page.dart   # User login
│
├── utilities/              # Utility classes and widgets
│   ├── widgets/            # Reusable widgets
│   │   ├── button_neomorphic.dart    # Custom buttons
│   │   ├── chat_bubble_neomorphic.dart # Chat bubbles
│   │   ├── chat_input_neomorphic.dart  # Message input
│   │   ├── dialog_neomorphic.dart      # Custom dialogs
│   │   ├── logo_neomorphic.dart        # App logo
│   │   └── textfield_neomorphic.dart   # Custom input fields
│   └── Text_styles.dart    # Typography styles
│
└── main.dart               # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter (latest stable version)
- Dart SDK
- An IDE (VS Code, Android Studio, etc.)

## 📝 Usage

### Authentication
The app provides a demo authentication system:
- Register with email/password
- Login with credentials
- Data is stored locally with Shared Preferences

### Chatbot
The chat interface features a simple bot that responds to keywords:
- Try asking "Tell me a joke"
- Ask for "help" to see what it can do
- Say "hi" to start a conversation

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add some amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The BLoC library developers
- All contributors who helped shape this project

---

⭐️ If you find this project helpful, please give it a star on GitHub! ⭐️
