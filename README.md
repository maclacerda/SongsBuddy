# 🎵 SongsBuddy

![Build Status](https://github.com/maclacerda/SongsBuddy/actions/workflows/ios-ci.yml/badge.svg)
![iOS](https://img.shields.io/badge/iOS-17%2B-blue.svg)
![Swift](https://img.shields.io/badge/Swift-6-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-native-green.svg)
![Swift Concurrency](https://img.shields.io/badge/Concurrency-async%2Fawait-teal.svg)
![Architecture](https://img.shields.io/badge/Architecture-Modular%20MVVM-purple.svg)

---

## 📱 About the App

SongsBuddy is a lightweight music browsing app that allows users to search for songs, explore albums, and play track previews.

This project was built as part of a technical challenge, focusing on:

- Clean and scalable architecture
- Modularization using Swift Package Manager
- Offline-first principles
- Playback experience consistency
- UI fidelity based on design specifications

---

## ▶️ How to Run the Project

### Requirements

- Xcode 26 or newer
- iOS 17+
- macOS compatible with Xcode 26

### Steps

1. Clone the repository:

```bash
git clone https://github.com/<your-username>/SongsBuddy.git
```

2.	Open the project:

```bash
open SongsBuddy.xcodeproj
```

3.	Select a simulator (e.g., iPhone 17 Pro)

4.	Run the project:

```bash
⌘ + R
```

**Notes**

    •	The project uses modern Swift features and requires Xcode 26+
    •	Swift Package dependencies will resolve automatically on first build

## 🧱 Architecture

The project follows a **feature-first modular architecture** using **Swift Package Manager (SPM)**.

Each feature is isolated into its own module, improving scalability, testability, and separation of concerns.

### Key Principles

- **MVVM (Model-View-ViewModel)**
- Clear separation between **UI, Domain, and Data layers**
- Avoidance of unnecessary architectural complexity (e.g., heavy UDF patterns)
- Composition at the App layer

### Modules Overview

- `SBSongsFeature`
- `SBSongDetailsFeature`
- `SBAlbumFeature`
- `SBDesignSystem`
- `SBData`
- `SBTestUtils`

---

## ▶️ Playback Strategy

One of the key architectural decisions was the introduction of a **Playback Context**.

### Why?

To ensure consistent navigation behavior across different entry points:

- Search results
- Recently played
- Album track list

### Behavior

- **Back / Forward buttons** navigate within the current context
- Context is dynamically updated based on user navigation
- The player is treated as a **single source of truth** (not stacked in navigation)

### Example

- User selects a song from search → navigates within search results  
- User opens album → playback context switches to album tracks  

---

## 🔍 Search UX Decisions

Some UX behaviors were intentionally defined due to lack of strict specification:

- Initial search is preloaded (e.g., "rock") to improve first-time experience
- Collapsed header expands into search input when tapped
- Smooth transition between collapsed and expanded states

These decisions aim to provide a more fluid and intuitive interaction model.

---

## 💾 Offline-First Strategy

The app includes a basic offline-first approach using **SwiftData**.

### Current Implementation

- Recently played songs are persisted locally
- Data is refreshed on demand
- UI reacts to local data changes

### Trade-off

The persistence layer is intentionally lightweight, focusing on the core experience rather than full offline synchronization.

### Playback Pause Icon

The provided designs did not include a dedicated pause state asset matching the exact visual language of the custom play icon.

To preserve design consistency, a custom pause icon was created to closely match the size, weight, and overall appearance of the play asset, instead of falling back to a default SF Symbol that would visually diverge from the rest of the interface.

### Search Pagination Strategy

Due to limitations and undocumented behavior in the iTunes Search API pagination model, the app does not rely on remote offset-based paging.

Instead, it fetches up to `200` results per query — which is the documented `limit` for `/search` — and paginates locally in the UI. This keeps the experience stable, deterministic, and less dependent on undocumented backend behavior.

Client-side deduplication is also applied as an additional safeguard to maintain result consistency.

---

## 🧪 Testing Strategy

The project uses:

- **Swift Testing** for unit tests
- **SnapshotTesting** for UI validation

### Coverage Focus

Tests were written to validate the **core user flows**, including:

- Playback interactions
- Recently played updates
- Critical UI components

A shared utility (`SBTestUtils`) centralizes snapshot configuration for consistency.

---

## ⚙️ CI/CD

The project includes a **GitHub Actions pipeline** that:

- Builds the project
- Runs unit tests
- Runs snapshot tests

### Environment

- macOS (latest)
- Xcode 26+
- iOS Simulator

### Trigger

- Runs on pull requests and pushes to `main` or `develop`

---

## 🎨 Design System

A dedicated **Design System module** ensures UI consistency:

- Color tokens
- Typography tokens
- Spacing and radius tokens
- Custom components

This approach enables:

- Reusability
- Scalability
- Clear separation of UI concerns

---

## ⚖️ Trade-offs

### CI Test Scope

Currently, CI runs tests from the main application target only.

A future improvement would be to execute tests for all modules individually.

---

### Playback Controls

- Repeat functionality is simplified (toggle on/off)
- Back/Forward navigation is context-based instead of global queue

---

### Persistence

- Only Recently Played is persisted
- No caching of search results (intentional simplification)

---

## 🚀 Future Improvements

- Increase test coverage across all modules
- Extract Player into its own module
- Improve persistence layer (caching, sync strategies)
- Included accessibility support
- Enhance playback controls (shuffle, queue management)
- Move all assets (icons) fully into Design System
- Add support for `light` mode
- Add fullscreen charts animation when song in reproduction
- Introduce Tuist (or a similar project generation tool) to better manage modularization, improve scalability, and standardize project configuration across environments

---

## 🤖 AI Usage

AI tools were used during development to assist with specific implementation details.

ChatGPT was primarily used to:

- Refine UI animations
- Improve code stability and edge-case handling
- Explore alternative implementation approaches

All architectural decisions, code structure, and final implementations were reviewed and validated manually to ensure correctness and alignment with the project goals.

## 🛠 Tech Stack

- Swift 6
- SwiftUI
- SwiftData
- Swift Package Manager
- SnapshotTesting
- Swift Testing
- GitHub Actions

---

## 📌 Final Notes

This project prioritizes:

- Code clarity
- Architectural decisions
- Real-world trade-offs

Rather than overengineering, the focus was on delivering a solid and extensible foundation aligned with production-grade standards.