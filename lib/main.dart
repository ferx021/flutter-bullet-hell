import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:myapp/bullet_hell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GameWidget.controlled(
      gameFactory: BulletHellGame.new,
    );
  }
}
