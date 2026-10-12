

part 'flavor_interface.dart';

class Flavor implements FlavorInterface {
  // ignore: unused_element_parameter
  const Flavor._(this.name, [this._customUrl]);

  @override
  final String name;
  final String? _customUrl;

  static String get localhost =>
      // (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
      //     ? '10.0.2.2'
      //     :
      'localhost';

  static const Flavor development = Flavor._('development');
  static const Flavor staging = Flavor._('staging');
  static const Flavor production = Flavor._('production');

  @override
  String get baseUrl {
    const envUrl = String.fromEnvironment('SERVER_URL');
    if (envUrl.isNotEmpty) return envUrl;
    if (_customUrl != null) return _customUrl;
    return 'http://$localhost:8080';
  }

}