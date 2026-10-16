/// Every piece of text shown to the user, kept in one place.
abstract final class AppStrings {
  static const String appName = 'SafeGuard Pro';

  // Login screen
  static const String welcomeBack = 'Welcome Back';
  static const String signInSubtitle = 'Sign in to continue monitoring';
  static const String workerIdentity = 'WORKER IDENTITY';
  static const String employeeNameLabel = 'EMPLOYEE NAME';
  static const String employeeNameHint = 'Ahmad Al-Rashidi';
  static const String employeeIdLabel = 'EMPLOYEE ID';
  static const String employeeIdHint = 'SW-001';
  static const String locationLabel = 'LOCATION';
  static const String locationHint = 'Site A — Zone 3';
  static const String login = 'Login';
  static const String signingIn = 'Signing in...';
  static const String securedConnection = 'SECURED CONNECTION';
  static const String sslEncrypted = '256-bit SSL Encrypted';
  static const String safetyFooter = 'Your safety starts here.';

  // Form errors
  static const String fieldRequired = 'Required';
  static const String employeeIdFormat = 'Use format SW-001';

  // Login errors
  static const String employeeNotFound =
      'Employee ID not found. Check it and try again.';
  static const String somethingWentWrong =
      'Something went wrong. Please try again.';

  // Device setup (built in the next step)
  static const String deviceSetupComingNext = 'Device setup is coming next.';
}
