import 'package:flutter/material.dart';
import 'package:krya/registration/registration_screen.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  int _selectedField = 0; // 0 - логин, 1 - телефон, 2 - email

  @override
  void dispose() {
    _loginController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите логин';
    }
    final regex = RegExp(r'^[a-zA-Z]+$');
    if (!regex.hasMatch(value)) {
      return 'Только английские буквы';
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Минимум 6 символов';
    }
    return null;
  }

  Widget _buildInputField() {
    switch (_selectedField) {
      case 0:
        return TextFormField(
          controller: _loginController,
          validator: _validateLogin,
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
        );
      case 1:
        return TextFormField(
          controller: _phoneController,
          validator: (value) {
            if (value == null || value.isEmpty || !value.startsWith('+7')) {
              return 'Введите номер телефона';
            }
            final digits = value.replaceAll(RegExp(r'\D'), '');
            if (digits.length != 11) {
              return 'Введите 10 цифр после +7';
            }
            return null;
          },
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\+7\d{0,10}')),
          ],
          decoration: InputDecoration(
            labelText: 'Телефон',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          onChanged: (value) {
            // Не даём удалить +7
            if (!value.startsWith('+7')) {
              _phoneController.text = '+7';
              _phoneController.selection = TextSelection.fromPosition(
                TextPosition(offset: 2),
              );
              return;
            }
            // Ограничиваем длину до +7 и 10 цифр
            if (value.length > 12) {
              _phoneController.text = value.substring(0, 12);
              _phoneController.selection = TextSelection.fromPosition(
                TextPosition(offset: 12),
              );
            }
          },
          // onTap: () {
          //   if (_phoneController.text.isEmpty) {
          //     _phoneController.text = '+7';
          //     _phoneController.selection = TextSelection.fromPosition(
          //       TextPosition(offset: 2),
          //     );
          //   }
          // },
        );
      case 2:
        return TextFormField(
          controller: _emailController,
          validator: _validateEmail,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
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
        );
      default:
        return SizedBox.shrink();
    }
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
              children: [
                Text(
                  'Авторизация',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: _buildInputField(),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedField = (_selectedField + 1) % 3;
                      if (_selectedField == 1 && _phoneController.text.isEmpty) {
                        _phoneController.text = '+7';
                        _phoneController.selection = TextSelection.fromPosition(
                          TextPosition(offset: 2),
                        );
                      }
                    });
                  },
                  child: Text(
                    _selectedField == 0
                        ? 'Войти по телефону'
                        : _selectedField == 1
                            ? 'Войти по email'
                            : 'Войти по логину',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    validator: _validatePassword,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    obscureText: true,
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
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Войти"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Успешная авторизация')),
                      );
                    }
                  },
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationScreen()),
                    );
                  },
                  child: Text(
                    "Нет аккаунта? Зарегистрироваться",
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