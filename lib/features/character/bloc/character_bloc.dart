import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/bloc/common.dart';
import '../data/models/character_model.dart';
import '../data/repository/character_repository.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;

  CharacterBloc(this.characterRepository) : super(const CharacterState()) {
    on<CharactersGetEvent>(_onCharactersGet);
  }

  Future<void> _onCharactersGet(
    CharactersGetEvent event,
    Emitter<CharacterState> emit,
  ) async {
    try {
      final characters = await characterRepository.getCharacters();

      emit(state.copyWith(status: BlocStatus.success, items: characters));
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.failure));
    }
  }
}
