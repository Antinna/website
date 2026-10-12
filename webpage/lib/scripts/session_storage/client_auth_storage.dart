import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';
import 'web_cookie_key_value_storage.dart';

/// A [ClientAuthSuccessStorage] implementation that persists authentication
/// info into browser cookies with built-in caching.
class WebCookieClientAuthSuccessStorage extends CachedClientAuthSuccessStorage {
  WebCookieClientAuthSuccessStorage({
    Duration maxAge = const Duration(days: 30),
    String path = '/',
    String? domain,
    bool secure = true,
    String sameSite = 'Lax',
    String? authSuccessStorageKey,
  }) : super(
    delegate: KeyValueClientAuthSuccessStorage(
      keyValueStorage: WebCookieKeyValueStorage(
        maxAge: maxAge,
        path: path,
        domain: domain,
        secure: secure,
        sameSite: sameSite,
      ),
      authSuccessStorageKey: authSuccessStorageKey,
    ),
  );
}