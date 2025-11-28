import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:provide/auth/auth_manager.dart';
import 'package:provide/model/user_model.dart';
import 'package:provide/services/user_service.dart';

class FirebaseAuthManager implements AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();
  
  UserModel? _currentUser;

  @override
  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        _currentUser = null;
        return null;
      }
      
      try {
        final user = await _userService.getUserById(firebaseUser.uid);
        _currentUser = user;
        return user;
      } catch (e) {
        debugPrint('Error getting user data: $e');
        _currentUser = null;
        return null;
      }
    });
  }

  @override
  UserModel? get currentUser => _currentUser;

  @override
  bool get isSignedIn => _auth.currentUser != null;

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    try {
      debugPrint('=== FIREBASE SIGNUP START ===');
      debugPrint('Email: $email');
      debugPrint('Name: $name');
      debugPrint('Role: $role');
      
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('Firebase Auth User Created: ${credential.user?.uid}');

      if (credential.user == null) {
        throw Exception('Failed to create user');
      }

      final now = DateTime.now();
      final user = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        role: role,
        createdAt: now,
        updatedAt: now,
      );

      debugPrint('Creating user document in Firestore...');
      await _userService.createUser(user);
      debugPrint('User document created successfully');
      
      _currentUser = user;
      
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('=== FIREBASE AUTH EXCEPTION ===');
      debugPrint('Code: ${e.code}');
      debugPrint('Message: ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('=== SIGNUP ERROR ===');
      debugPrint('Error: $e');
      rethrow;
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Failed to sign in');
      }

      final user = await _userService.getUserById(credential.user!.uid);
      if (user == null) {
        throw Exception('User data not found');
      }

      _currentUser = user;
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign in error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Sign in error: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser = null;
    } catch (e) {
      debugPrint('Sign out error: $e');
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint('Reset password error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Reset password error: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user signed in');
      
      await user.verifyBeforeUpdateEmail(newEmail);
      
      if (_currentUser != null) {
        final updatedUser = _currentUser!.copyWith(
          email: newEmail,
          updatedAt: DateTime.now(),
        );
        await _userService.updateUser(updatedUser);
        _currentUser = updatedUser;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Update email error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Update email error: $e');
      rethrow;
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user signed in');
      
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      debugPrint('Update password error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Update password error: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user signed in');
      
      await _userService.deleteUser(user.uid);
      await user.delete();
      _currentUser = null;
    } on FirebaseAuthException catch (e) {
      debugPrint('Delete account error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      debugPrint('Delete account error: $e');
      rethrow;
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'requires-recent-login':
        return 'Please sign in again to complete this action.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
}
