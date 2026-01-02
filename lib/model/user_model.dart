import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { artist, producer, dj, user }

class UserModel {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final String? bio;
  final String? genre;
  final List<String> genreTags;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPremium;
  final List<String> savedTracks;
  final List<String> savedArtists;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    this.bio,
    this.genre,
    this.genreTags = const [],
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.isPremium = false,
    this.savedTracks = const [],
    this.savedArtists = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'profile_image': profileImage,
    'bio': bio,
    'genre': genre,
    'genre_tags': genreTags,
    'role': role.name,
    'created_at': Timestamp.fromDate(createdAt),
    'updated_at': Timestamp.fromDate(updatedAt),
    'is_premium': isPremium,
    'saved_tracks': savedTracks,
    'saved_artists': savedArtists,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    profileImage: json['profile_image'] as String?,
    bio: json['bio'] as String?,
    genre: json['genre'] as String?,
    genreTags: List<String>.from(json['genre_tags'] ?? []),
    role: UserRole.values.firstWhere(
      (e) => e.name == json['role'],
      orElse: () => UserRole.user,
    ),
    createdAt: (json['created_at'] as Timestamp).toDate(),
    updatedAt: (json['updated_at'] as Timestamp).toDate(),
    isPremium: json['is_premium'] as bool? ?? false,
    savedTracks: List<String>.from(json['saved_tracks'] ?? []),
    savedArtists: List<String>.from(json['saved_artists'] ?? []),
  );

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImage,
    String? bio,
    String? genre,
    List<String>? genreTags,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPremium,
    List<String>? savedTracks,
    List<String>? savedArtists,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
    profileImage: profileImage ?? this.profileImage,
    bio: bio ?? this.bio,
    genre: genre ?? this.genre,
    genreTags: genreTags ?? this.genreTags,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isPremium: isPremium ?? this.isPremium,
    savedTracks: savedTracks ?? this.savedTracks,
    savedArtists: savedArtists ?? this.savedArtists,
  );
}
