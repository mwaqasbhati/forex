# Forex Trading App

## Overview
This Flutter application provides real-time forex trading data, displaying a stock listing page and a detailed trade history screen. The app integrates WebSocket for live trade updates and presents data with interactive charts and a visually appealing UI.

## Features
- **Stock Listing Page**: Displays available forex symbols with real-time updates.
- **Trade History Screen**: Shows past trades for a selected forex symbol with dynamic updates.
- **Real-time WebSocket Integration**: Fetches and updates trade data live.
- **Interactive Line Chart**: Visual representation of price trends using `fl_chart`.
- **Trade List**: Displays trade history with percentage change indicators.

## Screens
### 1. Stock Listing Page
- Displays a list of forex symbols.
- Updates prices in real time.
- Clicking on a symbol navigates to the `HistoryScreen`.

### 2. Trade History Screen
- Fetches and displays trade history for the selected forex symbol.
- Updates in real-time using WebSocket.
- Includes a price overview card.
- Shows an interactive price trend chart.
- Lists historical trade records with percentage change indicators.

## Technologies Used
- **Flutter**: Cross-platform mobile app development.
- **Riverpod**: State management.
- **WebSocket**: Real-time data updates.
- **fl_chart**: Line chart visualization.
- **Intl**: Date and time formatting.

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/mwaqasbhati/forex.git
   cd forex
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```

## Project Structure
```
lib/
│── features/
│   ├── forex/
│   │   ├── models/
│   │   │   ├── forex_symbol.dart
│   │   │   ├── trade_model.dart
│   │   ├── provider/
│   │   │   ├── forex_symbol_provider.dart
│   │   │   ├── forex_websocket_provider.dart
│   │   ├── ui/
│   │   │   ├── stock_list_screen.dart
│   │   │   ├── history_screen.dart
│── main.dart
```

Screenshots:
![simulator_screenshot_ECF8394F-6B9F-44C0-868C-336B124BDAED](https://github.com/user-attachments/assets/ae02154e-e677-4c69-b956-264c4a930125)
![Simulator Screenshot - iPhone 16 - 2025-02-17 at 20 56 22](https://github.com/user-attachments/assets/188ff7aa-8b02-436a-b8fe-9acdbbfef94c)

Demo:


https://github.com/user-attachments/assets/b780dd04-450e-4cfe-a18d-a7156aded294





## Contributions
Contributions are welcome! Feel free to open issues and submit pull requests.

## License
This project is licensed under the MIT License.

## Contact
For any inquiries, reach out to [your email or GitHub profile].

