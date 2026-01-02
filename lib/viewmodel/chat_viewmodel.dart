// Chat view model - for Firebase integration, use ChatService directly
import 'package:provide/model/chatmodel.dart';

class ChatViewModel {
  final List<ChatItem> chats = [
    ChatItem(
      id: '1',
      userId: 'demo_user',
      name: 'Skylar Dias',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: DateTime.now().subtract(Duration(hours: 2)),
      profileImage: 'assets/images/user_profile.png',
      isOnline: true,
      unreadCount: 0,
      isRead: true,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      updatedAt: DateTime.now().subtract(Duration(hours: 2)),
    ),
    ChatItem(
      id: '2',
      userId: 'demo_user',
      name: 'Jaylon Dorwart',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: DateTime.now().subtract(Duration(hours: 3)),
      profileImage: 'assets/images/cooper.png',
      isOnline: false,
      unreadCount: 2,
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(days: 2)),
      updatedAt: DateTime.now().subtract(Duration(hours: 3)),
    ),
    ChatItem(
      id: '3',
      userId: 'demo_user',
      name: 'Lydia Botosh',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: DateTime.now().subtract(Duration(hours: 5)),
      profileImage: 'assets/images/havana.png',
      isOnline: true,
      unreadCount: 0,
      isRead: true,
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      updatedAt: DateTime.now().subtract(Duration(hours: 5)),
    ),
    ChatItem(
      id: '4',
      userId: 'demo_user',
      name: 'Feroz',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: DateTime.now().subtract(Duration(hours: 8)),
      profileImage: 'assets/images/leo.png',
      isOnline: false,
      unreadCount: 1,
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(days: 4)),
      updatedAt: DateTime.now().subtract(Duration(hours: 8)),
    ),
    ChatItem(
      id: '5',
      userId: 'demo_user',
      name: 'Marcus Torff',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: DateTime.now().subtract(Duration(days: 1)),
      profileImage: 'assets/images/nelda.png',
      isOnline: false,
      unreadCount: 3,
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(days: 5)),
      updatedAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  List<ChatItem> searchChats(String query) {
    if (query.isEmpty) return chats;
    return chats
        .where(
          (chat) =>
              chat.name.toLowerCase().contains(query.toLowerCase()) ||
              chat.lastMessage.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
