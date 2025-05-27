import 'package:flutter/material.dart';
import 'package:krya/ankets/look_for_anketas.dart';
import 'package:krya/ankets/my_anketa_screen.dart';
import 'package:krya/messages/messages_screen.dart';
import 'package:krya/matches/matches.dart';

void onFooterTap(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LookForAnketasScreen()),
      );
      break;
    case 1:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MessagesScreen()),
      );
      break;
    case 2:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyAnketaScreen(
          name: 'Имя',
          surname: 'Фамилия',
          patronymic: 'Отчество',
          description: 'Описание',
          photoUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
          tags: ['Тег1', 'Тег2'],
          gender: 'гендер',
          lookingFor: 'письбки',
        )),
      );
      break;
    case 3:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MatchesScreen()),
      );
      break;
  }
}

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Сообщения',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Моя анкета',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Мэтчи',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Настройки',
        ),
      ],
    );
  }
}