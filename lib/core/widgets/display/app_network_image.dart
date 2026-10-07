import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:flutter/material.dart';

/// Renders a network image that fills and adjusts nicely within its container,
/// with a solid fallback background, [BoxFit.cover], full expansion, and fallback error handling.
class AppNetworkImage
    extends
        StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height,
    this.borderRadius = AppRadius.lg,
    this.fit = BoxFit.cover,
    this.backgroundColor = const Color(
      0xFFE8E4DA,
    ),
    this.showHeart = false,
    this.isFavorite = false,
    this.onHeartTap,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;
  final Color backgroundColor;
  final bool showHeart;
  final bool isFavorite;
  final VoidCallback? onHeartTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    final url = imageUrl;
    if (url ==
            null ||
        url.trim().isEmpty) {
      return FormImagePlaceholder(
        height: height,
        borderRadius: borderRadius,
        showHeart: showHeart,
        isFavorite: isFavorite,
        onHeartTap: onHeartTap,
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              url,
              fit: fit,
              width: width,
              height: height,
              errorBuilder:
                  (
                    _,
                    __,
                    ___,
                  ) => FormImagePlaceholder(
                    height: height,
                    borderRadius: borderRadius,
                    showHeart: showHeart,
                    isFavorite: isFavorite,
                    onHeartTap: onHeartTap,
                  ),
              loadingBuilder:
                  (
                    context,
                    child,
                    loadingProgress,
                  ) {
                    if (loadingProgress ==
                        null)
                      return child;
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        value:
                            loadingProgress.expectedTotalBytes !=
                                null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ??
                                      1)
                            : null,
                      ),
                    );
                  },
            ),
            if (showHeart)
              Positioned(
                top: 8,
                right: 8,
                child: FormImagePlaceholder(
                  height: 0,
                  showHeart: true,
                  isFavorite: isFavorite,
                  onHeartTap: onHeartTap,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
