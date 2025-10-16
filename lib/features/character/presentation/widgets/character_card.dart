import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../../shared/components/network_image_with_placeholder.dart';
import '../../bloc/character_bloc.dart';
import '../../data/models/character_model.dart';
import 'character_info.dart';

class CharacterCard extends StatefulWidget {
  final CharacterModel character;

  const CharacterCard({super.key, required this.character});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  late final CharacterBloc characterBloc;

  CharacterModel get character => widget.character;

  @override
  void initState() {
    super.initState();
    characterBloc = context.read<CharacterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          NetworkImageWithPlaceholder(imageUrl: character.image),
          Positioned(
            right: 8,
            top: 8,
            child: IconButton(
              onPressed: () async {
                characterBloc.add(
                  character.isFavorite
                      ? FavoriteCharactersRemoveEvent(
                          key: character.id.toString(),
                        )
                      : FavoriteCharactersAddEvent(
                          key: character.id.toString(),
                          value: character.toJson(),
                        ),
                );
              },
              visualDensity: VisualDensity.comfortable,
              iconSize: 32,
              icon: Icon(
                character.isFavorite ? Icons.star : Icons.star_outline,
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
          ),
          Positioned(
            top: 16,
            left: 16,
            child: CharacterInfo(character: character),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              character.name,
              style: TextStyle(
                color: context.colors.primary,
                fontSize: 24,
                shadows: <Shadow>[
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 8,
                    color: context.colors.shadow,
                  ),
                  Shadow(
                    offset: const Offset(-1, -1),
                    blurRadius: 8,
                    color: context.colors.shadow,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
