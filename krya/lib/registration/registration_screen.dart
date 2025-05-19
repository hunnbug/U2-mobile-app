import 'package:flutter/material.dart';
import 'registration_screen_2.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите логин';
    }
    final regex = RegExp(r'^[a-zA-Z]+$');
    if (!regex.hasMatch(value)) {
      return 'Только английские буквы, без символов и цифр';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите номер телефона';
    }
    final regex = RegExp(r'^\+?\d{11,12}$');
    if (!regex.hasMatch(value)) {
      return 'Некорректный номер телефона';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите email';
    }
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!regex.hasMatch(value)) {
      return 'Некорректный email';
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
                    controller: _loginController,
                    validator: _validateLogin,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: Colors.white),
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
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _phoneController,
                    validator: _validatePhone,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*')),
                      LengthLimitingTextInputFormatter(
                        _phoneController.text.startsWith('+') ? 12 : 11
                      ),
                      // Динамическое ограничение длины реализовано ниже через onChanged
                    ],
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
                    onChanged: (value) {
                      // Динамически ограничиваем длину в зависимости от наличия "+"
                      final maxLen = value.startsWith('+') ? 12 : 11;
                      if (value.length > maxLen) {
                        _phoneController.text = value.substring(0, maxLen);
                        _phoneController.selection = TextSelection.fromPosition(
                          TextPosition(offset: maxLen),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    validator: _validateEmail,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Далее"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PasswordScreen()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}