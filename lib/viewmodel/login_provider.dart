import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  // Form controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form state
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  // Validation state
  String? _emailError;
  String? _passwordError;
  String? _generalError;

  // Success state
  bool _loginSuccess = false;
  String? _successMessage;

  // Forgot password state
  bool _isForgotPasswordLoading = false;
  String? _forgotPasswordEmail;
  bool _showOtpField = false;
  String? _forgotPasswordError;
  String? _forgotPasswordSuccess;

  // Getters for controllers
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  // Getters for state
  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  bool get rememberMe => _rememberMe;
  bool get loginSuccess => _loginSuccess;

  // Getters for validation
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get generalError => _generalError;
  String? get successMessage => _successMessage;

  // Getters for forgot password
  bool get isForgotPasswordLoading => _isForgotPasswordLoading;
  String? get forgotPasswordEmail => _forgotPasswordEmail;
  bool get showOtpField => _showOtpField;
  String? get forgotPasswordError => _forgotPasswordError;
  String? get forgotPasswordSuccess => _forgotPasswordSuccess;

  // Form validation
  bool get isFormValid {
    return _emailController.text.trim().isNotEmpty &&
        _passwordController.text.length >= 8 &&
        _isValidEmail(_emailController.text.trim());
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  // Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Validate individual fields
  void validateEmail() {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      _emailError = "Please Enter Email First";
    } else if (!_isValidEmail(email)) {
      _emailError = "Please enter a valid email";
    } else {
      _emailError = null;
    }
    notifyListeners();
  }

  void validatePassword() {
    String password = _passwordController.text;
    if (password.isEmpty) {
      _passwordError = "Please Enter Password First";
    } else if (password.length < 8) {
      _passwordError = "Please Enter 8 digits";
    } else {
      _passwordError = null;
    }
    notifyListeners();
  }

  // Validate all fields
  bool validateAll() {
    validateEmail();
    validatePassword();

    return _emailError == null && _passwordError == null;
  }

  // Login method
  Future<bool> login() async {
    if (_isLoading) return false;

    _clearErrors();

    if (!validateAll()) {
      return false;
    }

    try {
      setLoading(true);

      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      // Simulate API response (replace with actual API call)
      bool success = await _performLoginAPI();

      if (success) {
        _loginSuccess = true;
        _successMessage = "Login successful! Redirecting...";
        if (kDebugMode) {
          print("=== LOGIN SUCCESS ===");
          print("Email: ${_emailController.text}");
          print("Remember me: $_rememberMe");
        }

        // Store login state if remember me is checked
        if (_rememberMe) {
          await _storeLoginCredentials();
        }
      }

      setLoading(false);
      return success;
    } catch (e) {
      setLoading(false);
      _generalError = "Login failed. Please check your credentials.";
      notifyListeners();
      if (kDebugMode) {
        print("Login error: $e");
      }

      return false;
    }
  }

  // Simulate API call (replace with actual implementation)
  Future<bool> _performLoginAPI() async {
    // Replace this with actual API call
    Map<String, String> loginData = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
    };
    if (kDebugMode) {
      print("Sending login data for: ${loginData['email']}");
    }

    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));

    // Simulate success (replace with actual API validation)
    return true; // In real app, return based on API response
  }

  // Store login credentials (placeholder)
  Future<void> _storeLoginCredentials() async {
    // Add logic to store in SharedPreferences or secure storage
    print("Storing login credentials (Remember Me enabled)");
    // Example: await SharedPreferences.getInstance().setString('saved_email', _emailController.text);
  }

  // Forgot Password Methods
  void setForgotPasswordLoading(bool loading) {
    _isForgotPasswordLoading = loading;
    notifyListeners();
  }

  Future<bool> sendForgotPasswordOTP(String email) async {
    if (_isForgotPasswordLoading) return false;

    _clearForgotPasswordErrors();

    if (email.trim().isEmpty) {
      _forgotPasswordError = "Please enter your email";
      notifyListeners();
      return false;
    }

    if (!_isValidEmail(email.trim())) {
      _forgotPasswordError = "Please enter a valid email";
      notifyListeners();
      return false;
    }

    try {
      setForgotPasswordLoading(true);

      // Simulate API call to send OTP
      await Future.delayed(Duration(seconds: 1));

      _forgotPasswordEmail = email.trim();
      _showOtpField = true;
      _forgotPasswordSuccess = "OTP sent to $email";

      setForgotPasswordLoading(false);
      print("OTP sent to: $email");
      return true;
    } catch (e) {
      setForgotPasswordLoading(false);
      _forgotPasswordError = "Failed to send OTP. Please try again.";
      notifyListeners();
      print("Forgot password error: $e");
      return false;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    if (_isForgotPasswordLoading) return false;

    _clearForgotPasswordErrors();

    if (otp.trim().isEmpty) {
      _forgotPasswordError = "Please enter the OTP";
      notifyListeners();
      return false;
    }

    if (otp.trim().length != 6) {
      _forgotPasswordError = "Please enter a valid 6-digit OTP";
      notifyListeners();
      return false;
    }

    try {
      setForgotPasswordLoading(true);

      // Simulate API call to verify OTP
      await Future.delayed(Duration(seconds: 1));

      _forgotPasswordSuccess =
          "Password reset successful! Check your email for new password";

      setForgotPasswordLoading(false);
      print("OTP verified: $otp");
      return true;
    } catch (e) {
      setForgotPasswordLoading(false);
      _forgotPasswordError = "Invalid OTP. Please try again.";
      notifyListeners();
      print("OTP verification error: $e");
      return false;
    }
  }

  void resetForgotPasswordFlow() {
    _showOtpField = false;
    _forgotPasswordEmail = null;
    _clearForgotPasswordErrors();
    notifyListeners();
  }

  // Helper methods
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _clearErrors() {
    _emailError = null;
    _passwordError = null;
    _generalError = null;
    _successMessage = null;
    _loginSuccess = false;
  }

  void _clearForgotPasswordErrors() {
    _forgotPasswordError = null;
    _forgotPasswordSuccess = null;
  }

  // Clear form
  void clearForm() {
    _emailController.clear();
    _passwordController.clear();
    _rememberMe = false;
    _clearErrors();
    notifyListeners();
  }

  // Reset provider state
  void reset() {
    clearForm();
    _obscurePassword = true;
    resetForgotPasswordFlow();
    setLoading(false);
    setForgotPasswordLoading(false);
    print("Login provider reset");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    print("Login provider disposed");
    super.dispose();
  }
}
