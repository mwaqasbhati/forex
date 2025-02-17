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

<img width="347" height="400" alt="Screenshot 2025-02-17 at 10 33 21 PM" src="https://github.com/user-attachments/assets/323ac965-43fd-40e6-ae73-1119144303da" />

Demo:


https://github.com/user-attachments/assets/b780dd04-450e-4cfe-a18d-a7156aded294

Unit Tests:


<img width="736" height="350" alt="Screenshot 2025-02-17 at 10 32 51 PM" src="https://github.com/user-attachments/assets/675ecb73-d82e-47c2-a41f-ebb04d913730" />


## Contributions
Contributions are welcome! Feel free to open issues and submit pull requests.

## License
This project is licensed under the MIT License.

## Contact
For any inquiries, reach out to [your email or GitHub profile].

