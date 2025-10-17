import 'package:flutter/material.dart';

import '/core/extension/context_ext.dart';

class CharacterFavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const CharacterFavoriteIcon({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  State<CharacterFavoriteIcon> createState() => _CharacterFavoriteIconState();
}

class _CharacterFavoriteIconState extends State<CharacterFavoriteIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scaleAnimation;

  bool get isFavorite => widget.isFavorite;

  VoidCallback get onPressed => widget.onPressed;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.35,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.35,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40,
      ),
    ]).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleFavorite() {
    onPressed();
    if (controller.isCompleted) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: IconButton(
        onPressed: handleFavorite,
        visualDensity: VisualDensity.comfortable,
        iconSize: 32,
        icon: Icon(
          isFavorite ? Icons.star : Icons.star_outline,
          shadows: [
            Shadow(
              offset: const Offset(1, 1),
              blurRadius: 4,
              color: context.colors.shadow.withAlpha((255 * 0.3).toInt()),
            ),
          ],
        ),
        color: context.colors.primary,
      ),
    );
  }
}
