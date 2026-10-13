import 'dart:js_interop';

import 'package:web/web.dart' as web;
import 'package:website_client/website_client.dart';

/// Concrete implementation of [ConnectivityMonitor] for Flutter Web
/// using native browser APIs (`navigator.onLine` and window events).
class WebConnectivityMonitor extends ConnectivityMonitor {
  late final JSFunction _onOnlineJS;
  late final JSFunction _onOfflineJS;

  WebConnectivityMonitor() {
    // 1. Read the initial connection state from the browser's navigator
    final initialConnected = web.window.navigator.onLine;
    notifyListeners(initialConnected);

    // 2. Wrap callbacks with .toJS for modern Dart static JS interop
    _onOnlineJS = ((web.Event event) {
      notifyListeners(true);
    }).toJS;

    _onOfflineJS = ((web.Event event) {
      notifyListeners(false);
    }).toJS;

    // 3. Register native window event listeners for online/offline changes
    web.window.addEventListener('online', _onOnlineJS);
    web.window.addEventListener('offline', _onOfflineJS);
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up event listeners using the exact stored JSFunction instances
    web.window.removeEventListener('online', _onOnlineJS);
    web.window.removeEventListener('offline', _onOfflineJS);
  }
}
