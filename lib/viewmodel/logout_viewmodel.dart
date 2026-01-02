import 'package:flutter/widgets.dart';
import 'package:provide/auth/firebase_auth_manager.dart';

class LogoutViewmodel extends ChangeNotifier {
  final FirebaseAuthManager _authManager = FirebaseAuthManager();
  bool _isloggingOut = false;
  String? _logouterror;
  bool _logoutSuccess = false;

  bool get isloggingOut => _isloggingOut;
  String? get logouterror => _logouterror;
  bool get logoutSuccess => _logoutSuccess;

  Future<bool> logout() async {
    if (_isloggingOut) {
      return false;
    }

    _isloggingOut = true;
    _logouterror = null;
    _logoutSuccess = false;
    notifyListeners();

    try {
      await _authManager.signOut();

      _isloggingOut = false;
      _logoutSuccess = true;
      notifyListeners();

      return true;
    } catch (e) {
      _isloggingOut = false;
      _logouterror = e.toString();
      notifyListeners();

      debugPrint("Logout error : $e");

      return false;
    }
  }

  void reset() {
    _isloggingOut = false;
    _logouterror = null;
    _logoutSuccess = false;
    notifyListeners();
  }
}
