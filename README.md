Ihr könnt mich (Stefan Wiesinger / Product Owner) unter stefanwiesinger2005@gmail.com erreichen.
Ich kann euch auch zur Organisation/Repos hinzufügen, dann könnt ihr das Kanban Board und die Build-Pipeline übernehmen.

# TdoT-App (Tag der offenen Tür)

A Flutter application for managing open house day registration and information at HTL Grieskirchen.

## Project Overview

This application provides a digital platform for students and parents to:
- Get information about the school and registration process
- Navigate through the school during open house day
- Register for trial days
- View important events and activities

## Architecture

The app follows Clean Architecture principles with the BLoC (Business Logic Component) pattern for state management:

```
lib/
├── blocs/         # Business logic components
├── models/        # Data models
├── resources/     # Repositories and API connections
├── screens/       # UI screens
└── widgets/       # Reusable UI components
```

### Key Design Patterns

- **BLoC Pattern**: Separates business logic from UI
- **Repository Pattern**: Abstracts data sources from the business logic
- **Singleton Pattern**: Used in repositories for shared instances
- **Factory Pattern**: Used for model construction from JSON

## Features

### Information Display
- School information sections with formatted text
- Paragraphs with headings and detailed information

### Trial Day Registration
- Form for registering to trial days
- Date selection with date picker
- Form validation
- Success/error handling with toast messages

### Navigation
- Interactive floor plan using SVG
- List of activities and their locations

## State Management

The app uses the BLoC pattern with three main components:
- **Events**: Trigger state changes
- **States**: Represent the current app state
- **BLoC**: Processes events and emits new states

### Example Flow:
1. UI sends an event to the BLoC
2. BLoC processes the event, possibly accessing repositories
3. BLoC emits a new state
4. UI rebuilds based on the new state

## Repository Pattern

The Repository Pattern serves as an abstraction layer between data sources and the application's business logic.

### Implementation in TdoT-App:
- **Single Point of Data Access**: All data operations go through repositories
- **Data Source Abstraction**: BLoCs don't need to know where data comes from
- **Caching Strategy**: Repositories implement in-memory caching only for relatively static data that doesn't change frequently

### Structure:
```
resources/
├── api_provider.dart       # Handles HTTP communication
├── trial_day_repository.dart   # Trial day data operations
├── information_repository.dart # School information operations
└── navigation_repository.dart  # Navigation and activities data
```

### Example Flow:
1. BLoC requests data from a repository
2. Repository checks if requested data is cached
3. If not cached, repository fetches data from API provider
4. Repository processes and returns data to the BLoC
5. Repository optionally caches the data for future requests

## API Integration

The app communicates with a backend server using:
- Dio for HTTP requests
- Repository pattern for data access
- Error handling with user-friendly messages

## iOS Deployment

The app is configured for iOS deployment with:
- Proper bundle identifier (at.htl-grieskirchen.tdot)
- Manual signing with provisioning profile
- Minimum iOS version 12.0

### Secrets

The following secrets need to be configured in Github
- IOS_BUILD_CERTIFICATE_BASE64
- IOS_BUILD_CERTIFICATE_PASSWORD
- IOS_GITHUB_KEYCHAIN_PASSWORD
- IOS_MOBILE_PROVISIONING_PROFILE_BASE64
