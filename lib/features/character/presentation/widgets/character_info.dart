import 'package:flutter/material.dart';

import '/core/extension/context_ext.dart';
import '/features/character/data/models/character_model.dart';

class CharacterInfo extends StatefulWidget {
  final CharacterModel character;

  const CharacterInfo({super.key, required this.character});

  @override
  State<CharacterInfo> createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  final ExpansibleController expansibleController = ExpansibleController();

  CharacterModel get character => widget.character;

  bool get isExpanded => expansibleController.isExpanded;

  List<(String, String)> get infos => [
    ('Status', character.status.status),
    ('Species', character.species),
    ...(character.type.isNotEmpty ? [('Type', character.type)] : []),
    ('Gender', character.gender.gender),
    ('Origin', character.origin.name),
    ('Location', character.location.name),
    ('Appearances', character.episode.length.toString()),
  ];

  @override
  void dispose() {
    expansibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: context.colors.surface,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Expansible(
          expansibleBuilder: (context, header, body, _) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [header, body],
          ),
          headerBuilder: (context, _) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => handleExpand(isExpanded),
            child: Row(
              spacing: 16,
              children: [
                Text(
                  'Character info',
                  style: TextStyle(fontSize: 18, color: context.colors.primary),
                ),
                ExpandIcon(
                  padding: EdgeInsets.zero,
                  isExpanded: isExpanded,
                  color: context.colors.primary,
                  size: 28,
                  onPressed: handleExpand,
                ),
              ],
            ),
          ),
          bodyBuilder: (context, _) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: infos
                  .map(
                    (info) => RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${info.$1}: ',
                            style: TextStyle(color: context.colors.primary),
                          ),
                          TextSpan(
                            text: info.$2,
                            style: TextStyle(
                              color: context.colors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          controller: expansibleController,
        ),
      ),
    );
  }

  void handleExpand(bool value) {
    value ? expansibleController.collapse() : expansibleController.expand();
  }
}
