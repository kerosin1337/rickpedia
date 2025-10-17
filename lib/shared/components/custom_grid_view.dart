import 'package:flutter/material.dart';

class CustomGridView<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item, int index) renderComponent;

  final VoidCallback? onNextPage;

  const CustomGridView({
    super.key,
    required this.items,
    required this.renderComponent,
    this.onNextPage,
  });

  @override
  State<CustomGridView> createState() => _CustomGridViewState<T>();
}

class _CustomGridViewState<T> extends State<CustomGridView<T>> {
  final ScrollController scrollController = ScrollController();

  List<T> get items => widget.items;

  Widget Function(T item, int index) get renderComponent =>
      widget.renderComponent;

  VoidCallback? get onNextPage => widget.onNextPage;

  @override
  void initState() {
    super.initState();
    if (widget.onNextPage != null) {
      scrollController.addListener(scrollListener);
    }
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(scrollListener)
      ..dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.onNextPage!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return renderComponent(item, index);
      },
    );
  }
}
