<img width="299" height="600" alt="Screenshot 2026-08-14 at 4 59 46 PM" src="https://github.com/user-attachments/assets/5f41c2ed-5b2c-44f7-a4ab-b3e32ac12349" />
# EventExplorerApp

A native iOS app that shows nearby events, lets users view event details, and save events as bookmarks.

## Requirements

- iOS 26.2+
- Xcode 26.2+
- Swift 6

## Features

- Event list with loading, empty, and error states
- Event detail screen with distance and Maps navigation
- Bookmarks, saved on device (Core Data)
- Offline fallback — shows last loaded events if network fails
- In-memory caching for events (5 min TTL) and images
- Location permission + live distance to each event

## API Used

```
GET https://6a7e37d0f8b2ed99ca4f25b9.mockapi.io/api/v1/events
```

Dashboard: https://mockapi.io/projects/6a7e37d0f8b2ed99ca4f25ba

Returns a JSON array of events:

{
  "id": "1",
  "title": "SwiftUI Conf",
  "location": "Toronto",
  "time": "2026-09-10T18:00:00.000Z",
  "imageUrl": "https://example.com/image.jpg"
}

No API key needed.

## Architecture

MVVM + Dependency Injection.

- **View** — SwiftUI screens, only display state
- **ViewModel** — owns screen state and logic, exposed via @Published
- **Services** — one job each (network, cache, image cache, database, location), all behind protocols
- **AppContainer** — single place where every service and ViewModel is created

## Architecture Diagram
Note: could not add a diagram here due to time shortage. The Architecture section above covers the main components and how they connect.


## Sequence Diagram — Load Events

Note: could not add a diagram here due to time shortage. In short: the ViewModel checks the cache first, calls the API only if the cache is empty or expired, then updates the state to loaded, empty, or error.


## Project Structure

<img width="299" height="600" alt="FolderStructure" src="https://github.com/user-attachments/assets/bd0b2a7d-6343-49d5-b755-af10e0b5fa3b" />


## Engineering Standards

- Protocol-based services — easy to swap with fakes for testing
- Dependency Injection — everything created in AppContainer, nothing built inline in a View
- Thread safety — cache and image cache are Swift actor types
- One enum for screen state (.loading/ .loaded / .empty / .error ) — no conflicting UI states
- No hardcoded values — spacing, sizes, and text live in AppConstants
- Offline fallback via Core Data
- Unit tests use mocks, no real network or database

## Setup & Run

- Open EventExplorerApp.xcodeproj in Xcode
- Build: Cmd + B
- Run: Cmd + R
- When asked for location, tap Allow. Set a Simulator location via Features → Location → Custom Location
- Run tests: Cmd + U

No API keys or setup needed.


## Testing

7 unit tests for EventListViewModel, using mock network/cache services:

- Successful load
- Network failure
- Cache hit skips network
- Empty response
- Unknown error handling
- Initial state is .loading
- Successful load saves to cache

## Trade-offs

- In-memory cache (not disk) for events — simpler, still avoids repeated API calls. Core Data used only for bookmarks and offline fallback.
- Built-in caching instead of a third-party image library — fewer dependencies.
- CLGeocoder for location name → coordinates, since the API returns a city name, not coordinates.
- No background refresh in this version — deprioritized in favor of solid caching, offline support, and tests.

