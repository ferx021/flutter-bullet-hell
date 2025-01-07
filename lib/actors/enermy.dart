import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:myapp/actors/bullet.dart';
import 'package:myapp/actors/player.dart';
import 'package:myapp/bullet_hell.dart';

class Enemy extends SpriteComponent
    with HasGameReference<BulletHellGame>, CollisionCallbacks {
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Player) {
      other.removeFromParent();
    } else if (other is Bullet) {
      removeFromParent();
    }
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
