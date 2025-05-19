import 'package:flutter/material.dart';
import 'package:krya/footer/footer.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {

  final List<Map<String, String>> matches = [
    {
      'name': 'Анна',
      'avatar': 'https://randomuser.me/api/portraits/women/1.jpg',
    },
    {
      'name': 'Иван',
      'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
    },
    {
      'name': 'Мария',
      'avatar': 'https://randomuser.me/api/portraits/women/3.jpg',
      'about': 'Обожаю музыку и кино.',
    },
  ];

  int _selectedFooterIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои мэтчи'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _selectedFooterIndex,
        onTap: (index) {
          setState(() {
            _selectedFooterIndex = index;
          });
          onFooterTap(context, index);
        },
      ),
      body: matches.isEmpty
          ? Center(
              child: Text(
                'У вас пока нет мэтчей',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(match['avatar']!),
                      radius: 28,
                    ),
                    title: Text(
                      match['name']!,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                    },
                  ),
                );
              },
            ),
    );
  }
}