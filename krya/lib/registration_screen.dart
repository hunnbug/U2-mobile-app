import 'package:flutter/material.dart';
import 'registration_screen_2.dart';

class RegistrationScreen extends StatelessWidget {
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
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: Colors.white, ),
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Логин',
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
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Номер телефона',
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
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white,),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Email',
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
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, 
                foregroundColor: Colors.black, 
              ),
              child: Text("Далее"),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => PasswordScreen()));
              })
          ],
        ),
      ),
    );
  }
}
