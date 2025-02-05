import 'dart:math' as math;

import 'package:dynamic_bounce/components/ball.dart';
import 'package:dynamic_bounce/components/bat.dart';
import 'package:dynamic_bounce/components/brick.dart';
import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// The playing overlay.
class Playing extends StatefulWidget {
  /// Creates a new playing overlay.
  const Playing({
    required this.game,
    super.key,
  });

  /// The game instance.
  final DynamicBounceGame game;

  @override
  State<Playing> createState() => _PlayingState();
}

class _PlayingState extends State<Playing> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  void dispose() {
    // Remove all objects when game is over.
    _removeAllObjects();
    super.dispose();
  }

  /// Starts the game.
  void _startGame() {
    // The initial velocity parameters of the ball.
    // The ball will move in a random direction.
    final velocityX = math.Random().nextDouble() - 0.5;
    const velocityY = 1.0;
    const velocityScale = 250.0;

    widget.game.world
      ..add(
        Ball(
          velocity: Vector2(
            velocityX,
            velocityY,
          ).normalized()
            ..scale(velocityScale),
          // Place the ball in the center of the screen.
          position: widget.game.size / 2,
        ),
      )
      ..add(
        Bat(
          position: Vector2(
            widget.game.width / 2,
            widget.game.height * 0.95,
          ),
          size: Vector2(120, 10),
        ),
      )
      ..add(
        Brick(
          position: Vector2(
            widget.game.width / 2,
            widget.game.height * 0.10,
          ),
        ),
      );

    // TODO(me): Delete in the final version.
    widget.game.debugMode = true;
  }

  /// Removes all objects from the game world.
  void _removeAllObjects() {
    widget.game.world
      ..removeAll(
        widget.game.world.children.query<Ball>(),
      )
      ..removeAll(
        widget.game.world.children.query<Bat>(),
      )
      ..removeAll(
        widget.game.world.children.query<Brick>(),
      );
  }
}
