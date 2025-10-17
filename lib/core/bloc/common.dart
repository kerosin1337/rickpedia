enum BlocStatus { initial, loading, success, failure }

abstract class BlocState<T> {
  final BlocStatus status;
  final List<T> items;
  final String? search;
  final int page;
  final bool hasReachedMax;

  const BlocState({
    this.status = BlocStatus.initial,
    this.items = const [],
    this.search,
    this.page = 1,
    this.hasReachedMax = false,
  });

  BlocState<T> copyWith({
    BlocStatus? status,
    List<T>? items,
    String? Function()? search,
    int? page,
    bool? hasReachedMax,
  });
}

enum SortingOrder {
  asc(1),
  desc(-1);

  const SortingOrder(this.direction);

  final int direction;

  SortingOrder get reversed {
    switch (this) {
      case SortingOrder.asc:
        return SortingOrder.desc;
      case SortingOrder.desc:
        return SortingOrder.asc;
    }
  }
}
