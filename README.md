# Currency Converter App
A simple yet powerful Flutter app for converting currencies in real-time with a user-friendly interface.

## Features
- Real-time currency conversion
- Supports multiple international currencies
- Clean and intuitive UI
- Fast and accurate exchange rate fetching

## Installation
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Chitravansh/Currency_Converter_Flutter.git
   cd currency-converter-app
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the App:**
   ```bash
   flutter run
   ```

## Usage
1. Select the desired currencies for conversion.
2. Enter the amount in the input field.
3. The converted value will be displayed instantly.

## Project Structure
```
/lib
 ├── api.dart
 ├── currency_converter_material_page.dart
 └── main.dart

```

## API Integration
The app fetches live exchange rates using the **ExchangeRate-API**. Ensure you add your API key in the `api.dart` file:
```
apiKey = your_api_key_here
```

## Contributing
Contributions are welcome! Follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/new-feature`).
3. Commit your changes (`git commit -m "Add new feature"`).
4. Push to the branch (`git push origin feature/new-feature`).
5. Create a Pull Request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

