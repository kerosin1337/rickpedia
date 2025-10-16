part of 'character_bloc.dart';

final class CharacterState extends BlocState<CharacterModel> {
  final List<CharacterModel> favoriteItems;
  final int favoriteDirection;

  const CharacterState({
    super.status,
    super.items,
    super.search,
    this.favoriteItems = const [],
    this.favoriteDirection = 1,
  });

  @override
  CharacterState copyWith({
    BlocStatus? status,
    List<CharacterModel>? items,
    String? Function()? search,
    List<CharacterModel>? favoriteItems,
    int? favoriteDirection,
  }) {
    return CharacterState(
      status: status ?? this.status,
      items: items ?? this.items,
      search: search != null ? search() : this.search,
      favoriteItems: favoriteItems ?? this.favoriteItems,
      favoriteDirection: favoriteDirection ?? this.favoriteDirection,
    );
  }
}
