import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:myapp/actors/bullet.dart';
import 'package:myapp/bullet_hell.dart';

class Player extends SpriteComponent
    with KeyboardHandler, HasGameReference<BulletHellGame> {
  int horizontalDirection = 0;
  double shootDelay = 1;
  int shootSpeed = 1;
  bool isShooting = false;
  late final SpawnComponent _bulletSpawner;

  void startShooting() {
    parent!.add(_bulletSpawner.factory(0));
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('player.png');
    position = Vector2(0, 0);
    size = Vector2.all(30);
    anchor = Anchor.center;

    _bulletSpawner = SpawnComponent(
      factory: (_) => Bullet(
        angleDirection: angle - pi / 2,
        speed: shootSpeed,
      ),
      period: shootDelay,
      autoStart: false,
      selfPositioning: true,
    );

    parent!.add(_bulletSpawner);
    add(RectangleHitbox());
  }

  @override
  void onRemove() {
    stopShooting();
    for (var c in _bulletSpawner.children) {
      c.removeFromParent();
    }
    super.onRemove();
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

    if (event.logicalKey == LogicalKeyboardKey.space) {
      if (event is KeyDownEvent) {
        startShooting();
      } else if (event is KeyUpEvent) {
        stopShooting();
      }
    }

    return true;
  }

  @override
  void update(double dt) {
    angle += horizontalDirection * dt * 3;
    super.update(dt);
  }
}
