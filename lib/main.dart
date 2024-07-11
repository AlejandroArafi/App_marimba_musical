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
          title: const Text('Marimba Virtual'),
        ),
        body: const Marimba(),
        backgroundColor: Colors.pink[200],
      ),
    );
  }
}

class Marimba extends StatelessWidget {
  const Marimba({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    return Column(
      children: List.generate(8, (index) {
        return GestureDetector(
          onTap: () {
            player.play(AssetSource('sounds/marimba$index.mp3'));
          },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.orange[(index + 1) * 100],
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ), // changes position of shadow
              ],
            ),
            child: Center(
              child: Text(
                'Note ${index + 1}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }),
    );
  }
}
