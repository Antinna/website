part of 'build_mode_interface.dart';

/// Enums are implicitly constant and can implement interface classes.
enum BuildMode() implements BuildModeInterface {
  debug,
  profile,
  release;

  static const BuildMode current = // let ignore this for now , let be on debug
      // kProfileMode //
      bool.fromEnvironment('dart.vm.profile')
      ? BuildMode.profile
      :
        // kReleaseMode //
        bool.fromEnvironment('dart.vm.product')
      ? BuildMode.release
      // else //
      : BuildMode.debug;
  // String.fromEnvironment('BUILD_MODE', defaultValue: 'debug') == 'release'
  // ? BuildMode.release
  //     : String.fromEnvironment('BUILD_MODE', defaultValue: 'debug') == 'profile'
  // ? BuildMode.profile
  //     : BuildMode.debug;
}
