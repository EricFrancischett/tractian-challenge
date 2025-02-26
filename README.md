# Tractian Challenge

This repository contains a Flutter application designed to manage and display asset information for different units. The project uses MobX for state management and GetIt for dependency injection. The assets and locations data are loaded from JSON files.

## Table of Contents

- [Features](#features)
- [Packages Used](#packages-used)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [UI Changes](#ui-changes)

## Features

### General

- Custom Launcher Icon according to the new UI.
- Custom Splash page according to the new UI.

### Home Page

- Menu to select which unit you want to manage assets.

### Assets Page

- Load assets and locations from local JSON files.

- Display assets in a hierarchical tree view with expandable nodes.
- Search for specific assets or locations.
- Filter assets based on sensor type (energy) and status (critical).
- Use MobX for state management.
- Use GetIt for dependency injection.

## Relevant Information

### **compute method**

The application handles a large amount of data, and to avoid lags and crashes, `compute()` functions were implemented in the repositories. These functions use another thread to prevent accumulating tasks on the main thread that deals with rendering the screen.

```dart
   final List<AssetEntity> assets = await compute(parseAssets, jsonAssets);
   ```

- *Isolates were not used in the function to load system data because Flutter does this automatically:*

   `"If the string is larger than 50 KB, the decoding process is delegated to an isolate to avoid jank on the main thread."`

   [Read more about loadString method here](https://api.flutter.dev/flutter/services/AssetBundle/loadString.html)

### Using ListView.builder() to render ExpansionTile childrens

- Due to the tree view, depending on the number of locations, assets, and components, the screen may take time to render. To help in this issue, `ListView.buider()` were used instead of normal ExpansionTile children rendering. According to ExpansionTile documentation `"This widget is typically used with [ListView] to create an "expand / collapse" list entry."`, so even using `ListView.builder()` to build the root list, the children of expansion tile will be rendered entirely, which causes some freezing on long lists. According to the Flutter documentation, to work with long lists we should use `ListView.builder()`. 

   `"The standard ListView constructor works well for small lists. To work with lists that contain a large number of items, it's best to use the ListView.builder constructor. In contrast to the default ListView constructor, which requires creating all items at once, the ListView.builder() constructor creates items as they're scrolled onto the screen."`

- Normal `ExpansionTile` children `ListView` rendering

```dart
ExpansionTile(
 children: node.children
     .map((child) => TreeViewBuilder.buildNode(child, context))
     .toList(),
),
```

- Forcing `ListView.Builder()` ExpansionTile children rendering

```dart
ExpansionTile(
 children: [
   ListView.builder(
     itemBuilder: (context, index) {
       final childNode = node.children[index];
       return TreeViewBuilder.buildNode(childNode, context);
     },
   ),
 ],
),
```

   [Read more about `ListView.builder()` here](https://docs.flutter.dev/cookbook/lists/long-lists)

```dart
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);

    void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100 && widget.nodes.length > displayedNodes.length) {
      _loadMoreNodes();
    }

    Future<void> _loadMoreNodes() async {
      // load more nodes
    }
  }
   ```

## Packages Used

- **mobx: ^2.3.3+2**
- **flutter_mobx: ^2.2.1+1**
- **get_it: ^7.7.0**
- **flutter_svg: ^2.0.10+1**
- **build_runner: ^2.4.11**
- **mobx_codegen: ^2.6.1**
- **mockito: ^5.4.4**
- **flutter_native_splash: ^2.4.1**
- **flutter_launcher_icons: ^0.13.1** 

### Description

1. **mobx**:
   - MobX is a state management library that makes it simple to connect the reactive data of your application with the UI. It helps manage the state in a predictable and efficient manner.

2. **flutter_mobx**:
   - This package provides Flutter-specific bindings for MobX, allowing you to easily use MobX observables and reactions in your Flutter widgets. It ensures your UI components react to changes in the observable state seamlessly.

3. **get_it**:
   - GetIt is a simple service locator for Dart and Flutter projects. It is used for dependency injection, which helps in managing dependencies in a clean and modular way. It makes it easier to handle singleton instances and service management.

4. **flutter_svg**:
   - Flutter SVG is a library for rendering SVG (Scalable Vector Graphics) images in Flutter applications. It is used to include vector graphics, ensuring they scale perfectly across different screen sizes and resolutions.

5. **build_runner**:
   - Build Runner is a tool for code generation in Dart projects. It is used in conjunction with other code generation packages like `mobx_codegen` to generate necessary boilerplate code automatically, making the development process more efficient.

6. **mobx_codegen**:
   - This package provides code generation for MobX. It works with Build Runner to generate the necessary code for MobX stores, reducing the boilerplate code you need to write manually and ensuring consistency.

7. **mockito**:
   - Mockito is a popular library for creating mock objects in Dart tests. It is used for unit testing by allowing you to mock dependencies and verify interactions, ensuring your code is tested in isolation and behaves as expected.

8. **flutter_launcher_icons**:
   - This package automatically generates iOS, Android, and Web-native code for customizing this native splash screen background color and splash image. Used to implement a custom spash screen.

9. **flutter_launcher_icons**:
   - A package which simplifies the task of updating your Flutter app's launcher icon. Used to implement a custom launcher icon.

## Project Structure

```plaintext
lib/
├── core/                     # (files for general use across the project)
├── features/                 # (contains the different feature modules)
│   ├── feature/              # (feature name)
│   │   ├── data/             # (handles data fetching and persistence)
│   │   │   ├── datasources/  # (data sources like local and remote data fetching)
│   │   │   ├── repositories/ # (implementation of the repositories)
│   │   ├── domain/           # (contains business logic)
│   │   │   ├── repositories/ # (repository interfaces)
│   │   │   ├── usecases/     # (use cases for the business logic)
│   │   ├── presentation/     # (handles the UI)
│   │   │   ├── controller/   # (state management and controllers)
│   │   │   ├── view/         # (UI widgets and screens)
```
## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Comes with Flutter

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/tractian-challenge.git
   cd tractian-challenge
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

## Usage

### Running the Application

   ```bash
   flutter run
   ```

## Testing

### Running Tests

1. Ensure you have the `flutter_test` package in your `dev_dependencies`:

   ```yaml
   dev_dependencies:
      flutter_test:
         sdk: flutter
   ```

2. Run the tests:

   ```bash
   flutter test
   ```

## UI Changes

### Challenge version

- On the challenge UI version some UX problems were found:

1. Home Page - No instructins to the user about home page button functions.

2. Assets Page - No subtitles related to the icons in the tree nodes.

3. Assets Page - No title telling to the user which unit page he is.

4. No indication of a component to help the user to scroll up when user already went deep down on the list.

![alt text](/readme_files/old_version.png)

### Current version

- Added home page instruction informing the user that the home button redirects to the unit page.

- Using the same icon to button filter and node tree icon to relate the functions.

- Added assests page title informing the uses which unit he is managing.

- Added a Floating Action Button that scrolls all the way up when pressed.

![alt text](/readme_files/new_version.png)