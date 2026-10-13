import 'dart:io';

import 'package:blogger_theme/blogger_theme.dart';
import 'package:path/path.dart' as path;

// button(
// {'class': 'icon-btn', 'id': 'dark-mode-toggle', 'type': 'button'},
// [span({'class': 'i-carbon-moon text-lg'}, [])], // and sun icon
// ),
Component darkModeScript() {
  return script(
    {'type': 'text/javascript'},
    [
      Text(
        // this script is very small don't ever try to port it to dart as
        // dart scripts are bulky and we need faster native stuffs so.. keep it simple..
        escape: false,
        '''(function() { 
  const toggle = document.getElementById('dark-mode-toggle');
  const html = document.documentElement;
  const stored = localStorage.getItem('dark-mode');
  if (stored === 'true' || (!stored && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
    html.classList.add('amp-dark-mode');
  }
  if (toggle) {
    toggle.addEventListener('click', () => {
      html.classList.toggle('amp-dark-mode');
      localStorage.setItem('dark-mode', html.classList.contains('amp-dark-mode'));
    });
  }
})();''',
      ),
    ],
  );
}

/// Embeds the Serverpod client bootstrap script.
Component clientBootstrapScript() {
  return BClientScript(
    // in future we
    "lib/scripts/script.dart",

    attributes: {'type': 'text/javascript'},
    contentInCDATA: false,
  );
}

// ─── Full Page ──────────────────────────────────────────────────────────────

Component landingPage(String css) {
  return html(
    {'lang': 'en', 'class': 'amp-dark-mode'},
    [
      head([
        meta({'charset': 'UTF-8'}),
        meta({
          'name': 'viewport',
          'content': 'width=device-width, initial-scale=1.0',
        }),
        meta({'name': 'description', 'content': '...'}),
        meta({'name': 'theme-color', 'content': '#0284c7'}),
        title([Text('Serverpod Greeting Demo')]),
        link({
          'rel': 'icon',
          'type': 'image/svg+xml',
          'href': 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><text y=".9em" font-size="90">🔗</text></svg>',
        }),
        // UnoCSS generated styles
        style({'type': 'text/css'}, [Text(css, escape: false)]),
        // Inline styles for animations and misc

        // JSON-LD self-reference (meta!)
        script(
          {'type': 'application/ld+json'},
          [Text(escape: false, ''' .... ''')],
        ),
      ]),
      body([
        div(
          {
            'class':
                'hero flex flex-col items-center justify-center min-h-screen',
          },
          [
            div(
              {
                'class':
                    'section-container flex flex-col items-center max-w-xl',
              },
              [
                h1(
                  {'class': 'hero-title mb-4'},
                  [Text('Serverpod Greeting Demo')],
                ),
                p(
                  {'class': 'hero-subtitle mb-8'},
                  [
                    Text(
                      'Enter a name below and click "Send Greeting" to call the server and see the response.',
                    ),
                  ],
                ),
                div(
                  {'class': 'card w-full', 'id': 'greeting-card'},
                  [
                    div(
                      {'class': 'card-body'},
                      [
                        label({'for': 'name-input'}, [Text('Your Name')]),
                        input({
                          'type': 'text',
                          'id': 'name-input',
                          'placeholder': 'Enter your name...',
                          'class': 'w-full',
                        }),
                        button(
                          {
                            'id': 'greet-btn',
                            'class': 'btn-primary w-full mt-4',
                          },
                          [Text('Send Greeting')],
                        ),
                        div({
                          'id': 'greeting-response',
                          'class': 'mt-4 hidden',
                        }, []),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        clientBootstrapScript(),
      ]),
    ],
  );
}

// ─── Public Entry Point ─────────────────────────────────────────────────────

/// Loads the CSS and returns the complete landing page component.
Future<Component> main() async {
  // Resolve the CSS file path relative to this library file
  final scriptDir = path.dirname(path.fromUri(Platform.script));
  final cssPath = path.normalize(
    path.join(scriptDir, '..', 'lib', 'css', 'output.css'),
  );
  final cssFile = File(cssPath);

  String css = '';
  if (await cssFile.exists()) {
    css = await cssFile.readAsString();
  } else {
    // Fallback: try relative to current working directory
    final fallbackFile = File('lib/css/output.css');
    if (await fallbackFile.exists()) {
      css = await fallbackFile.readAsString();
    }
  }

  return landingPage(css);
}
