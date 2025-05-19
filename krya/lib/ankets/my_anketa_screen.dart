import 'package:flutter/material.dart';
import 'package:krya/footer/footer.dart';

class MyAnketaScreen extends StatefulWidget {

  final String name;
  final String surname;
  final String? patronymic;
  final String description;
  final String? photoUrl;
  final List<String> tags;
  final String gender;
  final String lookingFor;

  const MyAnketaScreen({
    Key? key,
    required this.name,
    required this.surname,
    this.patronymic,
    required this.description,
    this.photoUrl,
    required this.tags,
    required this.gender,
    required this.lookingFor,
  }) : super(key: key);

  @override
  State<MyAnketaScreen> createState() => _MyAnketaScreenState();

}
class _MyAnketaScreenState extends State<MyAnketaScreen> {  

  int _selectedFooterIndex = 2;

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: Text('Моя анкета'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.photoUrl != null && widget.photoUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  widget.photoUrl!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(Icons.person, color: Colors.white54, size: 100),
              ),
            SizedBox(height: 24),
            Text(
              '${widget.surname} ${widget.name}${widget.patronymic != null && widget.patronymic!.isNotEmpty ? ' ${widget.patronymic}' : ''}',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              'Пол: ${widget.gender}',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Ищу: ${widget.lookingFor}',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Описание',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              widget.description,
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              'Теги',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: widget.tags
                  .map((tag) => Chip(
                        label: Text(tag, style: TextStyle(color: Colors.black)),
                        backgroundColor: Colors.white,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}