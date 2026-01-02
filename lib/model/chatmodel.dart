import 'package:cloud_firestore/cloud_firestore.dart';

class ChatItem {
  final String id;
  final String userId;
  final String name;
  final String lastMessage;
  final DateTime time;
  final String profileImage;
  final bool isOnline;
  final int unreadCount;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ChatItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profileImage,
    this.isOnline = false,
    this.unreadCount = 0,
    this.isRead = true,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
    'last_message': lastMessage,
    'time': Timestamp.fromDate(time),
    'profile_image': profileImage,
    'is_online': isOnline,
    'unread_count': unreadCount,
    'is_read': isRead,
    'created_at': Timestamp.fromDate(createdAt),
    'updated_at': Timestamp.fromDate(updatedAt),
  };

  factory ChatItem.fromJson(Map<String, dynamic> json) => ChatItem(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    name: json['name'] as String,
    lastMessage: json['last_message'] as String,
    time: (json['time'] as Timestamp).toDate(),
    profileImage: json['profile_image'] as String,
    isOnline: json['is_online'] as bool? ?? false,
    unreadCount: json['unread_count'] as int? ?? 0,
    isRead: json['is_read'] as bool? ?? true,
    createdAt: (json['created_at'] as Timestamp).toDate(),
    updatedAt: (json['updated_at'] as Timestamp).toDate(),
  );

  ChatItem copyWith({
    String? id,
    String? userId,
    String? name,
    String? lastMessage,
    DateTime? time,
    String? profileImage,
    bool? isOnline,
    int? unreadCount,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ChatItem(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    lastMessage: lastMessage ?? this.lastMessage,
    time: time ?? this.time,
    profileImage: profileImage ?? this.profileImage,
    isOnline: isOnline ?? this.isOnline,
    unreadCount: unreadCount ?? this.unreadCount,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
