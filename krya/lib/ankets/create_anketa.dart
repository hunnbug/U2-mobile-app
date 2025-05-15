import 'package:flutter/material.dart';

class CreateAnketaScreen extends StatefulWidget {
  @override
  State<CreateAnketaScreen> createState() => _CreateAnketaScreenState();
}

class _CreateAnketaScreenState extends State<CreateAnketaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _patronymicController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedGender;
  List<String> _selectedTags = [];

  final List<String> _tags = [
    'Спорт',
    'Музыка',
    'Путешествия',
    'Книги',
    'Кино',
    'Технологии',
    'Искусство',
    'Наука',
    'Готовка',
    'Игры',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание анкеты'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Имя *',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Введите имя' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _surnameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Фамилия *',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Введите фамилию' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _patronymicController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Отчество (необязательно)',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                style: TextStyle(color: Colors.white),
                maxLength: 500,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Описание * (до 500 символов)',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  counterStyle: TextStyle(color: Colors.white54),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите описание';
                  }
                  if (value.length > 500) {
                    return 'Описание не должно превышать 500 символов';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Теги',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Wrap(
                spacing: 8.0,
                children: _tags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                    selectedColor: Colors.white,
                    checkmarkColor: Colors.black,
                    labelStyle: TextStyle(
                        color: isSelected ? Colors.black : Colors.white),
                    backgroundColor: Colors.grey[800],
                  );
                }).toList(),
              ),
              SizedBox(height: 24),
              Text(
                'Пол *',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Мужской', style: TextStyle(color: Colors.white)),
                      value: 'Мужской',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      activeColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Женский', style: TextStyle(color: Colors.white)),
                      value: 'Женский',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      activeColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedGender == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Пожалуйста, выберите пол')),
                      );
                      return;
                    }
                    // Здесь можно обработать данные анкеты
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Анкета успешно создана!')),
                    );
                  }
                },
                child: Text('Создать анкету'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}