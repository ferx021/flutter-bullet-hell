import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:myapp/bullet_hell.dart';

class Bullet extends PositionComponent with HasGameReference<BulletHellGame> {
  final double angleDirection;
  final int speed;

  Bullet({
    required this.angleDirection,
    required this.speed,
  });

  @override
  FutureOr<void> onLoad() {
    final initialX = 15 * cos(angleDirection);
    final initialY = 15 * sin(angleDirection);
    position = Vector2(initialX, initialY);
    anchor = Anchor.center;

    add(CircleHitbox(radius: 3));
  }

  @override
  void update(double dt) {
    super.update(dt);

    final newPosX = position.x + speed * cos(angleDirection);
    final newPosY = position.y + speed * sin(angleDirection);
    position = Vector2(newPosX, newPosY);

    if (position.x.abs() > (game.size.x / 2 + 50) ||
        position.y.abs() > (game.size.y / 2) + 50) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint();
    paint.color = Colors.white;
    canvas.drawCircle(Offset.zero, 3, paint);
  }
}
