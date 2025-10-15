import 'package:flutter/material.dart';

import '../../../../core/extension/context_ext.dart';
import '../../data/models/character_model.dart';

class CharacterCard extends StatefulWidget {
  final CharacterModel character;

  const CharacterCard({super.key, required this.character});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  final ExpansibleController expansibleController = ExpansibleController();

  CharacterModel get character => widget.character;

  bool get isExpanded => expansibleController.isExpanded;

  @override
  void dispose() {
    expansibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(character.name);
    print(character.type);
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Image.network(
            character.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            right: 16,
            top: 16,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.star_outline,
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
            child: Material(
              clipBehavior: Clip.antiAlias,
              color: context.colors.secondary,
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Expansible(
                  headerBuilder: (context, _) => Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Character info',
                        style: TextStyle(color: context.colors.primary),
                      ),
                      ExpandIcon(
                        padding: EdgeInsets.zero,
                        isExpanded: isExpanded,
                        color: context.colors.primary,
                        onPressed: (value) {
                          value
                              ? expansibleController.collapse()
                              : expansibleController.expand();
                        },
                      ),
                    ],
                  ),
                  bodyBuilder: (context, _) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Status: ',
                              style: TextStyle(color: context.colors.primary),
                            ),
                            Text(
                              character.status.status,
                              style: TextStyle(color: context.colors.surface),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Species: ',
                              style: TextStyle(color: context.colors.primary),
                            ),
                            Text(
                              character.species,
                              style: TextStyle(color: context.colors.surface),
                            ),
                          ],
                        ),
                        if (character.type.isNotEmpty)
                          Row(
                            children: [
                              Text(
                                'Type: ',
                                style: TextStyle(color: context.colors.primary),
                              ),
                              Text(
                                character.type,
                                style: TextStyle(color: context.colors.surface),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            Text(
                              'Gender: ',
                              style: TextStyle(color: context.colors.primary),
                            ),
                            Text(
                              character.gender.gender,
                              style: TextStyle(color: context.colors.surface),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Origin: ',
                              style: TextStyle(color: context.colors.primary),
                            ),
                            Text(
                              character.origin.name,
                              style: TextStyle(color: context.colors.surface),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Location: ',
                              style: TextStyle(color: context.colors.primary),
                            ),
                            Text(
                              character.location.name,
                              style: TextStyle(color: context.colors.surface),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Appearances: ',
                              style: TextStyle(color: context.colors.primary),
                            ),
                            Text(
                              character.episode.length.toString(),
                              style: TextStyle(color: context.colors.surface),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  controller: expansibleController,
                ),
              ),
            ),
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
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    color: context.colors.shadow.withAlpha((255 * 0.5).toInt()),
                  ),
                  Shadow(
                    offset: const Offset(-2, -2),
                    blurRadius: 4,
                    color: context.colors.shadow.withAlpha((255 * 0.3).toInt()),
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
