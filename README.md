<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Counter App Package

A reusable counter widget package for Flutter applications.

## Features

- ✅ **Stateful Counter Widget** - Increment, decrement, reset functionality
- ✅ **Counter Dialog** - Modal dialog with counter widget
- ✅ **Async Operations** - Simulate network requests with loading states
- ✅ **Customizable UI** - Colors, titles, and styling options
- ✅ **State Management** - ChangeNotifier based controller
- ✅ **Error Handling** - Display and clear error messages
- ✅ **Callbacks** - Value change notifications

## Installation

### Local Path (Development)
```yaml
dependencies:
  counterapp:
    path: ../counterapp
```

### Git Dependency (Production)
```yaml
dependencies:
  counterapp:
    git:
      url: https://github.com/company/counterapp.git
      ref: v1.0.0
```

## Usage

### Basic Counter Widget
```dart
import 'package:counterapp/counterapp.dart';

CounterWidget(
  title: 'My Counter',
  initialValue: 10,
  onValueChanged: (value) {
    print('Counter: $value');
  },
)
```

### Counter Dialog
```dart
final result = await CounterDialog.show(
  context,
  title: 'Counter Dialog',
  initialValue: 5,
);
```

### Advanced Usage
```dart
CounterWidget(
  title: 'Advanced Counter',
  initialValue: 0,
  showAsyncButton: true,
  primaryColor: Colors.blue,
  backgroundColor: Colors.grey[100],
  onValueChanged: (value) {
    // Handle value changes
  },
)
```

## Components

### CounterWidget
Main counter widget with increment/decrement buttons and value display.

### CounterDialog
Modal dialog containing a counter widget with OK/Cancel buttons.

### CounterController
State management controller using ChangeNotifier pattern.

### CounterState
Immutable state model for counter data.

## Example

See `/example` folder for a complete example application.

## License

MIT License
