// Chat data model
class ChatItem {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String profileImage;
  final bool isOnline;
  final int unreadCount;
  final bool isRead;

  const ChatItem({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profileImage,
    this.isOnline = false,
    this.unreadCount = 0,
    this.isRead = true,
  });
}
