import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provide/model/user_model.dart';

class RoleSelectionProvider extends ChangeNotifier {
  // Available roles
  final List<String> _roles = ['User', 'Artist', 'Producer', 'Dj'];

  // Currently selected role index (-1 means no selection)
  int _selectedRoleIndex = -1;

  // Loading states
  bool _isLoading = false;
  bool _isNavigating = false;

  // Error handling
  String? _errorMessage;

  // Getters
  List<String> get roles => _roles;
  int get selectedRoleIndex => _selectedRoleIndex;
  String? get selectedRole =>
      _selectedRoleIndex != -1 ? _roles[_selectedRoleIndex] : null;
  bool get isRoleSelected => _selectedRoleIndex != -1;
  bool get isLoading => _isLoading;
  bool get isNavigating => _isNavigating;
  String? get errorMessage => _errorMessage;
  bool get canContinue => !_isLoading && _selectedRoleIndex != -1;

  // Select a role by index
  void selectRole(int index) {
    if (index >= 0 && index < _roles.length) {
      _selectedRoleIndex = index;
      _clearError();
      notifyListeners();
      if (kDebugMode) {
        print("Role selected: ${_roles[index]} (index: $index)");
      }
    }
  }

  // Select a role by name
  void selectRoleByName(String roleName) {
    int index = _roles.indexOf(roleName);
    if (index != -1) {
      selectRole(index);
    } else {
      _setError("Invalid role: $roleName");
    }
  }

  // Clear selection
  void clearSelection() {
    _selectedRoleIndex = -1;
    _clearError();
    notifyListeners();
    if (kDebugMode) {
      print("Role selection cleared");
    }
  }

  // Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set navigation state
  void setNavigating(bool navigating) {
    _isNavigating = navigating;
    notifyListeners();
  }

  // Continue with selected role
  Future<bool> continueWithSelectedRole() async {
    if (!canContinue) {
      _setError("Please select a role before continuing");
      return false;
    }

    try {
      setLoading(true);

      // Store selected role
      await _storeSelectedRole();

      setLoading(false);
      if (kDebugMode) {
        print(
          "Successfully processed role selection: ${_roles[_selectedRoleIndex]}",
        );
      }
      return true;
    } catch (e) {
      setLoading(false);
      _setError("Failed to process role selection: $e");
      return false;
    }
  }
  
  // Get UserRole enum from selected role string
  UserRole? getUserRole() {
    if (_selectedRoleIndex == -1) return null;
    
    switch (_roles[_selectedRoleIndex].toLowerCase()) {
      case 'user':
        return UserRole.user;
      case 'artist':
        return UserRole.artist;
      case 'producer':
        return UserRole.producer;
      case 'dj':
        return UserRole.dj;
      default:
        return UserRole.user;
    }
  }

  // // Store selected role (placeholder for persistence logic)
  // Future<void> _storeSelectedRole() async {
  //   // Add logic to store in SharedPreferences, database, or send to API

  //   if (kDebugMode) {
  //     print("Storing selected role: ${_roles[_selectedRoleIndex]}");
  //   } // Example: await SharedPreferences.getInstance().setString('user_role', selectedRole!);
  // }

  Future<void> _storeSelectedRole() async {
    if (_selectedRoleIndex == -1) return; // no role selected

    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Store the selected role as a string
    await prefs.setString('user_role', selectedRole!);

    if (kDebugMode) {
      print("Stored selected role in SharedPreferences: ${selectedRole!}");
    }
  }

  // Reset provider state
  void reset() {
    _selectedRoleIndex = -1;
    _isLoading = false;
    _isNavigating = false;
    _errorMessage = null;
    notifyListeners();
    if (kDebugMode) {
      print("Role selection provider reset");
    }
  }

  // Private helper methods
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
    if (kDebugMode) {
      print("Role selection error: $message");
    }
  }

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  // Get role icon (for UI customization)
  IconData getRoleIcon(int index) {
    switch (index) {
      case 0: // Student
        return Icons.school;
      case 1: // Mentor
        return Icons.support_agent;
      case 2: // Teacher
        return Icons.person;
      default:
        return Icons.person;
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print("Role selection provider disposed");
    }

    super.dispose();
  }
}
