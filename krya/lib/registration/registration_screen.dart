import 'package:flutter/material.dart';
import 'registration_screen_2.dart';
import 'package:flutter/services.dart';
import 'package:krya/login/login_screen.dart';

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
  void initState() {
    super.initState();
    _phoneController.text = '+7';
  }

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
    if (value == null || value.isEmpty || !value.startsWith('+7')) {
      return 'Введите номер телефона';
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) {
      return 'Введите 10 цифр после +7';
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
                      FilteringTextInputFormatter.allow(RegExp(r'^\+7\d{0,10}')),
                      LengthLimitingTextInputFormatter(
                        _phoneController.text.startsWith('+') ? 12 : 11
                      ),
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
                        if (!value.startsWith('+7')) {
                          _phoneController.text = '+7';
                          _phoneController.selection = TextSelection.fromPosition(
                            TextPosition(offset: 2),
                          );
                          return;
                      }
                      if (value.length > 12) {
                        _phoneController.text = value.substring(0, 12);
                        _phoneController.selection = TextSelection.fromPosition(
                          TextPosition(offset: 12),
                        );
                      }
                    }
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
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Уже есть аккаунт? Войти",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}