import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  newTrack,
  bookRequest,
  reward,
  general,
  payment,
}

class NotificationItem {
  final String id;
  final String userId;
  final String title;
  final String message;
  final DateTime time;
  final String? profileImage;
  final NotificationType type;
  final bool isRead;
  final String? actionData;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotificationItem({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.time,
    this.profileImage,
    required this.type,
    this.isRead = false,
    this.actionData,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'title': title,
    'message': message,
    'time': Timestamp.fromDate(time),
    'profile_image': profileImage,
    'type': type.name,
    'is_read': isRead,
    'action_data': actionData,
    'created_at': Timestamp.fromDate(createdAt),
    'updated_at': Timestamp.fromDate(updatedAt),
  };

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String,
    message: json['message'] as String,
    time: (json['time'] as Timestamp).toDate(),
    profileImage: json['profile_image'] as String?,
    type: NotificationType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => NotificationType.general,
    ),
    isRead: json['is_read'] as bool? ?? false,
    actionData: json['action_data'] as String?,
    createdAt: (json['created_at'] as Timestamp).toDate(),
    updatedAt: (json['updated_at'] as Timestamp).toDate(),
  );

  NotificationItem copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    DateTime? time,
    String? profileImage,
    NotificationType? type,
    bool? isRead,
    String? actionData,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => NotificationItem(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    message: message ?? this.message,
    time: time ?? this.time,
    profileImage: profileImage ?? this.profileImage,
    type: type ?? this.type,
    isRead: isRead ?? this.isRead,
    actionData: actionData ?? this.actionData,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
