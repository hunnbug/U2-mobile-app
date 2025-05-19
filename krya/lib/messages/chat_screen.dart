import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:krya/footer/footer.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userAvatar;

  ChatScreen({
    required this.userId,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage({String? text, String? imageUrl}) {
    if ((text == null || text.trim().isEmpty) && imageUrl == null) return;
    setState(() {
      _messages.add({
        'text': text,
        'imageUrl': imageUrl,
        'isMe': true,
      });
    });
    _controller.clear();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _sendMessage(imageUrl: pickedFile.path);
    }
  }

  int _selectedFooterIndex = 1;

  // void _onFooterTap(int index) {
  //   setState(() {
  //     _selectedFooterIndex = index;
  //   });
    
  // }

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
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.userAvatar)),
            SizedBox(width: 8),
            Text(widget.userName),
          ],
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[_messages.length - 1 - index];
                return Align(
                  alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg['isMe'] ? Colors.blueAccent : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: msg['imageUrl'] != null
                        ? Image.file(
                            File(msg['imageUrl']),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Text(
                            msg['text'] ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo, color: Colors.white),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Сообщение...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: () => _sendMessage(text: _controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}