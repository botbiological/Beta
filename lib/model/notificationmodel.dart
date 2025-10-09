// Notification data model
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final String? profileImage;
  final NotificationType type;
  final bool isRead;
  final String? actionData; // For additional data like amounts, etc.

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.profileImage,
    required this.type,
    this.isRead = false,
    this.actionData,
  });
}

enum NotificationType {
  newTrack,
  bookRequest,
  reward,
  general,
  payment,
}
