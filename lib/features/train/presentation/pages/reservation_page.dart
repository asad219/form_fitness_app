import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shown after a class is added to the cart: spot held, go to checkout.
class ReservationPage
    extends
        StatelessWidget {
  const ReservationPage({
    super.key,
  });

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
              title: l10n.reservationTitle,
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lime,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.iconCheckGlyph,
                  width: 36,
                  height: 36,
                  colorFilter: const ColorFilter.mode(
                    AppColors.charcoal,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            FormHeadline(
              l10n.reservationHeadline,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              l10n.reservationBody(
                l10n.trainClassName,
              ),
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            SizedBox(
              height: 56,
              child: FilledButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  RoutesName.cart,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.lime,
                  foregroundColor: AppColors.charcoal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppRadius.md,
                    ),
                  ),
                ),
                child: Text(
                  l10n.reservationGoToCart(
                    1,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            SizedBox(
              height: 56,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(
                  context,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.charcoal,
                  side: BorderSide(
                    color: AppColors.grey.withValues(
                      alpha: 0.3,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppRadius.md,
                    ),
                  ),
                ),
                child: Text(
                  l10n.reservationKeepExploring,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
