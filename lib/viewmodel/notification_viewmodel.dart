// Notification view model with sample data
import 'package:provide/model/notificationmodel.dart';

class NotificationViewModel {
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'New Track from Mr Audio',
      message: 'Mr Audio has uploaded a new Digital audio clip mp3',
      time: '2h ago',
      profileImage: 'assets/images/user_profile.png',
      type: NotificationType.newTrack,
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      title: 'You received a Book by Maya Weave',
      message: 'You\'ve received a booking request from Maya Weave',
      time: '4h ago',
      profileImage: 'assets/images/havana.png',
      type: NotificationType.bookRequest,
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      title: 'You rewarded \$100 to Zara Fitz',
      message: 'For live streams and social media engagement',
      time: '1d ago',
      profileImage: 'assets/images/nelda.png',
      type: NotificationType.reward,
      isRead: true,
      actionData: '\$100',
    ),
  ];

  List<NotificationItem> getUnreadNotifications() {
    return notifications.where((notification) => !notification.isRead).toList();
  }

  int getUnreadCount() {
    return getUnreadNotifications().length;
  }

  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      // In a real app, you would update this in the backend/database
      // notifications[index] = notifications[index].copyWith(isRead: true);
    }
  }

  void markAllAsRead() {
    // In a real app, you would update this in the backend/database
    for (int i = 0; i < notifications.length; i++) {
      // notifications[i] = notifications[i].copyWith(isRead: true);
    }
  }
}
