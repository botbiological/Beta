import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  // Form controllers (you can inject these or manage them here)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Form state
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;

  // Validation state
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _generalError;

  // Success state
  bool _signupSuccess = false;
  String? _successMessage;

  // Getters for controllers
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  // Getters for state
  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get acceptTerms => _acceptTerms;
  bool get signupSuccess => _signupSuccess;

  // Getters for validation
  String? get nameError => _nameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get generalError => _generalError;
  String? get successMessage => _successMessage;

  // Form validation
  bool get isFormValid {
    return _nameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.length >= 8 &&
        _confirmPasswordController.text == _passwordController.text &&
        _acceptTerms &&
        _isValidEmail(_emailController.text.trim());
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  // Toggle terms acceptance
  void toggleTermsAcceptance(bool? value) {
    _acceptTerms = value ?? false;
    _clearValidationErrors();
    notifyListeners();
  }

  // Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Validate individual fields
  void validateName() {
    String name = _nameController.text.trim();
    if (name.isEmpty) {
      _nameError = "Name is required";
    } else if (name.length < 2) {
      _nameError = "Name must be at least 2 characters";
    } else {
      _nameError = null;
    }
    notifyListeners();
  }

  void validateEmail() {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      _emailError = "Email is required";
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
      _passwordError = "Password is required";
    } else if (password.length < 8) {
      _passwordError = "Password must be at least 8 characters";
    } else if (!_isStrongPassword(password)) {
      _passwordError =
          "Password must contain uppercase, lowercase, and numbers";
    } else {
      _passwordError = null;
    }
    notifyListeners();
  }

  void validateConfirmPassword() {
    String confirmPassword = _confirmPasswordController.text;
    String password = _passwordController.text;

    if (confirmPassword.isEmpty) {
      _confirmPasswordError = "Please confirm your password";
    } else if (confirmPassword != password) {
      _confirmPasswordError = "Passwords do not match";
    } else {
      _confirmPasswordError = null;
    }
    notifyListeners();
  }

  // Validate all fields
  bool validateAll() {
    validateName();
    validateEmail();
    validatePassword();
    validateConfirmPassword();

    if (!_acceptTerms) {
      _generalError = "Please accept the terms and conditions";
      notifyListeners();
      return false;
    }

    return _nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;
  }

  // Sign up method
  Future<bool> signUp() async {
    if (_isLoading) return false;

    _clearAllErrors();

    if (!validateAll()) {
      return false;
    }

    try {
      setLoading(true);

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Simulate API response (replace with actual API call)
      bool success = await _performSignupAPI();

      if (success) {
        _signupSuccess = true;
        _successMessage =
            "Account created successfully! Please check your email for verification.";
        if (kDebugMode) {
          print("Signup successful for: ${_emailController.text}");
        }

        // Clear form after successful signup
        _clearForm();
      }

      setLoading(false);
      return success;
    } catch (e) {
      setLoading(false);
      _generalError = "Failed to create account. Please try again.";
      notifyListeners();
      if (kDebugMode) {
        print("Signup error: $e");
      }
      return false;
    }
  }

  // Simulate API call (replace with actual implementation)
  Future<bool> _performSignupAPI() async {
    // Replace this with actual API call
    Map<String, String> userData = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
    };
 if (kDebugMode) {
 print("Sending signup data: ${userData.keys}");
      }
   
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));

    // Simulate success (90% success rate for demo)
    return true; // In real app, return based on API response
  }

  // Helper methods
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isStrongPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _acceptTerms = false;
  }

  void _clearValidationErrors() {
    _nameError = null;
    _emailError = null;
    _passwordError = null;
    _confirmPasswordError = null;
    _generalError = null;
  }

  void _clearAllErrors() {
    _clearValidationErrors();
    _successMessage = null;
    _signupSuccess = false;
  }

  // Reset provider state
  void reset() {
    _clearForm();
    _clearAllErrors();
    _isLoading = false;
    _obscurePassword = true;
    _obscureConfirmPassword = true;
    notifyListeners();
    print("Signup provider reset");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    print("Signup provider disposed");
    super.dispose();
  }
}
