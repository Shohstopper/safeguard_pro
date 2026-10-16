/// Backend address and endpoint paths, from the backend team's API contract.
abstract final class ApiConstants {
  /// The address in the API contract. It only works when the app runs on
  /// the same computer as the backend (for example as a Windows app).
  static const String localhostBaseUrl = 'http://localhost:5000';

  /// The same backend seen from the Android emulator. Inside the emulator,
  /// 10.0.2.2 means "the computer the emulator is running on".
  static const String androidEmulatorBaseUrl = 'http://10.0.2.2:5000';

  /// The address the app uses. Change this one line for a real phone (use
  /// the computer's Wi-Fi IP address) or a deployed server.
  static const String baseUrl = androidEmulatorBaseUrl;

  /// How long to wait for the backend before giving up.
  static const Duration timeout = Duration(seconds: 10);

  static const String sessionStartPath = '/api/session/start';
  static const String sessionEndPath = '/api/session/end';
}
