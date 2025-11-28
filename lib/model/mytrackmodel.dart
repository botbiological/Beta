import 'package:cloud_firestore/cloud_firestore.dart';

class MyTrack {
  final String id;
  final String userId;
  final String title;
  final String artist;
  final String producer;
  final String imageAsset;
  final Duration duration;
  final String? audioUrl;
  final int playCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MyTrack({
    required this.id,
    required this.userId,
    required this.title,
    required this.artist,
    required this.producer,
    required this.imageAsset,
    required this.duration,
    this.audioUrl,
    this.playCount = 0,
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
    'audio_url': audioUrl,
    'play_count': playCount,
    'created_at': Timestamp.fromDate(createdAt),
    'updated_at': Timestamp.fromDate(updatedAt),
  };

  factory MyTrack.fromJson(Map<String, dynamic> json) => MyTrack(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String,
    artist: json['artist'] as String,
    producer: json['producer'] as String,
    imageAsset: json['image_asset'] as String,
    duration: Duration(seconds: json['duration_seconds'] as int),
    audioUrl: json['audio_url'] as String?,
    playCount: json['play_count'] as int? ?? 0,
    createdAt: (json['created_at'] as Timestamp).toDate(),
    updatedAt: (json['updated_at'] as Timestamp).toDate(),
  );

  MyTrack copyWith({
    String? id,
    String? userId,
    String? title,
    String? artist,
    String? producer,
    String? imageAsset,
    Duration? duration,
    String? audioUrl,
    int? playCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MyTrack(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    artist: artist ?? this.artist,
    producer: producer ?? this.producer,
    imageAsset: imageAsset ?? this.imageAsset,
    duration: duration ?? this.duration,
    audioUrl: audioUrl ?? this.audioUrl,
    playCount: playCount ?? this.playCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
