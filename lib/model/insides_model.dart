import 'package:cloud_firestore/cloud_firestore.dart';

class InsidesModel {
  final String id;
  final String userId;
  final String title;
  final String artist;
  final String producer;
  final String imageAsset;
  final int streams;
  final Duration duration;
  final String? audioUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InsidesModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.artist,
    required this.producer,
    required this.imageAsset,
    required this.streams,
    required this.duration,
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
    'streams': streams,
    'duration_seconds': duration.inSeconds,
    'audio_url': audioUrl,
    'created_at': Timestamp.fromDate(createdAt),
    'updated_at': Timestamp.fromDate(updatedAt),
  };

  factory InsidesModel.fromJson(Map<String, dynamic> json) => InsidesModel(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String,
    artist: json['artist'] as String,
    producer: json['producer'] as String,
    imageAsset: json['image_asset'] as String,
    streams: json['streams'] as int,
    duration: Duration(seconds: json['duration_seconds'] as int),
    audioUrl: json['audio_url'] as String?,
    createdAt: (json['created_at'] as Timestamp).toDate(),
    updatedAt: (json['updated_at'] as Timestamp).toDate(),
  );

  InsidesModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? artist,
    String? producer,
    String? imageAsset,
    int? streams,
    Duration? duration,
    String? audioUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InsidesModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    artist: artist ?? this.artist,
    producer: producer ?? this.producer,
    imageAsset: imageAsset ?? this.imageAsset,
    streams: streams ?? this.streams,
    duration: duration ?? this.duration,
    audioUrl: audioUrl ?? this.audioUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
