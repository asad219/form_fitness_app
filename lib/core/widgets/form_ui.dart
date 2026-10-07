import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shared building blocks for the inside (home / train / shop / cart) screens.

/// Circular back button + centered title + ellipsis menu, used on detail pages.
class InsideAppBar
    extends
        StatelessWidget {
  const InsideAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        _CircleIconButton(
          asset: AppAssets.iconArrowLeft,
          onPressed:
              onBack ??
              () => Navigator.pop(
                context,
              ),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _CircleIconButton(
          asset: AppAssets.iconEllipsis,
          onPressed: () {},
        ),
      ],
    );
  }
}

/// White circular button holding an SVG icon.
class CircleIconButton
    extends
        StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.asset,
    required this.onPressed,
    this.badge,
  });

  final String asset;
  final VoidCallback? onPressed;

  /// Small count bubble (e.g. cart items). Hidden when null or 0.
  final int? badge;

  @override
  Widget build(
    BuildContext context,
  ) {
    return _CircleIconButton(
      asset: asset,
      onPressed: onPressed,
      badge: badge,
    );
  }
}

class _CircleIconButton
    extends
        StatelessWidget {
  const _CircleIconButton({
    required this.asset,
    required this.onPressed,
    this.badge,
  });

  final String asset;
  final VoidCallback? onPressed;
  final int? badge;

  @override
  Widget build(
    BuildContext context,
  ) {
    final showBadge =
        badge !=
            null &&
        badge! >
            0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.white,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Center(
                child: SvgPicture.asset(
                  asset,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.charcoal,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showBadge)
          PositionedDirectional(
            top: -2,
            end: -2,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.charcoal,
              ),
              child: Center(
                child: Text(
                  '$badge',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lime,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Lime uppercase tag pill, e.g. "GROUP CLASS", "BESTSELLER".
class FormTag
    extends
        StatelessWidget {
  const FormTag(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.lime.withValues(
          alpha: 0.4,
        ),
        borderRadius: BorderRadius.circular(
          AppRadius.sm,
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: context.textTheme.labelLarge?.copyWith(
          fontSize: 10,
          letterSpacing: 0.8,
          color: AppColors.charcoal,
        ),
      ),
    );
  }
}

/// Selectable filter chip row item ("All", "Classes", ...).
class FilterChipPill
    extends
        StatelessWidget {
  const FilterChipPill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.charcoal
              : Colors.white,
          borderRadius: BorderRadius.circular(
            AppRadius.pill,
          ),
          border: Border.all(
            color: AppColors.grey.withValues(
              alpha: 0.3,
            ),
          ),
        ),
        child: Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: selected
                ? AppColors.lime
                : AppColors.charcoal,
          ),
        ),
      ),
    );
  }
}

/// Section title with an optional "Explore all" action on the end.
class SectionTitleRow
    extends
        StatelessWidget {
  const SectionTitleRow({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.charcoal,
            ),
          ),
        ),
        if (actionLabel !=
            null)
          GestureDetector(
            onTap: onAction,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel!,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: AppSpacing.xs,
                ),
                SvgPicture.asset(
                  AppAssets.iconArrowUpRight,
                  width: 14,
                  height: 14,
                  colorFilter: const ColorFilter.mode(
                    AppColors.charcoal,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Placeholder image container (rounded, cream) with an optional heart button.
class FormImagePlaceholder
    extends
        StatelessWidget {
  const FormImagePlaceholder({
    super.key,
    this.height,
    this.borderRadius = AppRadius.lg,
    this.showHeart = false,
    this.isFavorite = false,
    this.onHeartTap,
    this.child,
  });

  final double? height;
  final double borderRadius;
  final bool showHeart;
  final bool isFavorite;
  final VoidCallback? onHeartTap;
  final Widget? child;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(
          0xFFE8E4DA,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Stack(
        children: [
          if (child !=
              null)
            Positioned.fill(
              child: child!,
            ),
          if (showHeart)
            PositionedDirectional(
              top: AppSpacing.sm,
              end: AppSpacing.sm,
              child: GestureDetector(
                onTap: onHeartTap,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      isFavorite
                          ? AppAssets.iconHeart
                          : AppAssets.iconHeart,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        isFavorite
                            ? AppColors.charcoal
                            : AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
