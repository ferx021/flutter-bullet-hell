import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:myapp/bullet_hell.dart';

class Enemy extends SpriteComponent with HasGameReference<BulletHellGame> {
  final int speed;

  Enemy({required this.speed});

  @override
  FutureOr<void> onLoad() async {
    final posX = 146.0;
    final posY = 98.0;

    sprite = await Sprite.load('player.png');
    position = Vector2(posX, posY);
    size = Vector2.all(30);
    anchor = Anchor.center;
    angle = atan(posY / posX) - pi / 2;

    add(ColorEffect(Colors.red, EffectController(duration: 0)));
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position = Vector2(
      position.x + speed * cos(angle - pi / 2),
      position.y + speed * sin(angle - pi / 2),
    );
    super.update(dt);
  }
}
