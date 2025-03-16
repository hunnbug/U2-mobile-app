import 'package:flutter/material.dart';

class PasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: true, // Скрывает введенный текст
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: true, // Скрывает введенный текст
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Повторите пароль',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Действие при нажатии на кнопку
                print('Пароль подтвержден');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Цвет кнопки
                foregroundColor: Colors.black, // Цвет текста
              ),
              child: Text('Подтвердить'),
            ),
          ],
        ),
      ),
    );
  }
}