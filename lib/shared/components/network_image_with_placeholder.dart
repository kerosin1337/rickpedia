import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWithPlaceholder extends StatefulWidget {
  final String imageUrl;

  const NetworkImageWithPlaceholder({super.key, required this.imageUrl});

  @override
  State<NetworkImageWithPlaceholder> createState() =>
      _NetworkImageWithPlaceholderState();
}

class _NetworkImageWithPlaceholderState
    extends State<NetworkImageWithPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return _Placeholder(value: downloadProgress.progress);
      },
      errorWidget: (context, url, error) {
        return _Placeholder(isError: true, onRefresh: () => setState(() {}));
      },
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}

class _Placeholder extends StatelessWidget {
  final double? value;
  final bool isError;
  final VoidCallback? onRefresh;

  const _Placeholder({this.value, this.isError = false, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: isError
          ? Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onRefresh?.call,
                  icon: const Icon(Icons.replay, size: 48),
                ),
                Text(
                  'Error loading the image, please try again',
                  // style: context.typography.body14Regular.copyWith(
                  //   color: context.colors.secondaryTextAndIcon,
                  // ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                padding: const EdgeInsets.symmetric(vertical: 48),
                value: value,
                strokeWidth: 5,
                constraints: const BoxConstraints(
                  maxHeight: 48,
                  maxWidth: 48,
                  minWidth: 48,
                  minHeight: 48,
                ),
              ),
            ),
    );
  }
}
