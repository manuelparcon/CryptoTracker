# 📱 CryptoTracker

## Overview
This practice project allows users to track real-time cryptocurrency data fetched from an external API and to manage a simulated investment portfolio. The primary focus of this project is implementing a clean, scalable architecture and mastering the asynchronous data flow, data persistence, and multi-threading essential for production applications.

> 💡 **Built to showcase:** Combine, Networking, CoreData, Observation (migrated from ObservableObject), Multi-threading, MVVM.

## Tech Stack

| Category | Technologies |
|:---|:---|
| Language | Swift |
| Framework | SwiftUI, Combine, CoreData, Observation, ObservableObject(refactored out), FileManager |
| Architecture | MVVM |
| Tools | Xcode, GitHub, GitFork |

## Features

1. View a list of crypto data from API.
2. View details of the coins including a chart for coin price.
3. Search coins.
4. Add own coins for portfolio.

## Screenshots

<div align="left" style="display: flex; flex-wrap: wrap; justify-content: center;">
  <img src="https://github.com/user-attachments/assets/f7a839b5-5463-42b4-a015-6b775b93651f" width="230" style="margin: 10px;" />
  <img src="https://github.com/user-attachments/assets/4cff5a51-5cbb-492f-b592-f23844fa30df" width="230" style="margin: 10px;" />
  <img src="https://github.com/user-attachments/assets/cfc9ea14-83d3-471b-8217-19c0badf65b0" width="230" style="margin: 10px;" />
  <img src="https://github.com/user-attachments/assets/2249bdec-7812-4475-b163-fb1741e4ce9d" width="230" style="margin: 10px;" />
</div>

## Lessons Learned

* **Reactive Programming, Asynchronous Programming, Networking:** Implemented data fetching from API, decoding of downloaded JSON data, and processing data (e.g. filtering for search) using Combine.
* **Data Persistence:** Use of CoreData to persist API and user data and FileManager to persist images.
* **Scalable Architecture:** Applied MVVM and service layers to handle data, resulting in ViewModels that may easily be testable and Views that remain simple and focused on UI logic.
* **Custom UI Development:** Developed custom SwiftUI views (e.g. custom tab bar, reusable card components).
* **Performance Optimization:** Use of LazyHStack, LazyGrid, and a custom NavigationLink for lazy loading.

## 📚 References/Attributions
* Developed by following the [SwiftUI Crypto App playlist](https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu) by Swiftful Thinking.
* Powered by [CoinGecko API](https://www.coingecko.com/en/api/).
