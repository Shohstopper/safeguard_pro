import 'smartwatch_model.dart';

/// The error a Bluetooth repository throws when scanning fails.
class BluetoothException implements Exception {
  const BluetoothException();
}

/// Finds nearby smartwatches over Bluetooth.
abstract class BluetoothRepository {
  Future<List<SmartwatchModel>> scanForSmartwatches();
}

/// What the fake scan should do. Change it in app.dart to try each screen.
enum MockScanOutcome { found, empty, failure }

/// Fake Bluetooth scan.
///
/// Note: real Bluetooth needs an extra package (and phone permissions), so
/// it is not built yet. The watch app talks to the backend directly; this
/// app only needs the watch's device ID to start the shift.
class MockBluetoothRepository implements BluetoothRepository {
  MockBluetoothRepository({
    this.outcome = MockScanOutcome.found,
    this.delay = const Duration(seconds: 1),
  });

  final MockScanOutcome outcome;

  /// How long the fake scan takes. Tests set this to zero.
  final Duration delay;

  /// The company-issued watch from the design and the API contract.
  static const SmartwatchModel guardianWatch = SmartwatchModel(
    deviceId: 'GW6-001',
    name: 'Guardian Watch Pro',
  );

  @override
  Future<List<SmartwatchModel>> scanForSmartwatches() async {
    await Future<void>.delayed(delay);

    switch (outcome) {
      case MockScanOutcome.found:
        return const [guardianWatch];
      case MockScanOutcome.empty:
        return const [];
      case MockScanOutcome.failure:
        throw const BluetoothException();
    }
  }
}
