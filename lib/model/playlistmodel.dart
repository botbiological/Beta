import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistTrack {
  final String id;
  final String userId;
  final String title;
  final String artist;
  final String producer;
  final String imageAsset;
  final Duration duration;
  final int playCount;
  final String? audioUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PlaylistTrack({
    required this.id,
    required this.userId,
    required this.title,
    required this.artist,
    required this.producer,
    required this.imageAsset,
    required this.duration,
    required this.playCount,
    this.audioUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'title': title,
    'artist': artist,
    'producer': producer,
    'image_asset': imageAsset,
    'duration_seconds': duration.inSeconds,
    'play_count': playCount,
    'audio_url': audioUrl,
    'created_at': Timestamp.fromDate(createdAt),
    'updated_at': Timestamp.fromDate(updatedAt),
  };

  factory PlaylistTrack.fromJson(Map<String, dynamic> json) => PlaylistTrack(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String,
    artist: json['artist'] as String,
    producer: json['producer'] as String,
    imageAsset: json['image_asset'] as String,
    duration: Duration(seconds: json['duration_seconds'] as int),
    playCount: json['play_count'] as int,
    audioUrl: json['audio_url'] as String?,
    createdAt: (json['created_at'] as Timestamp).toDate(),
    updatedAt: (json['updated_at'] as Timestamp).toDate(),
  );

  PlaylistTrack copyWith({
    String? id,
    String? userId,
    String? title,
    String? artist,
    String? producer,
    String? imageAsset,
    Duration? duration,
    int? playCount,
    String? audioUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PlaylistTrack(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    artist: artist ?? this.artist,
    producer: producer ?? this.producer,
    imageAsset: imageAsset ?? this.imageAsset,
    duration: duration ?? this.duration,
    playCount: playCount ?? this.playCount,
    audioUrl: audioUrl ?? this.audioUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
