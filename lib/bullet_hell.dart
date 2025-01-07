import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:myapp/actors/enermy.dart';
import 'package:myapp/actors/player.dart';

class BulletHellGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  FutureOr<void> onLoad() async {
    await images.loadAll([
      'player.png',
    ]);
    initializeGame();
  }

  void initializeGame() {
    world.add(Player());
    world.add(Enemy(speed: 1));
  }
}
