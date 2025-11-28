import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provide/auth/firebase_auth_manager.dart';
import 'package:provide/model/user_model.dart';

class SignupProvider extends ChangeNotifier {
  final FirebaseAuthManager _authManager = FirebaseAuthManager();
  
  // Form controllers
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

  // Form validation (no confirm password check since it's not in the UI)
  bool get isFormValid {
    return _nameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.length >= 8 &&
        _acceptTerms &&
        _isValidEmail(_emailController.text.trim());
  }
  
  SignupProvider() {
    // Add listeners to update validation in real-time
    _nameController.addListener(_onFormChanged);
    _emailController.addListener(_onFormChanged);
    _passwordController.addListener(_onFormChanged);
  }
  
  void _onFormChanged() {
    notifyListeners();
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
    // Don't validate confirmPassword since it's not in the UI

    if (!_acceptTerms) {
      _generalError = "Please accept the terms and conditions";
      notifyListeners();
      return false;
    }

    return _nameError == null &&
        _emailError == null &&
        _passwordError == null;
  }

  // Sign up method - creates account and navigates to role selection
  Future<bool> signUp(UserRole role) async {
    if (_isLoading) return false;

    _clearAllErrors();

    if (!validateAll()) {
      return false;
    }

    try {
      setLoading(true);

      // Create account with Firebase
      final user = await _authManager.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
        role: role,
      );

      _signupSuccess = true;
      _successMessage = "Account created successfully!";
      if (kDebugMode) {
        print("=== SIGNUP SUCCESS ===");
        print("User: ${user.name} (${user.email})");
        print("Role: ${user.role}");
      }

      setLoading(false);
      return true;
    } catch (e) {
      setLoading(false);
      _generalError = e.toString();
      notifyListeners();
      if (kDebugMode) {
        print("Signup error: $e");
      }
      return false;
    }
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
    debugPrint("Signup provider reset");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    debugPrint("Signup provider disposed");
    super.dispose();
  }
}
