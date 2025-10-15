part of 'character_bloc.dart';

abstract class CharacterEvent {
  const CharacterEvent();
}

class CharactersGetEvent extends CharacterEvent {
  CharactersGetEvent();
}
