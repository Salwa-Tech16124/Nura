# NURA Frontend - Flutter Application

## 1. Project Overview
This repository contains the Flutter frontend for **NURA**, an AI-powered Care Copilot. This frontend is designed strictly as the presentation and state management layer, completely decoupled from business logic, APIs, and database management. It will later communicate with a FastAPI backend and an AI Engine being developed by the rest of the team.

## 2. Professional Frontend Architecture
NURA follows a **Clean Architecture** inspired approach, separating concerns into distinct, modular layers:
- **UI/Presentation Layer (`screens/`, `widgets/`)**: Pure UI components strictly following the provided UI/UX designs. No API calls or business logic exist here.
- **State Management Layer (`providers/`)**: Holds the application state and reacts to user input. It requests data from the service layer and feeds it to the UI.
- **Service Layer (`services/`)**: Acts as the interface to the outside world. Responsible for making REST API calls to the FastAPI backend.
- **Domain Layer (`models/`)**: Strongly typed data classes mapping to JSON structures defined by the backend.

## 3. Folder Structure
The project is structured to easily scale as new modules (e.g., Emergency SOS, Daily Wellness) are integrated:

```text
frontend/
├── assets/                  # Local assets (images, fonts, animations)
└── lib/
    ├── core/                # Core configurations and app-wide settings
    │   ├── config/          # Environment variables and API endpoints
    │   ├── constants/       # Hardcoded strings, enums, dimensions
    │   ├── routes/          # Navigation and deep-linking config
    │   └── theme/           # Colors, typography, and component themes
    ├── models/              # Data classes and JSON serialization
    ├── providers/           # State management (Riverpod)
    ├── screens/             # UI screens organized by feature/module
    ├── services/            # API communication and data fetching
    ├── utils/               # Helper functions, formatters, extensions
    ├── widgets/             # Reusable, shared UI components
    └── main.dart            # Application entry point
```

## 4. State Management Approach

### Comparison
- **Provider**: Easy to learn and straightforward, but relies heavily on the widget tree (`BuildContext`) which makes services and logic harder to test outside of UI.
- **BLoC**: Extremely robust and strictly enforces separation of events and states. However, it requires a lot of boilerplate code, which can slow down rapid development in a hackathon setting.
- **Riverpod**: The modern, safer evolution of Provider. It is compile-time safe, does not depend on the widget tree, and makes dependency injection and testing incredibly easy.

### Recommendation: **Riverpod**
**Why Riverpod?** It provides the perfect balance between scalability and speed. It handles asynchronous data (like fetching APIs) beautifully via `FutureProvider` and `AsyncValue`, reducing the need to write repetitive boilerplate loading/error states for every screen. It is perfect for a hackathon while maintaining enterprise-level quality.

## 5. Navigation Architecture
We recommend using **GoRouter** for declarative navigation.
- **Why?** It handles deep linking easily, supports nested routes (great for bottom navigation bars), and cleanly separates navigation logic from UI code.
- **Structure**: All routes are centrally defined in `lib/core/routes/app_routes.dart`.

## 6. Reusable Widget Architecture
Widgets should be highly modular. Avoid writing 500-line `build()` methods.
Shared components go into `lib/widgets/`:
- **`CustomButton`**: Standardized tap targets.
- **`CustomTextField`**: Uniform inputs for forms.
- **`CustomCard`**: Unified container styles for health metrics and reminders.
- **`LoadingWidget` / `ErrorWidget` / `EmptyStateWidget`**: Standardized states for async operations, essential for Riverpod `AsyncValue` handling.

## 7. Theme Architecture
Theming is centralized in `lib/core/theme/` to maintain consistency across the app without hardcoding values in widgets:
- **`app_colors.dart`**: Defines semantic colors (e.g., `primary`, `error`, `surface`).
- **`app_typography.dart`**: Defines text styles based on the design system.
- **`app_theme.dart`**: The `ThemeData` object configuring buttons, inputs, and cards globally. Future-ready for Dark Mode switching.

## 8. Coding Standards
- **Folder Naming**: `snake_case` (e.g., `ai_assistant/`)
- **File Naming**: `snake_case` (e.g., `home_screen.dart`)
- **Class Naming**: `PascalCase` (e.g., `HomeScreen`)
- **Widget Naming**: Descriptive UI suffixes (e.g., `PrimaryButton`, `PatientCard`)
- **Constants**: Static properties inside `PascalCase` classes (e.g., `AppConstants.apiBaseUrl`)
- **Comments**: Use `///` for documentation comments describing public methods, services, and complex widgets.

## 9. Future Integration Notes (Backend & AI)
This architecture guarantees that the frontend will integrate smoothly with the FastAPI and AI modules without structural changes:
- **No Direct AI Communication**: The frontend will **never** call the AI directly. It will call a FastAPI endpoint (e.g., `/api/v1/ai/chat`), and FastAPI will handle the AI logic and database lookups.
- **Service Placeholders**: The `services/` folder currently contains placeholder classes. When the backend is ready, these classes will be updated to include `http` or `dio` network calls.
- **JSON Contracts**: Ensure that the Flutter `models/` exactly match the JSON responses provided by the FastAPI developers to avoid serialization errors.
