import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterNotifier extends ChangeNotifier {
  bool _hasRegistered = false;
  bool _isReady = false;

  bool get hasRegistered => _hasRegistered;
  bool get isReady => _isReady;

  RegisterNotifier() {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _hasRegistered = prefs.getBool('registered') ?? false;
    _isReady = true;
    notifyListeners();
  }

  Future<void> completeRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('registered', true);
    _hasRegistered = true;
    notifyListeners();
  }
}

// Instantiate it HERE instead of inside the router file
final RegisterNotifier registerNotifier = RegisterNotifier();
