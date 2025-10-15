part of 'character_bloc.dart';

final class CharacterState extends BlocState<CharacterModel> {
  const CharacterState({super.status, super.items, super.search});

  @override
  CharacterState copyWith({
    BlocStatus? status,
    List<CharacterModel>? items,
    String? Function()? search,
  }) {
    return CharacterState(
      status: status ?? this.status,
      items: items ?? this.items,
      search: search != null ? search() : this.search,
    );
  }
}
