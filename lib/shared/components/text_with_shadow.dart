import 'package:flutter/material.dart';

import '/core/extension/context_ext.dart';

class TextWithShadow extends StatelessWidget {
  final String data;
  final TextStyle? style;

  const TextWithShadow(this.data, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        shadows: [
          Shadow(
            offset: const Offset(1, 1),
            blurRadius: 8,
            color: context.colors.primary,
          ),
          Shadow(
            offset: const Offset(-1, -1),
            blurRadius: 8,
            color: context.colors.primary,
          ),
        ],
      ).merge(style),
    );
  }
}
