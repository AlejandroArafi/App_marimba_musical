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

class Marimba extends StatefulWidget {
  const Marimba({super.key});

  @override
  State<Marimba> createState() => _MarimbaState();
}

class _MarimbaState extends State<Marimba> with SingleTickerProviderStateMixin {
  final AudioPlayer player = AudioPlayer();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    player.dispose();
    super.dispose();
  }

  void _playNote(int noteIndex) async {
    final noteNumber = noteIndex + 1;
    await player.play(AssetSource('sounds/marimba$noteNumber.mp3'),
        position: Duration.zero);
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () => _playNote(index),
          child: Row(
            children: [
              const Spacer(),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Container(
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
                  );
                },
              ),
              const Spacer()
            ],
          ),
        );
      }),
    );
  }
}
