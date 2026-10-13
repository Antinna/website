import 'dart:io';

import 'package:blogger_theme/blogger_theme.dart';
import 'package:blogger_theme/renderer.dart';
import 'package:webpage/webpage.dart' as webpage;

/// Renders the complete HTML document with DOCTYPE.
String generate(Component component) {
  return '<!DOCTYPE html>\n${Renderer().render(component)}';
}

void main() async {
  final page = await webpage.main();
  final htmlOutput = generate(page);

  // Write to build/index.html
  final outputFile = File('build/index.html');
  outputFile.createSync(recursive: true);
  await outputFile.writeAsString(htmlOutput);

  print('Landing page generated successfully!');
  print('Output: ${outputFile.path}');
  print('File size: ${outputFile.lengthSync()} bytes');
}
