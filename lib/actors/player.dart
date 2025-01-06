import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:myapp/bullet_hell.dart';

class Player extends SpriteComponent
    with KeyboardHandler, HasGameReference<BulletHellGame> {
  int horizontalDirection = 0;
  int shootSpeed = 1;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('player.png');
    position = Vector2(0, 0);
    size = Vector2.all(30);
    anchor = Anchor.center;
    debugMode = true;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;
    return true;
  }

  @override
  void update(double dt) {
    angle += horizontalDirection * dt * 3;
    super.update(dt);
  }
}
