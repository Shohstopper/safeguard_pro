/// Every piece of text shown to the user, kept in one place.
abstract final class AppStrings {
  static const String appName = 'SafeGuard Pro';

  // General
  static const String fieldRequired = 'Required';
  static const String tryAgain = 'Try again';
  static const String somethingWentWrong =
      'Something went wrong. Please try again.';
  static const String cannotReachServer =
      'Cannot reach the server. Check your connection and try again.';

  // Login screen
  static const String welcomeBack = 'Welcome Back';
  static const String signInSubtitle = 'Sign in to continue monitoring';
  static const String workerIdentity = 'WORKER IDENTITY';
  static const String employeeNameLabel = 'EMPLOYEE NAME';
  static const String employeeNameHint = 'Ahmad Al-Rashidi';
  static const String employeeIdLabel = 'EMPLOYEE ID';
  static const String employeeIdHint = 'W001';
  static const String locationLabel = 'LOCATION';
  static const String locationHint = 'Site A — Zone 3';
  static const String login = 'Login';
  static const String securedConnection = 'SECURED CONNECTION';
  static const String sslEncrypted = '256-bit SSL Encrypted';
  static const String safetyFooter = 'Your safety starts here.';

  // Scan screen (step 1)
  static const String deviceSetupTitle = 'Device setup';
  static const String deviceSetupStep = 'Step 1 of 3';
  static const String readyToScan = 'Ready to scan';
  static const String readyToScanMessage =
      'Turn on Bluetooth to find and securely pair your work smartwatch.';
  static const String lookingForSmartwatches = 'Looking for smartwatches';
  static const String lookingForSmartwatchesMessage =
      'Keep your smartwatch nearby while we search for compatible devices.';
  static const String noSmartwatchesFound = 'No smartwatches found';
  static const String noSmartwatchesFoundMessage =
      'Make sure your smartwatch is charged and close to your phone, then '
      'scan again.';
  static const String scanFailed = 'Scan failed';
  static const String bluetoothRequired = 'Bluetooth required';
  static const String bluetoothRequiredMessage =
      'Needed to discover nearby smartwatches.';
  static const String bluetoothOn = 'Bluetooth on';
  static const String bluetoothOnMessage = 'Your device is ready to scan.';
  static const String turnOnBluetoothAndScan = 'Turn on Bluetooth & scan';
  static const String scanningNearbyDevices = 'Scanning nearby devices…';
  static const String scanAgain = 'Scan again';
  static const String bluetoothScanError =
      'Could not scan for smartwatches. Check that Bluetooth is on.';

  // Choose a smartwatch screen (step 2)
  static const String chooseSmartwatchTitle = 'Choose a smartwatch';
  static const String chooseSmartwatchStep = 'Step 2 of 3';
  static const String smartwatchDetected = 'Smartwatch detected';
  static const String smartwatchDetectedMessage =
      'Your company-issued smartwatch is ready to connect for this shift.';
  static const String availableDevices = 'AVAILABLE DEVICES';
  static const String connectSmartwatch = 'Connect smartwatch';
  static const String connecting = 'Connecting…';
  static const String couldNotStartShift =
      'Could not start your shift. Please try again.';

  // Connected screen (step 3)
  static const String shiftProtectionActive = 'Shift protection active';
  static const String connectedSuccessfully = '• Connected successfully';
  static const String youAreConnected = 'You’re connected';
  static const String youAreConnectedMessage =
      'Your smartwatch is linked for the duration of this shift.';
  static const String workerLabel = 'WORKER';
  static const String smartwatchLabel = 'SMARTWATCH';
  static const String endSession = 'End session & close shift';
  static const String endingSession = 'Ending session…';
  static const String couldNotEndShift =
      'Could not end your shift. Please try again.';

  /// Text for the "1 found" / "3 found" part of the step 2 subtitle.
  static String devicesFound(int count) =>
      '$chooseSmartwatchStep · $count found';
}
