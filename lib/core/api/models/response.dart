class DioResponse<T> {
  final List<T> items;
  final bool hasReachedMax;

  const DioResponse({required this.items, required this.hasReachedMax});
}
