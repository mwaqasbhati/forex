# Forex Trading App

## 🚀 Overview
Welcome to the **Forex Trading App**! This Flutter-based mobile application delivers real-time forex trading data and offers an engaging and dynamic user experience. It features a stock listing page, a detailed trade history screen, and interactive charts, all powered by WebSocket for live updates. Whether you're tracking forex prices or analyzing trade history, this app has you covered with a visually appealing and responsive UI.

## 📱 Features
- **📊 Stock Listing Page**: Displays a list of forex symbols with real-time price updates.
- **📈 Trade History Screen**: View detailed past trades for any selected forex symbol, updated dynamically.
- **🌐 Real-time WebSocket Integration**: Get live data and updates with WebSocket for instant market insights.
- **📉 Interactive Line Chart**: Visualize price trends over time using the `fl_chart` package.


## 🖼️ Screens
### 1. **Stock Listing Page**
- View a list of available forex symbols.
- Real-time price updates.
- Tap a symbol to navigate to the **Trade History Screen** for more detailed insights.

### 2. **Trade History Screen**
- Displays detailed trade history for the selected forex symbol.
- Updated in real time using WebSocket for seamless data flow.
- Interactive price trend chart showing historical price movements.
- Price overview card for quick trade insights.
- Historical trade records with percentage change indicators for better analysis.

## 💻 Technologies Used
- **Flutter**: Cross-platform app development framework.
- **Riverpod**: State management solution for handling app state efficiently.
- **WebSocket**: Real-time data fetching and updates.
- **fl_chart**: Interactive line chart visualization for price trends.
- **Intl**: Date and time formatting library for consistent formatting across regions.

## 🛠️ Installation

To run the app locally, follow these simple steps:

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

## 📂 Project Structure
Here's an overview of the project's structure:
```
lib/
├── core/
│   ├── database/         # Local database setup and management
│   ├── dio/              # Dio HTTP client configuration
│   ├── utils/            # Utility functions (e.g., date formatting)
│   ├── features/forex/   # Forex trading features
│   ├── models/           # Data models (e.g., trade, symbol)
│   ├── presentation/     # UI components (screens, widgets)
│   ├── pages/            # Application pages
│   │   ├── history_screen.dart  # Trade history screen
│   │   ├── main_screen.dart     # Main stock listing page
├── widgets/              # Reusable UI components
├── provider/             # State management providers
├── repositories/         # Data repositories
│   ├── forex_repository.dart  # Forex data repository
├── services/             # Business logic services
│   ├── finnhub_service.dart  # Finnhub API service
│   ├── forex_websocket_service.dart  # WebSocket service for forex data
├── main.dart             # App entry point
```

## 📺 Demo
Check out a demo of the app here:

|  **Stock Listing Page**  | **Trade History Screen**  | **Price Trend Chart**  |
|--------------------------|---------------------------|------------------------|
| ![Stock Listing Page](https://github.com/user-attachments/assets/72f12fc8-9c13-4687-8429-2bb8ff21ab20) | ![Trade History](https://github.com/user-attachments/assets/cc810733-81b7-4126-8d75-dbdcb3e60697) | ![Price Trend](https://github.com/user-attachments/assets/ab488f0a-e813-4016-89bd-495cf3bfbfea) |
| *Stock List View*        | *Trade History Overview*  | *Price Trend Chart*    |


## Demo Video:


https://github.com/user-attachments/assets/d82b3e1b-a194-4b0a-b25b-15f50870f500



## 🔧 Unit Tests
Our unit tests ensure that the app runs smoothly. Here’s a glimpse of the test coverage:

![Unit Tests](https://github.com/user-attachments/assets/675ecb73-d82e-47c2-a41f-ebb04d913730)

## 🤝 Contributions
Contributions are always welcome! If you’d like to help improve this project, feel free to open an issue or submit a pull request.

## 📝 License
This project is licensed under the [MIT License](LICENSE).



## 📬 Contact
For inquiries or feedback, feel free to reach out via [m.waqas.bhati@hotmail.com].

---
