import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provide/model/notificationmodel.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'notifications';

  Future<NotificationItem?> getNotificationById(String notificationId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(notificationId).get();
      if (doc.exists) {
        return NotificationItem.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      debugPrint('Error getting notification: $e');
      rethrow;
    }
  }

  Future<String> createNotification(NotificationItem notification) async {
    try {
      final docRef = await _firestore.collection(_collection).add(notification.toJson());
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating notification: $e');
      rethrow;
    }
  }

  Future<void> updateNotification(NotificationItem notification) async {
    try {
      await _firestore.collection(_collection).doc(notification.id).update(
        notification.copyWith(updatedAt: DateTime.now()).toJson(),
      );
    } catch (e) {
      debugPrint('Error updating notification: $e');
      rethrow;
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firestore.collection(_collection).doc(notificationId).delete();
    } catch (e) {
      debugPrint('Error deleting notification: $e');
      rethrow;
    }
  }

  Future<List<NotificationItem>> getNotificationsByUser(String userId, {int limit = 50}) async {
    try {
      final snapshot = await _firestore
        .collection(_collection)
        .where('user_id', isEqualTo: userId)
        .orderBy('time', descending: true)
        .limit(limit)
        .get();
      
      return snapshot.docs.map(
        (doc) => NotificationItem.fromJson({...doc.data(), 'id': doc.id}),
      ).toList();
    } catch (e) {
      debugPrint('Error getting notifications by user: $e');
      rethrow;
    }
  }

  Stream<List<NotificationItem>> getNotificationsStream(String userId) {
    return _firestore
      .collection(_collection)
      .where('user_id', isEqualTo: userId)
      .orderBy('time', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map(
        (doc) => NotificationItem.fromJson({...doc.data(), 'id': doc.id}),
      ).toList());
  }

  Future<List<NotificationItem>> getUnreadNotifications(String userId) async {
    try {
      final snapshot = await _firestore
        .collection(_collection)
        .where('user_id', isEqualTo: userId)
        .where('is_read', isEqualTo: false)
        .orderBy('time', descending: true)
        .get();
      
      return snapshot.docs.map(
        (doc) => NotificationItem.fromJson({...doc.data(), 'id': doc.id}),
      ).toList();
    } catch (e) {
      debugPrint('Error getting unread notifications: $e');
      rethrow;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore.collection(_collection).doc(notificationId).update({
        'is_read': true,
        'updated_at': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
      rethrow;
    }
  }

  Future<void> markAllAsRead(String userId) async {
    try {
      final batch = _firestore.batch();
      final snapshot = await _firestore
        .collection(_collection)
        .where('user_id', isEqualTo: userId)
        .where('is_read', isEqualTo: false)
        .get();
      
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {
          'is_read': true,
          'updated_at': Timestamp.now(),
        });
      }
      
      await batch.commit();
    } catch (e) {
      debugPrint('Error marking all notifications as read: $e');
      rethrow;
    }
  }
}
