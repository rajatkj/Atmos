# Atmos

<div>
<img src="/screenshots/S1.png" alt="alt text" width="300"/>
<img src="/screenshots/S2.png" alt="alt text" width="300"/>
<img src="/screenshots/S3.png" alt="alt text" width="300"/>
</div>

## Overview

Atmos is an `iOS WeatherApp` that uses [Openweathermap API](https://api.open-meteo.com/v1/) and [Geocode API](https://geocode.maps.co/search) to fetch the location and weather and build with SwiftUI.

Models created with [Quicktype](https://app.quicktype.io)

Gradient Animations inspired from [AppCoda](https://www.appcoda.com/animate-gradient-swiftui/)

## Network Manager
```bash
Atmos/Network
├── Environment
│   └── NetworkEnvironment.swift
├── NetworkManager.swift
├── Request
│   ├── CodingStrategy.swift
│   ├── HTTPMethod.swift
│   └── NetworkRequest.swift
└── Service
    ├── LocationService.swift
    └── WeatherService.swift
```

### Tech Stack
- SwiftUI
- REST API
- JSON & Codable
- MVVM
- Observation Framework

### Prerequisites

- A Mac running macOS Sonoma
- Xcode 15.0

### Installation

1. Clone or download the project to your local machine
2. Open the project in Xcode 15.0
3. Click the run button and run on simulator
