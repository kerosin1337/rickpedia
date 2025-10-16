import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/bloc/common.dart';
import '../data/models/character_model.dart';
import '../data/repository/character_repository.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;

  CharacterBloc(this.characterRepository) : super(const CharacterState()) {
    on<CharactersGetEvent>(_onCharactersGet);
    on<FavoriteCharactersAddEvent>(_onFavoriteCharactersAdd);
    on<FavoriteCharactersRemoveEvent>(_onFavoriteCharactersRemove);
    on<FavoriteCharactersGetAllEvent>(_onFavoriteCharactersGetAll);
  }

  Future<void> _onCharactersGet(
    CharactersGetEvent event,
    Emitter<CharacterState> emit,
  ) async {
    try {
      final characters = await characterRepository.getCharacters();
      add(FavoriteCharactersGetAllEvent());

      emit(state.copyWith(status: BlocStatus.success, items: characters));
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.failure));
    }
  }

  Future<void> _onFavoriteCharactersAdd(
    FavoriteCharactersAddEvent event,
    Emitter<CharacterState> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(event.key, event.value);

    add(FavoriteCharactersGetAllEvent());
  }

  Future<void> _onFavoriteCharactersRemove(
    FavoriteCharactersRemoveEvent event,
    Emitter<CharacterState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(event.key);
    add(FavoriteCharactersGetAllEvent());
  }

  Future<void> _onFavoriteCharactersGetAll(
    FavoriteCharactersGetAllEvent event,
    Emitter<CharacterState> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final favorites = keys
        .map(
          (key) => CharacterModel.fromJson(jsonDecode(prefs.getString(key)!)),
        )
        .toList();
    emit(
      state.copyWith(
        favoriteItems: favorites,
        items: state.items
            .map(
              (item) =>
                  item..isFavorite = favorites.any((fav) => fav.id == item.id),
            )
            .toList(),
      ),
    );
  }
}
