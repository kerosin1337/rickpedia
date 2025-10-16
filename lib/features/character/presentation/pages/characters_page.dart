import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/common.dart';
import '../../bloc/character_bloc.dart';
import '../widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late final CharacterBloc characterBloc;

  @override
  void initState() {
    super.initState();
    characterBloc = context.read<CharacterBloc>();
    characterBloc.add(CharactersGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        characterBloc.add(CharactersGetEvent());
      },
      child: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state.status == BlocStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
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
      ),
    );
  }
}
