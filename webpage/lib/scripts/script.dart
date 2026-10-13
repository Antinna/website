import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;
import 'package:webpage/scripts/client.dart';
import 'package:website_client/website_client.dart' as wc;

import 'core/config/config.dart' show currentFBConfig;

Future<void> main() async {
  final flavorConfig = currentFBConfig;
  print(flavorConfig.buildMode);

  final client = await getClient(flavorConfig);

  // Grab UI elements
  final inputEl =
      web.document.querySelector('#name-input') as web.HTMLInputElement?;
  final btnEl =
      web.document.querySelector('#greet-btn') as web.HTMLButtonElement?;
  final responseEl = web.document.querySelector('#greeting-response');

  if (inputEl == null || btnEl == null || responseEl == null) {
    print('UI elements not found - skipping greeting setup');
    return;
  }

  void sendGreeting() {
    final name = inputEl.value.trim();
    if (name.isEmpty) {
      responseEl.classList.remove('hidden');
      responseEl.innerHTML =
          '''
        <div class="p-4 rounded-lg" style="background-color:rgb(254 226 226);color:rgb(153 27 27);">
          Please enter a name first.
        </div>
      '''
              .toJS;
      return;
    }

    // Show loading state
    btnEl.disabled = true;
    btnEl.textContent = 'Sending...';
    responseEl.classList.remove('hidden');
    responseEl.innerHTML =
        '''
      <div class="p-4 rounded-lg" style="background-color:rgb(241 245 249);color:rgb(71 85 105);">
        Loading...
      </div>
    '''
            .toJS;

    _callGreeting(client, name, responseEl, btnEl);
  }

  btnEl.addEventListener('click', ((web.Event _) => sendGreeting()).toJS);

  // Also allow pressing Enter in the input field
  inputEl.addEventListener(
    'keydown',
    ((web.Event e) {
      final event = e as web.KeyboardEvent;
      if (event.key == 'Enter') {
        sendGreeting();
      }
    }).toJS,
  );
}

Future<void> _callGreeting(
  wc.Client client,
  String name,
  web.Element responseEl,
  web.HTMLButtonElement btnEl,
) async {
  try {
    final greeting = await client.greeting.hello(name);

    final timestamp = greeting.timestamp.toLocal().toString().split('.').first;

    responseEl.classList.remove('hidden');
    responseEl.innerHTML =
        '''
      <div class="p-4 rounded-lg" style="background-color:rgb(216 241 225);color:rgb(6 95 70);">
        <p class="font-bold text-lg mb-2">${_escapeHtml(greeting.message)}</p>
        <p class="text-sm mb-1" style="color:rgb(100 116 139);">Author: ${_escapeHtml(greeting.author)}</p>
        <p class="text-sm" style="color:rgb(100 116 139);">Time: $timestamp</p>
      </div>
    '''
            .toJS;
  } catch (e) {
    responseEl.classList.remove('hidden');
    responseEl.innerHTML =
        '''
      <div class="p-4 rounded-lg" style="background-color:rgb(254 226 226);color:rgb(153 27 27);">
        Error: ${_escapeHtml(e.toString())}
      </div>
    '''
            .toJS;
  } finally {
    btnEl.disabled = false;
    btnEl.textContent = 'Send Greeting';
  }
}

/// Simple HTML escape to prevent XSS when displaying user data.
String _escapeHtml(String s) {
  return s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');
}
