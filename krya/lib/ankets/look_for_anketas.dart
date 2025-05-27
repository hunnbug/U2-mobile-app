import 'package:flutter/material.dart';
import 'package:krya/footer/footer.dart';

class LookForAnketasScreen extends StatefulWidget {
  @override
  State<LookForAnketasScreen> createState() => _LookForAnketasScreenState();
}

class _LookForAnketasScreenState extends State<LookForAnketasScreen> {
  final List<Map<String, dynamic>> _anketas = [
    {
      'name': 'Анна, 23',
      'photos': [
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
      ],
      'description': 'Люблю путешествовать, читать книги и заниматься спортом.',
      'tags': ['Путешествия', 'Книги', 'Спорт'],
    },
    {
      'name': 'Иван, 27',
      'photos': [
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
      ],
      'description': 'Программист, обожаю музыку и настольные игры.',
      'tags': ['Музыка', 'Настолки', 'IT'],
    },
    {
      'name': 'Мария, 21',
      'photos': [
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=facearea&w=600&h=600&facepad=2.5',
      ],
      'description': 'Фотограф, люблю кофе и уютные вечера.',
      'tags': ['Фотография', 'Кофе', 'Уют'],
    },
  ];

  int _currentIndex = 0;
  int _selectedFooterIndex = 0;
  int _currentPhotoIndex = 0;

  void _like() {
    setState(() {
      if (_currentIndex < _anketas.length - 1) {
        _currentIndex++;
        _currentPhotoIndex = 0;
      }
    });
  }

  void _skip() {
    setState(() {
      if (_currentIndex < _anketas.length - 1) {
        _currentIndex++;
        _currentPhotoIndex = 0;
      }
    });
  }

  void _nextPhoto() {
    setState(() {
      final photos = _anketas[_currentIndex]['photos'] as List;
      if (_currentPhotoIndex < photos.length - 1) {
        _currentPhotoIndex++;
      }
    });
  }

  void _prevPhoto() {
    setState(() {
      if (_currentPhotoIndex > 0) {
        _currentPhotoIndex--;
      }
    });
  }

  // Свайп по фото (влево/вправо — листать фото)
  void _handlePhotoSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;
    if (details.primaryVelocity! < 0) {
      _nextPhoto();
    } else if (details.primaryVelocity! > 0) {
      _prevPhoto();
    }
  }

  // Свайп по анкете (влево — лайк, вправо — скип)
  void _handleCardSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;
    if (details.primaryVelocity! < 0) {
      _like();
    } else if (details.primaryVelocity! > 0) {
      _skip();
    }
  }

  @override
  Widget build(BuildContext context) {
    final anketa = _anketas[_currentIndex];
    final photos = anketa['photos'] as List<String>;
    final screenWidth = MediaQuery.of(context).size.width;
    final photoSize = screenWidth - 48;

    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _selectedFooterIndex,
        onTap: (index) {
          setState(() {
            _selectedFooterIndex = index;
          });
          onFooterTap(context, index);
        },
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: _handleCardSwipe,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onHorizontalDragEnd: _handlePhotoSwipe,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 200),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    key: ValueKey(photos[_currentPhotoIndex]),
                                    child: Image.network(
                                      photos[_currentPhotoIndex],
                                      width: photoSize,
                                      height: photoSize,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: photoSize,
                                        height: photoSize,
                                        color: Colors.grey[800],
                                        child: Icon(Icons.person, color: Colors.white, size: 100),
                                      ),
                                    ),
                                  ),
                                  transitionBuilder: (child, animation) =>
                                      FadeTransition(opacity: animation, child: child),
                                ),
                                if (photos.length > 1) ...[
                                  // Индикатор фотографий
                                  Positioned(
                                    top: 16,
                                    child: Row(
                                      children: List.generate(photos.length, (index) {
                                        return Container(
                                          width: 8,
                                          height: 8,
                                          margin: EdgeInsets.symmetric(horizontal: 4),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentPhotoIndex == index
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.5),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  // Кнопка предыдущей фотографии
                                  if (_currentPhotoIndex > 0)
                                    Positioned(
                                      left: 8,
                                      child: IconButton(
                                        icon: Icon(Icons.chevron_left, color: Colors.white, size: 36),
                                        onPressed: _prevPhoto,
                                      ),
                                    ),
                                  // Кнопка следующей фотографии
                                  if (_currentPhotoIndex < photos.length - 1)
                                    Positioned(
                                      right: 8,
                                      child: IconButton(
                                        icon: Icon(Icons.chevron_right, color: Colors.white, size: 36),
                                        onPressed: _nextPhoto,
                                      ),
                                    ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            anketa['name'] ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          Text(
                            anketa['description'] ?? '',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          if (anketa['tags'] != null && (anketa['tags'] as List).isNotEmpty) ...[
                            SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              children: (anketa['tags'] as List)
                                  .map<Widget>((tag) => Chip(
                                        label: Text(tag, style: TextStyle(color: Colors.black)),
                                        backgroundColor: Colors.white,
                                      ))
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _skip,
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.grey[700],
                        padding: EdgeInsets.all(20),
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 32),
                    ),
                    SizedBox(width: 40),
                    ElevatedButton(
                      onPressed: _like,
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.all(20),
                      ),
                      child: Icon(Icons.favorite, color: Colors.white, size: 32),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}