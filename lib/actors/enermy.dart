import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:myapp/bullet_hell.dart';

class Enemy extends SpriteComponent with HasGameReference<BulletHellGame> {
  int horizontalDirection = 0;
  int shootSpeed = 1;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('player.png');
    position = Vector2(100, 100);
    size = Vector2.all(30);
    anchor = Anchor.center;
    debugMode = true;

    add(ColorEffect(Colors.red, EffectController(duration: 0)));
  }

  @override
  void update(double dt) {
    angle += horizontalDirection * dt * 3;
    super.update(dt);
  }
}
