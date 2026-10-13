import 'dart:async';

import 'package:webpage/scripts/core/config/config.dart'
    show currentFBConfig, FlavorConfig;
import 'package:webpage/scripts/session_manager.dart';
import 'package:webpage/scripts/web_connectivity_monitor.dart';
import 'package:website_client/website_client.dart';

// ignore: unnecessary_import
import 'core/config/config.dart' show currentFBConfig;

Future<Client> getClient([FlavorConfig myFBConfig = currentFBConfig]) async {
  final serverUrl = myFBConfig.baseUrl;

  // return
  final client = Client(serverUrl)
    ..connectivityMonitor = WebConnectivityMonitor()
    ..authSessionManager = WebAuthSessionManager();
  unawaited(client.auth.initialize());
  return client;
}
