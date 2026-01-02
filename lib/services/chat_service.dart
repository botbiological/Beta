import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provide/model/chatmodel.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'chats';

  Future<ChatItem?> getChatById(String chatId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(chatId).get();
      if (doc.exists) {
        return ChatItem.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      debugPrint('Error getting chat: $e');
      rethrow;
    }
  }

  Future<String> createChat(ChatItem chat) async {
    try {
      final docRef = await _firestore.collection(_collection).add(chat.toJson());
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating chat: $e');
      rethrow;
    }
  }

  Future<void> updateChat(ChatItem chat) async {
    try {
      await _firestore.collection(_collection).doc(chat.id).update(
        chat.copyWith(updatedAt: DateTime.now()).toJson(),
      );
    } catch (e) {
      debugPrint('Error updating chat: $e');
      rethrow;
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await _firestore.collection(_collection).doc(chatId).delete();
    } catch (e) {
      debugPrint('Error deleting chat: $e');
      rethrow;
    }
  }

  Future<List<ChatItem>> getChatsByUser(String userId, {int limit = 50}) async {
    try {
      final snapshot = await _firestore
        .collection(_collection)
        .where('user_id', isEqualTo: userId)
        .orderBy('time', descending: true)
        .limit(limit)
        .get();
      
      return snapshot.docs.map(
        (doc) => ChatItem.fromJson({...doc.data(), 'id': doc.id}),
      ).toList();
    } catch (e) {
      debugPrint('Error getting chats by user: $e');
      rethrow;
    }
  }

  Stream<List<ChatItem>> getChatsStream(String userId) {
    return _firestore
      .collection(_collection)
      .where('user_id', isEqualTo: userId)
      .orderBy('time', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map(
        (doc) => ChatItem.fromJson({...doc.data(), 'id': doc.id}),
      ).toList());
  }

  Future<void> markAsRead(String chatId) async {
    try {
      await _firestore.collection(_collection).doc(chatId).update({
        'is_read': true,
        'unread_count': 0,
        'updated_at': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error marking chat as read: $e');
      rethrow;
    }
  }

  Future<void> updateLastMessage(String chatId, String message) async {
    try {
      await _firestore.collection(_collection).doc(chatId).update({
        'last_message': message,
        'time': Timestamp.now(),
        'is_read': false,
        'updated_at': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error updating last message: $e');
      rethrow;
    }
  }

  Future<List<ChatItem>> searchChats(String userId, String query, {int limit = 20}) async {
    try {
      final snapshot = await _firestore
        .collection(_collection)
        .where('user_id', isEqualTo: userId)
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(limit)
        .get();
      
      return snapshot.docs.map(
        (doc) => ChatItem.fromJson({...doc.data(), 'id': doc.id}),
      ).toList();
    } catch (e) {
      debugPrint('Error searching chats: $e');
      rethrow;
    }
  }
}
