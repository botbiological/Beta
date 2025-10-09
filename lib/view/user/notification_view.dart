import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/model/notificationmodel.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/viewmodel/notification_viewmodel.dart';
import 'package:provide/widgets/custom_circle_avatar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationViewModel _viewModel = NotificationViewModel();

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            _buildHeader(),

            // Notifications List
            Expanded(child: _buildNotificationsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(5),
        vertical: Responsive.h(2),
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: Responsive.w(3)),

          // Title
          Expanded(
            child: Text(
              'Notifications',
              style: GoogleFonts.onest(
                color: Colors.white,
                fontSize: Responsive.textScaleFactor * 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.30,
              ),
            ),
          ),

          // Profile and Notification Icons
          Row(
            children: [
              CustomTinyCircleAvatar(
                baseColor: AppColor.textColor.withValues(alpha: 0.1),
                iconPadding: const EdgeInsets.all(5),
                imageUrl: "assets/icons/notification.svg",
                isAsset: true,
                bgColor: const Color(0x1AFFFFFF),
              ),
              SizedBox(width: Responsive.w(2)),
              CustomTinyCircleAvatar(
                baseColor: AppColor.textColor.withValues(alpha: 0.1),
                bgColor: const Color(0x1AFFFFFF),
                imageUrl: "assets/icons/profile.png",
                isAsset: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    if (_viewModel.notifications.isEmpty) {
      return Center(
        child: Text(
          'No notifications',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(5)),
      itemCount: _viewModel.notifications.length,
      separatorBuilder: (context, index) => SizedBox(height: Responsive.h(1.5)),
      itemBuilder: (context, index) {
        final notification = _viewModel.notifications[index];
        return NotificationListItem(
          notification: notification,
          onTap: () => _handleNotificationTap(notification),
          onDismiss: () => _dismissNotification(notification),
        );
      },
    );
  }

  void _handleNotificationTap(NotificationItem notification) {
    // Mark as read and handle navigation based on notification type
    _viewModel.markAsRead(notification.id);

    switch (notification.type) {
      case NotificationType.newTrack:
        debugPrint('Navigate to track: ${notification.title}');
        break;
      case NotificationType.bookRequest:
        debugPrint('Navigate to booking: ${notification.title}');
        break;
      case NotificationType.reward:
        debugPrint('Navigate to rewards: ${notification.title}');
        break;
      case NotificationType.payment:
        debugPrint('Navigate to payments: ${notification.title}');
        break;
      case NotificationType.general:
        debugPrint('General notification: ${notification.title}');
        break;
    }
  }

  void _dismissNotification(NotificationItem notification) {
    setState(() {
      _viewModel.notifications.removeWhere((n) => n.id == notification.id);
    });
  }
}

class NotificationListItem extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const NotificationListItem({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: Responsive.w(5)),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 24),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(Responsive.w(4)),
          decoration: BoxDecoration(
            color: const Color(0x1AFFFFFF),
            borderRadius: BorderRadius.circular(16),
            border: notification.isRead
                ? null
                : Border.all(
                    color: AppColor.seconadryColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification Icon or Profile Image
              _buildNotificationIcon(),
              SizedBox(width: Responsive.w(3)),

              // Notification Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: GoogleFonts.onest(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          notification.time,
                          style: GoogleFonts.onest(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.h(0.5)),

                    // Message
                    Text(
                      notification.message,
                      style: GoogleFonts.onest(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Dismiss Button
              GestureDetector(
                onTap: onDismiss,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.close,
                    color: Colors.white.withValues(alpha: 0.5),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    if (notification.profileImage != null) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(notification.profileImage!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // Default icon based on notification type
    IconData iconData;
    Color iconColor = AppColor.seconadryColor;

    switch (notification.type) {
      case NotificationType.newTrack:
        iconData = Icons.music_note;
        break;
      case NotificationType.bookRequest:
        iconData = Icons.book;
        break;
      case NotificationType.reward:
        iconData = Icons.card_giftcard;
        break;
      case NotificationType.payment:
        iconData = Icons.payment;
        break;
      case NotificationType.general:
        iconData = Icons.notifications;
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }
}
