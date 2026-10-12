import 'dart:async';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';
import 'package:webpage/scripts/session_storage/client_auth_storage.dart';


/// The [WebAuthSessionManager] tracks and manages the user's signed-in state
/// for pure Dart web applications using cookie storage and reactive streams.
class WebAuthSessionManager extends ClientAuthSessionManager {
  final StreamController<AuthSuccess?> _authInfoStreamController;

  WebAuthSessionManager._internal({
    required StreamController<AuthSuccess?> authInfoStreamController,
    required super.storage,
    required void Function(AuthSuccess?) onAuthInfoChanged,
    super.caller,
    super.authKeyProviderDelegates,
  })  : _authInfoStreamController = authInfoStreamController,
        super(onAuthInfoChanged: onAuthInfoChanged);

  factory WebAuthSessionManager({
    Caller? caller,
    Map<String, ClientAuthKeyProvider>? authKeyProviderDelegates,
    ClientAuthSuccessStorage? storage,
  }) {
    final controller = StreamController<AuthSuccess?>.broadcast();

    return WebAuthSessionManager._internal(
      caller: caller,
      authKeyProviderDelegates: authKeyProviderDelegates,
      storage: storage ?? WebCookieClientAuthSuccessStorage(),
      authInfoStreamController: controller,
      onAuthInfoChanged: (authInfo) {
        controller.add(authInfo);
      },
    );
  }

  /// A broadcast stream that emits authentication state changes.
  ///
  /// Example usage:
  /// ```dart
  /// client.auth.authInfoStream.listen((authInfo) {
  ///   if (authInfo != null) {
  ///     // User signed in
  ///   } else {
  ///     // User signed out
  ///   }
  /// });
  /// ```
  Stream<AuthSuccess?> get authInfoStream => _authInfoStreamController.stream;

  /// Closes the stream controller.
  void dispose() {
    _authInfoStreamController.close();
  }
}

/// Extension for ServerpodClientShared to provide web auth session management in pure Dart.
extension WebAuthSessionManagerExtension on ServerpodClientShared {
  WebAuthSessionManager get authSessionManager {
    final currentProvider = authKeyProvider;
    if (currentProvider == null) {
      throw StateError(
        'To access the auth instance, first instantiate the session manager '
            'and set it as the "authKeyProvider" on the client.',
      );
    }
    if (currentProvider is! WebAuthSessionManager) {
      throw StateError(
        'The "authKeyProvider" is set to an unsupported type. Expected '
            '"WebAuthSessionManager", got "${currentProvider.runtimeType}".',
      );
    }
    return currentProvider;
  }

  WebAuthSessionManager get auth => authSessionManager;

  set authSessionManager(WebAuthSessionManager manager) {
    manager.setCaller(_getCaller());
    authKeyProvider = manager;
  }
}

extension on ServerpodClientShared {
  Caller _getCaller() {
    var caller = moduleLookup.values.whereType<Caller>().firstOrNull;
    if (caller != null) return caller;
    throw StateError('No authentication module found.');
  }
}