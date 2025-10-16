part of 'character_bloc.dart';

final class CharacterState extends BlocState<CharacterModel> {
  final List<CharacterModel> favoriteItems;

  const CharacterState({
    super.status,
    super.items,
    super.search,
    this.favoriteItems = const [],
  });

  @override
  CharacterState copyWith({
    BlocStatus? status,
    List<CharacterModel>? items,
    String? Function()? search,
    List<CharacterModel>? favoriteItems,
  }) {
    return CharacterState(
      status: status ?? this.status,
      items: items ?? this.items,
      search: search != null ? search() : this.search,
      favoriteItems: favoriteItems ?? this.favoriteItems,
    );
  }
}
