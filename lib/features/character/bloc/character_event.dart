part of 'character_bloc.dart';

abstract class CharacterEvent {
  const CharacterEvent();
}

class CharactersGetEvent extends CharacterEvent {
  final bool initial;

  CharactersGetEvent({this.initial = false});
}

class FavoriteCharactersAddEvent extends CharacterEvent {
  final String key;
  final String value;

  FavoriteCharactersAddEvent({required this.key, required this.value});
}

class FavoriteCharactersRemoveEvent extends CharacterEvent {
  final String key;

  FavoriteCharactersRemoveEvent({required this.key});
}

class FavoriteCharactersGetAllEvent extends CharacterEvent {
  FavoriteCharactersGetAllEvent();
}

class FavoriteCharactersChangeSortEvent extends CharacterEvent {
  FavoriteCharactersChangeSortEvent();
}
