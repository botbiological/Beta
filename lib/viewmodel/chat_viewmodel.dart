// Chat view model with sample data
import 'package:provide/model/chatmodel.dart';

class ChatViewModel {
  final List<ChatItem> chats = [
    ChatItem(
      id: '1',
      name: 'Skylar Dias',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: '10:20 AM',
      profileImage: 'assets/images/user_profile.png',
      isOnline: true,
      unreadCount: 0,
      isRead: true,
    ),
    ChatItem(
      id: '2',
      name: 'Jaylon Dorwart',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: '10:20 AM',
      profileImage: 'assets/images/cooper.png',
      isOnline: false,
      unreadCount: 2,
      isRead: false,
    ),
    ChatItem(
      id: '3',
      name: 'Lydia Botosh',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: '10:20 AM',
      profileImage: 'assets/images/havana.png',
      isOnline: true,
      unreadCount: 0,
      isRead: true,
    ),
    ChatItem(
      id: '4',
      name: 'Feroz',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: '10:20 AM',
      profileImage: 'assets/images/leo.png',
      isOnline: false,
      unreadCount: 1,
      isRead: false,
    ),
    ChatItem(
      id: '5',
      name: 'Marcus Torff',
      lastMessage: 'Hey everyone! Sunset Beats starts at 6PM sharp!',
      time: '10:20 AM',
      profileImage: 'assets/images/nelda.png',
      isOnline: false,
      unreadCount: 3,
      isRead: false,
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
