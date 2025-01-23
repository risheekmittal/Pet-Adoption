# Pet Adoption App

A **Flutter-based Pet Adoption App** that allows users to browse and adopt pets. This application demonstrates best practices for clean code architecture, state management using BLoC, and integration with REST APIs.

---

## Features

- **Home Screen**: Browse a list of pets available for adoption.
- **Search Functionality**: Search for pets by name.
- **Filters**: Sort pets by price (low to high, high to low) or view only adopted pets.
- **Details Screen**: View detailed information about each pet.
- **Adoption History**: Keep track of adopted pets.
- **Dark Theme Support**: Toggle between light and dark modes.
- **Clean Code Principles**:
  - SOLID principles
  - BLoC pattern for state management
  - Modular and maintainable architecture
- **Additional Features**:
  - Pagination for pet list.
  - Confetti animation on successful adoption.
  - Zoomable pet images.

---

## Screenshots

### 1. Home Screen
<image src="https://github.com/user-attachments/assets/9eb48d09-bae7-49e7-8b8e-bf9eab46fa38" width=100>

### 2. Filter Dialog
 <image src="https://github.com/user-attachments/assets/f1551acb-9f9b-4fbd-a0a0-552203c57c59" width=100>

### 3. Search Pets
<image src="https://github.com/user-attachments/assets/9a46dad1-902f-4231-a03e-c5702ed71849" width=100>

### 4. Pet Details
<image src="https://github.com/user-attachments/assets/61f89af3-5eeb-4da3-afeb-bf3803928a6a" width=100>

### 5. Adoption History
<image src="https://github.com/user-attachments/assets/507b2f9c-25aa-4981-a337-2e2a57942360" width=100>

---

## How to Run the App

### Prerequisites

- Flutter SDK installed ([installation guide](https://docs.flutter.dev/get-started/install)).
- Dart SDK.
- Code Editor (e.g., VS Code or Android Studio).

### Steps to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/pet-adoption-app.git
   cd pet-adoption-app
   ```

2. Fetch dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

4. (Optional) Run tests:
   ```bash
   flutter test
   ```

---

## Project Structure

```plaintext
lib/
├── bloc/             # BLoC files for state management
├── models/           # Data models (e.g., Pet)
├── screens/          # UI screens (e.g., HomeScreen, DetailsScreen)
├── widgets/          # Reusable widgets (e.g., PetCard)
├── main.dart         # Application entry point
```

---

## Key Technologies

- **Flutter** for cross-platform development.
- **BLoC** for state management.
- **REST APIs** for fetching pet images and data.
- **Shared Preferences** for local storage.
- **HTTP Package** for API integration.

---

## Credits

- **Pet Images**: [Dog CEO API](https://dog.ceo/dog-api/)
- App developed with love using Flutter.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact

For any questions or feedback, feel free to reach out:

- **Email**: mittal.risheek@gmail.com
- **GitHub**: [risheekmittal](https://github.com/risheekmittal)
