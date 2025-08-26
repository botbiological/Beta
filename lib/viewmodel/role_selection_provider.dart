import 'package:flutter/material.dart';

class RoleSelectionProvider extends ChangeNotifier {
  // Available roles
  final List<String> _roles = ['Student', 'Mentor', 'Teacher'];
  
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
  String? get selectedRole => _selectedRoleIndex != -1 ? _roles[_selectedRoleIndex] : null;
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
      print("Role selected: ${_roles[index]} (index: $index)");
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
    print("Role selection cleared");
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

  // Continue with selected role (simulate API call or navigation logic)
  Future<bool> continueWithSelectedRole() async {
    if (!canContinue) {
      _setError("Please select a role before continuing");
      return false;
    }

    try {
      setLoading(true);
      
      // Simulate API call or processing
      await Future.delayed(Duration(milliseconds: 500));
      
      // Store selected role (you can add SharedPreferences or database logic here)
      await _storeSelectedRole();
      
      setLoading(false);
      print("Successfully processed role selection: ${_roles[_selectedRoleIndex]}");
      return true;
      
    } catch (e) {
      setLoading(false);
      _setError("Failed to process role selection: $e");
      return false;
    }
  }

  // Store selected role (placeholder for persistence logic)
  Future<void> _storeSelectedRole() async {
    // Add logic to store in SharedPreferences, database, or send to API
    print("Storing selected role: ${_roles[_selectedRoleIndex]}");
    // Example: await SharedPreferences.getInstance().setString('user_role', selectedRole!);
  }

  // Reset provider state
  void reset() {
    _selectedRoleIndex = -1;
    _isLoading = false;
    _isNavigating = false;
    _errorMessage = null;
    notifyListeners();
    print("Role selection provider reset");
  }

  // Private helper methods
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
    print("Role selection error: $message");
  }

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  // Get role color (for UI customization)
  Color getRoleColor(int index) {
    switch (index) {
      case 0: // Student
        return Colors.blue;
      case 1: // Mentor
        return Colors.green;
      case 2: // Teacher
        return Colors.orange;
      default:
        return Colors.grey;
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
    print("Role selection provider disposed");
    super.dispose();
  }
}
