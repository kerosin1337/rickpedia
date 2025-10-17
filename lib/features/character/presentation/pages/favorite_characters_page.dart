import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/character/bloc/character_bloc.dart';
import '/features/character/presentation/widgets/character_card.dart';
import '/shared/components/custom_grid_view.dart';

class FavoriteCharactersPage extends StatefulWidget {
  const FavoriteCharactersPage({super.key});

  @override
  State<FavoriteCharactersPage> createState() => _FavoriteCharactersPageState();
}

class _FavoriteCharactersPageState extends State<FavoriteCharactersPage> {
  late final CharacterBloc characterBloc;

  @override
  void initState() {
    super.initState();
    characterBloc = context.read<CharacterBloc>();
    characterBloc.add(CharactersGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return CustomGridView(
          items: state.favoriteItems,
          renderComponent: (character, index) {
            return CharacterCard(character: character);
          },
        );
      },
    );
  }
}
