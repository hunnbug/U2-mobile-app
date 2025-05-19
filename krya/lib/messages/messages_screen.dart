import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:krya/footer/footer.dart';

class MessagesScreen extends StatefulWidget {
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // Пример списка диалогов
  final List<Map<String, String>> dialogs = [
    {
      'userId': '1',
      'name': 'Анна',
      'lastMessage': 'Привет! Как дела?',
      'avatar': 'https://randomuser.me/api/portraits/women/1.jpg',
    },
    {
      'userId': '2',
      'name': 'Иван',
      'lastMessage': 'До встречи!',
      'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
    },
    {
      'userId': '3',
      'name': 'Мария',
      'lastMessage': 'Спасибо за помощь!',
      'avatar': 'https://randomuser.me/api/portraits/women/3.jpg',
    },
  ];

  int _selectedFooterIndex = 1;

  // void _onFooterTap(int index) {
  //   setState(() {
  //     _selectedFooterIndex = index;
  //   });
    
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _selectedFooterIndex,
        onTap: (index) {
          setState(() {
            _selectedFooterIndex = index;
          });
          onFooterTap(context, index);
        }
      ),
      appBar: AppBar(
        title: Text('Сообщения'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: dialogs.length,
        itemBuilder: (context, index) {
          final dialog = dialogs[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(dialog['avatar']!),
            ),
            title: Text(dialog['name']!, style: TextStyle(color: Colors.white)),
            subtitle: Text(dialog['lastMessage']!, style: TextStyle(color: Colors.white70)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    userId: dialog['userId']!,
                    userName: dialog['name']!,
                    userAvatar: dialog['avatar']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}