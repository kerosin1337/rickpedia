part of 'character_bloc.dart';

final class CharacterState extends BlocState<CharacterModel> {
  final List<CharacterModel> favoriteItems;
  final SortingOrder favoriteDirection;

  const CharacterState({
    super.status,
    super.items,
    super.search,
    super.page,
    super.hasReachedMax,
    this.favoriteItems = const [],
    this.favoriteDirection = SortingOrder.asc,
  });

  @override
  CharacterState copyWith({
    BlocStatus? status,
    List<CharacterModel>? items,
    String? Function()? search,
    int? page,
    bool? hasReachedMax,
    List<CharacterModel>? favoriteItems,
    SortingOrder? favoriteDirection,
  }) {
    return CharacterState(
      status: status ?? this.status,
      items: items ?? this.items,
      search: search != null ? search() : this.search,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      favoriteItems: favoriteItems ?? this.favoriteItems,
      favoriteDirection: favoriteDirection ?? this.favoriteDirection,
    );
  }
}
