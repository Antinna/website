import 'dart:async';

import 'package:webpage/scripts/session_manager.dart';
import 'package:webpage/scripts/web_connectivity_monitor.dart';
import 'package:website_client/website_client.dart';

import 'core/config/config.dart' show currentFBConfig;

Future<Client> getClient() async {
  final serverUrl = currentFBConfig.baseUrl;

  // return
  final client =  Client(serverUrl)
     ..connectivityMonitor = WebConnectivityMonitor()
    ..authSessionManager = WebAuthSessionManager( )
  ;
  unawaited(client.auth.initialize());
  return client;
}
