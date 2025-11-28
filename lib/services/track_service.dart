import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provide/model/mytrackmodel.dart';

class TrackService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'tracks';

  Future<MyTrack?> getTrackById(String trackId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(trackId).get();
      if (doc.exists) {
        return MyTrack.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      debugPrint('Error getting track: $e');
      rethrow;
    }
  }

  Future<String> createTrack(MyTrack track) async {
    try {
      final docRef = await _firestore.collection(_collection).add(track.toJson());
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating track: $e');
      rethrow;
    }
  }

  Future<void> updateTrack(MyTrack track) async {
    try {
      await _firestore.collection(_collection).doc(track.id).update(
        track.copyWith(updatedAt: DateTime.now()).toJson(),
      );
    } catch (e) {
      debugPrint('Error updating track: $e');
      rethrow;
    }
  }

  Future<void> deleteTrack(String trackId) async {
    try {
      await _firestore.collection(_collection).doc(trackId).delete();
    } catch (e) {
      debugPrint('Error deleting track: $e');
      rethrow;
    }
  }

  Future<List<MyTrack>> getTracksByUser(String userId, {int limit = 20}) async {
    try {
      final snapshot = await _firestore
        .collection(_collection)
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .limit(limit)
        .get();
      
      return snapshot.docs.map(
        (doc) => MyTrack.fromJson({...doc.data(), 'id': doc.id}),
      ).toList();
    } catch (e) {
      debugPrint('Error getting tracks by user: $e');
      rethrow;
    }
  }

  Stream<List<MyTrack>> getTracksStream({int limit = 20}) {
    return _firestore
      .collection(_collection)
      .orderBy('created_at', descending: true)
      .limit(limit)
      .snapshots()
      .map((snapshot) => snapshot.docs.map(
        (doc) => MyTrack.fromJson({...doc.data(), 'id': doc.id}),
      ).toList());
  }

  Future<List<MyTrack>> getPopularTracks({int limit = 20}) async {
    try {
      final snapshot = await _firestore
        .collection(_collection)
        .orderBy('play_count', descending: true)
        .limit(limit)
        .get();
      
      return snapshot.docs.map(
        (doc) => MyTrack.fromJson({...doc.data(), 'id': doc.id}),
      ).toList();
    } catch (e) {
      debugPrint('Error getting popular tracks: $e');
      rethrow;
    }
  }

  Future<void> incrementPlayCount(String trackId) async {
    try {
      await _firestore.collection(_collection).doc(trackId).update({
        'play_count': FieldValue.increment(1),
        'updated_at': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Error incrementing play count: $e');
      rethrow;
    }
  }

  Future<List<MyTrack>> searchTracks(String query, {int limit = 20}) async {
    try {
      final snapshot = await _firestore
        .collection(_collection)
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(limit)
        .get();
      
      return snapshot.docs.map(
        (doc) => MyTrack.fromJson({...doc.data(), 'id': doc.id}),
      ).toList();
    } catch (e) {
      debugPrint('Error searching tracks: $e');
      rethrow;
    }
  }
}
