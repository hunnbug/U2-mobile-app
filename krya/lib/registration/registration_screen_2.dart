import 'package:flutter/material.dart';
import 'package:krya/ankets/create_anketa.dart';

class PasswordScreen extends StatefulWidget {
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Пароль должен быть не менее 6 символов';
    }
    return null;
  }

  String? _validateRepeatPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Повторите пароль';
    }
    if (value != _passwordController.text) {
      return 'Пароли не совпадают';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Регистрация',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: _validatePassword,
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
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _repeatPasswordController,
                    obscureText: true,
                    validator: _validateRepeatPassword,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
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
                    if (_formKey.currentState!.validate()) {
                      // Пароли совпадают и валидны
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Пароль подтвержден')),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAnketaScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('Подтвердить'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}