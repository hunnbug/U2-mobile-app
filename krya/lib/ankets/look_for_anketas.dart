import 'package:flutter/material.dart';
import 'package:krya/footer/footer.dart';
import 'package:krya/messages/messages_screen.dart';

class LookForAnketasScreen extends StatefulWidget {
  @override
  State<LookForAnketasScreen> createState() => _LookForAnketasScreenState();
}

class _LookForAnketasScreenState extends State<LookForAnketasScreen> {
  // Пример данных анкет
  final List<Map<String, String>> _anketas = [
    {
      'name': 'Анна, 23',
      'photo':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
    },
    {
      'name': 'Иван, 27',
      'photo':
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
    },
    {
      'name': 'Мария, 21',
      'photo':
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
    },
  ];

  int _currentIndex = 0;
  int _selectedFooterIndex = 0;

  void _like() {
    setState(() {
      if (_currentIndex < _anketas.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _skip() {
    setState(() {
      if (_currentIndex < _anketas.length - 1) {
        _currentIndex++;
      }
    });
  }

  // void _onFooterTap(int index) {
  //   setState(() {
  //     _selectedFooterIndex = index;
  //   });

  //   if (index == 1) {
  //     Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => MessagesScreen()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final anketa = _anketas[_currentIndex];
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        anketa['photo']!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 300,
                          height: 300,
                          color: Colors.grey[800],
                          child: Icon(Icons.person, color: Colors.white, size: 100),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      anketa['name']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _skip,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.grey[700],
                      padding: EdgeInsets.all(20),
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 32),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: _like,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.all(20),
                    ),
                    child: Icon(Icons.favorite, color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.black,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white54,
      //   currentIndex: _selectedFooterIndex,
      //   onTap: _onFooterTap,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Главная',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.message),
      //       label: 'Сообщения',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Профиль',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Мэтчи',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Настройки',
      //     ),
          
      //   ],
      //   type: BottomNavigationBarType.fixed,
      // ),
    );
  }
}