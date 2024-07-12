import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Marimba musical'),
        ),
        body: const Marimba(),
        backgroundColor: Colors.pink[100],
      ),
    );
  }
}

class Marimba extends StatelessWidget {
  const Marimba({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    final List<Color> noteColors = [
      const Color(0xFFFF8A80),
      const Color(0xFFFFD180),
      const Color(0xFFFFF59D),
      const Color(0xFFA5D6A7),
      const Color(0xFF80CBC4),
      const Color(0xFF90CAF9),
      const Color(0xFFCE93D8),
      const Color(0xFFF48FB1),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(8, (index) {
        return GestureDetector(
          onTap: () {
            final noteNumber = index + 1;
            player.play(AssetSource('sounds/marimba$noteNumber.mp3'),
                position: Duration.zero);
          },
          child: Row(
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width * 0.6,
                height: 60.0,
                decoration: BoxDecoration(
                  color: noteColors[index],
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    final noteNumber = index + 1;
                    player.play(AssetSource('sounds/marimba$noteNumber.mp3'),
                        position: Duration.zero);
                  },
                  splashColor: Colors.white.withOpacity(0.5),
                  highlightColor: Colors.white.withOpacity(0.2),
                  child: Center(
                    child: Text(
                      'Nota ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        );
      }),
    );
  }
}
