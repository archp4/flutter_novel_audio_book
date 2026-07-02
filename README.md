# novel_audiobook_version

A Flutter-based audiobook application that allows users to browse, search, and read novels with integrated Text-to-Speech (TTS) capabilities.

## Tech Stack
- **Language:** Dart, Kotlin, Swift, C++
- **Framework:** Flutter
- **State Management:** (Implicitly handled via local state and models)
- **Networking:** Dio
- **Key Libraries:**
  - `flutter_tts`: Text-to-Speech functionality
  - `scrollable_positioned_list`: Advanced scroll handling
  - `google_fonts`: Dynamic font loading
  - `permission_handler`: Device permission management
  - `path_provider`: File system access
  - `fast_cached_network_image`: Image caching
  - `carousel_slider`: UI carousels
  - `flutter_rating_bar`: User rating components

## Key Features
- **Audiobook Reading:** Integrated reader view with support for multi-chapter navigation and font customization.
- **Text-to-Speech (TTS):** Ability to listen to novels with customizable TTS states.
- **Novel Browsing:** Homepage featuring popular novels and carousel displays.
- **Search & Discovery:** Search functionality to find specific novels and details view for expanded information.
- **Media Management:** Support for local assets (images/files) and remote data fetching via Dio.
- **UI Components:** Custom widgets for tag tiles, sliders, rating bars, and responsive novel cards.

## Directory Structure
```text
lib/
├── models/                 # Data structures for novels, chapters, and UI states
├── services/               # API networking and service logic (e.g., Dio home service)
├── utilities/              # Helper functions for calculations, navigation, and formatting
├── views/                  # Main application screens (Homepage, Reader, Search, Details)
├── widgets/                # Reusable UI components (ReaderBar, AudioListener, etc.)
└── main.dart               # Application entry point
assets/                     # Static resources (Images, files, fonts)
android/                    # Android native configurations and Gradle builds
ios/                        # iOS native configurations and Xcode projects
web/                        # Web platform configurations
windows/                    # Windows native configurations and CMake builds
test/                       # Unit and widget tests
pubspec.yaml                # Project configuration and dependency management
```

## Getting Started

### Prerequisites
- Flutter SDK (>= 3.0.1)
- Dart SDK (>= 3.0.1)

### Installation
1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```bash
   cd flutter_novel_audio_book
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App
Run the project on your target device or emulator:
```bash
flutter run
```

At Last update README.md
