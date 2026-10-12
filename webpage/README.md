# How to Run

## Prerequisites

- [Node.js](https://nodejs.org/) installed
- [Dart SDK](https://dart.dev/get-dart) installed

## Installation and Execution

Run the following commands from the project root:

```bash
# Install Node.js dependencies
npm install

# Fetch Dart dependencies
dart pub get

# Generate CSS for development
npm run dev

# Or generate CSS for production
# npm run build

# Run the dart code to generate html
dart run bin/main.dart
```

> **Note:** Both `npm run dev` and `npm run build` generate the CSS output (`output.css`) only.

## Generated 

After running the commands, navigate to the `build/` directory and locate `index.html`.

You can use `build/index.html` in your project as needed.

