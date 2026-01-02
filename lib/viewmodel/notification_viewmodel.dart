// Notification view model - for Firebase integration, use NotificationService directly
import 'package:provide/model/notificationmodel.dart';

class NotificationViewModel {
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      userId: 'demo_user',
      title: 'New Track from Mr Audio',
      message: 'Mr Audio has uploaded a new Digital audio clip mp3',
      time: DateTime.now().subtract(Duration(hours: 2)),
      profileImage: 'assets/images/user_profile.png',
      type: NotificationType.newTrack,
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(Duration(hours: 2)),
    ),
    NotificationItem(
      id: '2',
      userId: 'demo_user',
      title: 'You received a Book by Maya Weave',
      message: 'You\'ve received a booking request from Maya Weave',
      time: DateTime.now().subtract(Duration(hours: 4)),
      profileImage: 'assets/images/havana.png',
      type: NotificationType.bookRequest,
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(hours: 4)),
      updatedAt: DateTime.now().subtract(Duration(hours: 4)),
    ),
    NotificationItem(
      id: '3',
      userId: 'demo_user',
      title: 'You rewarded \$100 to Zara Fitz',
      message: 'For live streams and social media engagement',
      time: DateTime.now().subtract(Duration(days: 1)),
      profileImage: 'assets/images/nelda.png',
      type: NotificationType.reward,
      isRead: true,
      actionData: '\$100',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      updatedAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  List<NotificationItem> getUnreadNotifications() {
    return notifications.where((notification) => !notification.isRead).toList();
  }

  int getUnreadCount() {
    return getUnreadNotifications().length;
  }

  void markAsRead(String notificationId) {
    // In Firebase app, use NotificationService.markAsRead()
  }

  void markAllAsRead() {
    // In Firebase app, use NotificationService.markAllAsRead()
  }
}
