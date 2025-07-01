<h1 align="center">SEA Catering</h1>
<h3 align="center">Healthy Meals, Anytime, Anywhere</h3>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Flutter-blue" alt="Platform">
  <img src="https://img.shields.io/badge/dart-3.0.5-blue" alt="Dart Version">
  <img src="https://img.shields.io/github/stars/favjiw/seacatering?style=social" alt="GitHub Repo stars">
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/aefbc4d1-4bb3-476f-a38c-8c9ebceb1687" alt="image" />
</p>

## Table of Contents

- [Getting Started](#getting-started)
- [Demo](#demo)
- [Features](#features)
- [Architecture](#architecture)
- [Dependencies](#dependencies)

## Getting Started

Follow these steps to set up the project locally:

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Firebase configuration for real-time database and notifications.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/favjiw/seacatering.git

2. Navigate to the project directory:

    ```bash
    cd seacatering
    
3. Install the necessary dependencies:

    ```bash
   flutter pub get
  
5. Run the app:

    ```bash
   flutter run

## Demo
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/484155d8-c013-4be0-b825-5b02d7a60439" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/917fdd62-104f-4620-b280-822f395c42bd" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/2a2f7062-1ca4-4144-b764-97f583016a93" width="200"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/b2093ae1-733e-4946-a434-a7516302fdcf" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/066e3018-b19d-4e04-bddd-db84a726e434" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/31455620-20e8-4412-bcec-265f137c81cb" width="200"/></td>
  </tr>
</table>

## Features
- Splash screen
- Onboarding walkthrough
- User authentication
- Role-based access (User & Admin)
- Browse meal list
- View testimonials based on meals
- Display current active subscription
- Add new subscription
- View subscription history
- Manage subscription (pause, cancel, reactivate)
- Contact support card
- Admin dashboard for management

## Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern, facilitated by the [GetX](https://pub.dev/packages/get) package for:

- **State Management**
- **Routing**
- **Dependency Injection**

Project structure is scaffolded using [Get CLI](https://pub.dev/packages/get_cli) to ensure modular and scalable development.

### 🗄️ Database

The app uses **[Cloud Firestore](https://firebase.google.com/products/firestore)** as the primary NoSQL database for real-time data synchronization and storage.

- Collections are organized by user-specific or domain-specific documents.
- Queries and updates are reactive and managed within the controller layer (ViewModel).

## Dependencies
<h2>🧩 Dependencies</h2>

<table>
  <tr>
    <th>Package</th>
    <th>Version</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/get">get</a></td>
    <td>^4.7.2</td>
    <td>State management and routing</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/flutter_screenutil">flutter_screenutil</a></td>
    <td>^5.9.3</td>
    <td>Responsive UI support</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/hexcolor">hexcolor</a></td>
    <td>^3.0.1</td>
    <td>Use hex color strings in widgets</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/google_fonts">google_fonts</a></td>
    <td>^6.2.1</td>
    <td>Google Fonts integration</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/email_validator">email_validator</a></td>
    <td>^3.0.0</td>
    <td>Email address validation</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/smooth_page_indicator">smooth_page_indicator</a></td>
    <td>^1.2.1</td>
    <td>Animated page indicators</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/firebase_auth">firebase_auth</a></td>
    <td>^5.6.0</td>
    <td>Firebase Authentication service</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/firebase_core">firebase_core</a></td>
    <td>^3.14.0</td>
    <td>Initialize Firebase in Flutter</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/cloud_firestore">cloud_firestore</a></td>
    <td>^5.6.9</td>
    <td>Firestore NoSQL cloud database</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/google_nav_bar">google_nav_bar</a></td>
    <td>^5.0.7</td>
    <td>Custom bottom navigation bar</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/shared_preferences">shared_preferences</a></td>
    <td>^2.5.3</td>
    <td>Simple local key-value storage</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/intl">intl</a></td>
    <td>^0.20.2</td>
    <td>Internationalization and formatting</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/flutter_rating_bar">flutter_rating_bar</a></td>
    <td>^4.0.1</td>
    <td>Customizable rating bar widget</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/syncfusion_flutter_datepicker">syncfusion_flutter_datepicker</a></td>
    <td>^30.1.37</td>
    <td>Advanced date picker UI</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/syncfusion_flutter_charts">syncfusion_flutter_charts</a></td>
    <td>^30.1.37</td>
    <td>Data visualization and charting</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/shimmer">shimmer</a></td>
    <td>^3.0.0</td>
    <td>Shimmer effect for loading placeholders</td>
  </tr>
  <tr>
    <td><a href="https://pub.dev/packages/url_launcher">url_launcher</a></td>
    <td>^6.3.1</td>
    <td>Open external URLs from the app</td>
  </tr>
</table>

