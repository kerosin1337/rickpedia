import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/character_bloc.dart';
import 'character_card.dart';

class CharactersContent extends StatefulWidget {
  const CharactersContent({super.key});

  @override
  State<CharactersContent> createState() => _CharactersContentState();
}

class _CharactersContentState extends State<CharactersContent> {
  @override
  Widget build(BuildContext context) {
    context.read<CharacterBloc>().add(CharactersGetEvent());
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            final character = state.items[index];
            return CharacterCard(character: character);
          },
        );
      },
    );
  }
}
