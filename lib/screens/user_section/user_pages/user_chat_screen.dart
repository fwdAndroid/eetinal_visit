import 'package:flutter/material.dart';

class ChatItem {
  final String name;
  final String lastMessage;
  final String time;
  final String imageUrl;
  final int unreadCount;

  ChatItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.imageUrl,
    required this.unreadCount,
  });
}

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
    final List<ChatItem> chats = [
    ChatItem(
      name: 'John Doe',
      lastMessage: 'Hey! How are you?',
      time: '2:30 PM',
      imageUrl: 'https://picsum.photos/201',
      unreadCount: 2,
    ),
    ChatItem(
      name: 'Jane Smith',
      lastMessage: 'Let\'s meet tomorrow',
      time: '1:15 PM',
      imageUrl: 'https://picsum.photos/201',
      unreadCount: 0,
    ),
    ChatItem(
      name: 'Ali Khan',
      lastMessage: 'Check this out!',
      time: '12:45 PM',
      imageUrl: 'https://picsum.photos/201',
      unreadCount: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(chat.imageUrl),
                ),
                if (chat.unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        chat.unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              chat.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(chat.lastMessage),
            trailing: Text(
              chat.time,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            onTap: () {
              // Navigate to chat detail screen
            },
          );
        },
      ),
    );
  }
}
