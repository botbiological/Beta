import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provide/model/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'users';

  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user: $e');
      rethrow;
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      debugPrint('=== CREATING USER DOCUMENT ===');
      debugPrint('User ID: ${user.id}');
      debugPrint('User Data: ${user.toJson()}');
      
      await _firestore.collection(_collection).doc(user.id).set(user.toJson());
      
      debugPrint('User document created successfully in Firestore');
    } catch (e) {
      debugPrint('=== ERROR CREATING USER ===');
      debugPrint('Error type: ${e.runtimeType}');
      debugPrint('Error: $e');
      rethrow;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection(_collection).doc(user.id).update(
        user.copyWith(updatedAt: DateTime.now()).toJson(),
      );
    } catch (e) {
      debugPrint('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection(_collection).doc(userId).delete();
    } catch (e) {
      debugPrint('Error deleting user: $e');
      rethrow;
    }
  }

  Stream<UserModel?> getUserStream(String userId) {
    return _firestore.collection(_collection).doc(userId).snapshots().map(
      (doc) => doc.exists ? UserModel.fromJson({...doc.data()!, 'id': doc.id}) : null,
    );
  }

  Future<List<UserModel>> getUsersByRole(UserRole role, {int limit = 20}) async {
    try {
      final snapshot = await _firestore
        .collection(_collection)
        .where('role', isEqualTo: role.name)
        .limit(limit)
        .get();
      
      return snapshot.docs.map(
        (doc) => UserModel.fromJson({...doc.data(), 'id': doc.id}),
      ).toList();
    } catch (e) {
      debugPrint('Error getting users by role: $e');
      rethrow;
    }
  }

  Future<void> addSavedTrack(String userId, String trackId) async {
    try {
      await _firestore.collection(_collection).doc(userId).update({
        'saved_tracks': FieldValue.arrayUnion([trackId]),
        'updated_at': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error adding saved track: $e');
      rethrow;
    }
  }

  Future<void> removeSavedTrack(String userId, String trackId) async {
    try {
      await _firestore.collection(_collection).doc(userId).update({
        'saved_tracks': FieldValue.arrayRemove([trackId]),
        'updated_at': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error removing saved track: $e');
      rethrow;
    }
  }

  Future<void> addSavedArtist(String userId, String artistId) async {
    try {
      await _firestore.collection(_collection).doc(userId).update({
        'saved_artists': FieldValue.arrayUnion([artistId]),
        'updated_at': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error adding saved artist: $e');
      rethrow;
    }
  }

  Future<void> removeSavedArtist(String userId, String artistId) async {
    try {
      await _firestore.collection(_collection).doc(userId).update({
        'saved_artists': FieldValue.arrayRemove([artistId]),
        'updated_at': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error removing saved artist: $e');
      rethrow;
    }
  }
}
