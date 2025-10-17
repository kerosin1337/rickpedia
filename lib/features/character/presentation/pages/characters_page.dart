import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/bloc/common.dart';
import '/features/character/bloc/character_bloc.dart';
import '/features/character/presentation/widgets/character_card.dart';
import '/shared/components/custom_grid_view.dart';

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
  }

  void handleNextPage() {
    characterBloc.add(CharactersGetEvent());
  }

  Future<void> handleRefresh() async {
    characterBloc.add(CharactersGetEvent(initial: true));
    await characterBloc.stream.firstWhere(
      (state) => state.status == BlocStatus.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state.status == BlocStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomGridView(
            items: state.items,
            renderComponent: (character, index) {
              return CharacterCard(character: character);
            },
            onNextPage: handleNextPage,
          );
        },
      ),
    );
  }
}
