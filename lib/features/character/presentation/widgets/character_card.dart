import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/extension/context_ext.dart';
import '/features/character/bloc/character_bloc.dart';
import '/features/character/data/models/character_model.dart';
import '/shared/components/network_image_with_placeholder.dart';
import '/shared/components/text_with_shadow.dart';
import 'character_favorite_icon.dart';
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

  void handleFavorite() {
    characterBloc.add(
      character.isFavorite
          ? FavoriteCharactersRemoveEvent(key: character.id.toString())
          : FavoriteCharactersAddEvent(
              key: character.id.toString(),
              value: character.toJson(),
            ),
    );
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
            child: CharacterFavoriteIcon(
              isFavorite: character.isFavorite,
              onPressed: handleFavorite,
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
            child: TextWithShadow(
              character.name,
              style: TextStyle(color: context.colors.background, fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
