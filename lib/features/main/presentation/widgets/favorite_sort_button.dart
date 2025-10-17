import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/bloc/common.dart';
import '/features/character/bloc/character_bloc.dart';

class FavoriteSortButton extends StatefulWidget {
  const FavoriteSortButton({super.key});

  @override
  State<FavoriteSortButton> createState() => _FavoriteSortButtonState();
}

class _FavoriteSortButtonState extends State<FavoriteSortButton> {
  late final CharacterBloc characterBloc;

  @override
  void initState() {
    super.initState();
    characterBloc = context.read<CharacterBloc>();
  }

  void handleChangeDirection() {
    characterBloc.add(FavoriteCharactersChangeSortEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: BlocBuilder<CharacterBloc, CharacterState>(
        buildWhen: (previous, current) =>
            previous.favoriteDirection != current.favoriteDirection,
        builder: (context, state) {
          return Transform.flip(
            flipY: state.favoriteDirection == SortingOrder.asc,
            child: IconButton(
              onPressed: handleChangeDirection,
              icon: const Icon(Icons.sort),
            ),
          );
        },
      ),
    );
  }
}
