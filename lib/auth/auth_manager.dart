import 'package:provide/model/user_model.dart';

abstract class AuthManager {
  // Auth state
  Stream<UserModel?> get authStateChanges;
  UserModel? get currentUser;
  bool get isSignedIn;
  
  // Authentication methods
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  });
  
  Future<UserModel> signIn({
    required String email,
    required String password,
  });
  
  Future<void> signOut();
  
  Future<void> resetPassword(String email);
  
  Future<void> updateEmail(String newEmail);
  
  Future<void> updatePassword(String newPassword);
  
  Future<void> deleteAccount();
}
