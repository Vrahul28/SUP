import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Check if biometric authentication is available
  Future<bool> hasBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  // Print available biometrics
  Future<void> checkBiometricType() async {
    final availableBiometrics = await _localAuth.getAvailableBiometrics();
    print('Available biometrics: $availableBiometrics');
  }

  // Authenticate user
  Future<bool> authenticate() async {
    final hasBiometric = await hasBiometrics();

    if (!hasBiometric) return false;

    try {
      return await _localAuth.authenticate(
        localizedReason: "Scan your fingerprint to authenticate",
        biometricOnly: false,
      );
    } on PlatformException catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
