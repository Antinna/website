import 'package:web/web.dart' as web;
// ignore: depend_on_referenced_packages
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

/// A [KeyValueStorage] implementation for pure Dart web targets that
/// stores values securely in browser cookies.
class WebCookieKeyValueStorage implements KeyValueStorage {
  final Duration maxAge;
  final String path;
  final String? domain;
  final bool secure;
  final String sameSite;

  WebCookieKeyValueStorage({
    this.maxAge = const Duration(days: 30),
    this.path = '/',
    this.domain,
    this.secure = true,
    this.sameSite = 'Lax',
  });

  @override
  Future<String?> get(String key) async {
    final cookies = web.document.cookie;
    if (cookies.isEmpty) return null;

    final keyValuePairs = cookies.split(';');
    for (var pair in keyValuePairs) {
      final parts = pair.trim().split('=');
      if (parts.length >= 2) {
        final currentKey = Uri.decodeComponent(parts[0].trim());
        if (currentKey == key) {
          return Uri.decodeComponent(parts.sublist(1).join('=').trim());
        }
      }
    }
    return null;
  }

  @override
  Future<void> set(String key, String? value) async {
    final encodedKey = Uri.encodeComponent(key);
    if (value == null || value.isEmpty) {
      // Expire the cookie immediately to delete it
      web.document.cookie =
          '$encodedKey=; Max-Age=0; path=$path; SameSite=$sameSite${secure ? '; Secure' : ''}';
    } else {
      final encodedValue = Uri.encodeComponent(value);
      var cookieStr =
          '$encodedKey=$encodedValue; Max-Age=${maxAge.inSeconds}; path=$path; SameSite=$sameSite';
      if (secure) {
        cookieStr += '; Secure';
      }
      if (domain != null) {
        cookieStr += '; domain=$domain';
      }
      web.document.cookie = cookieStr;
    }
  }
}
