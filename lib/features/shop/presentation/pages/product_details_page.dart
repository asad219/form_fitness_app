import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';

/// Product details: photo carousel, color picker, stock note, add to cart.
class ProductDetailsPage
    extends
        StatefulWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  State<
    ProductDetailsPage
  >
  createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState
    extends
        State<
          ProductDetailsPage
        > {
  final int _photo = 0;
  int _color = 0;
  bool _favorite = false;

  static const _photoCount = 3;
  static const _colors = [
    AppColors.charcoal,
    Color(
      0xFFD8D4C8,
    ),
    Color(
      0xFFE4D9CB,
    ),
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(
            AppSpacing.xl,
          ),
          children: [
            InsideAppBar(
              title: l10n.productDetailsTitle,
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            // Photo with heart + page badge.
            FormImagePlaceholder(
              height: 320,
              showHeart: true,
              isFavorite: _favorite,
              onHeartTap: () => setState(
                () => _favorite = !_favorite,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppSpacing.md,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppRadius.sm,
                      ),
                    ),
                    child: Text(
                      '${_photo + 1} / $_photoCount',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            // Photo dots.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _photoCount,
                (
                  index,
                ) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  width:
                      index ==
                          _photo
                      ? 8
                      : 6,
                  height:
                      index ==
                          _photo
                      ? 8
                      : 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        index ==
                            _photo
                        ? AppColors.charcoal
                        : AppColors.grey.withValues(
                            alpha: 0.4,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            Row(
              children: [
                FormTag(
                  l10n.productTagEssentials,
                ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  size: 16,
                  color: AppColors.charcoal,
                ),
                const SizedBox(
                  width: AppSpacing.xs,
                ),
                Text(
                  '4.8 (64)',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FormHeadline(
                    l10n.productBottleName,
                    fontSize: 36,
                  ),
                ),
                Text(
                  r'$32',
                  style: context.textTheme.displaySmall?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Text(
              l10n.productBottleDescription,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Text(
              l10n.productColorLabel,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            // Color swatches.
            Row(
              children: List.generate(
                _colors.length,
                (
                  index,
                ) {
                  final selected =
                      index ==
                      _color;
                  return GestureDetector(
                    onTap: () => setState(
                      () => _color = index,
                    ),
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(
                        end: AppSpacing.md,
                      ),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _colors[index],
                        border: Border.all(
                          width: selected
                              ? 2.5
                              : 1,
                          color: selected
                              ? AppColors.charcoal
                              : AppColors.grey.withValues(
                                  alpha: 0.3,
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            // Stock note.
            Container(
              padding: const EdgeInsets.all(
                AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppRadius.lg,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 20,
                        color: AppColors.charcoal,
                      ),
                      const SizedBox(
                        width: AppSpacing.sm,
                      ),
                      Expanded(
                        child: Text(
                          l10n.productInStock,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  Text(
                    l10n.productFulfillmentNote,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            FormCtaButton(
              label: l10n.productAddToCart(
                r'$32',
              ),
              showArrow: false,
              onPressed: () => Navigator.pushNamed(
                context,
                RoutesName.cart,
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Center(
              child: Text(
                l10n.productFeatures,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
