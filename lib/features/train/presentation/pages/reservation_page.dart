import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shown after reserving a class: the spot is held, checkout comes next.
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
            // Big lime check.
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
              height: AppSpacing.xl,
            ),
            // Reservation summary card.
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
                  FormTag(
                    l10n.reservationTagPending,
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  Text(
                    l10n.trainClassName.toUpperCase(),
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.lg,
                  ),
                  _DetailRow(
                    label: l10n.reservationWhen,
                    value: 'Wed, 7 Oct · 7:00–7:45 AM',
                  ),
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  _DetailRow(
                    label: l10n.reservationWhere,
                    value: 'Brooklyn · Studio 01',
                  ),
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  _DetailRow(
                    label: l10n.reservationWith,
                    value: 'Coach Maya · 1 person',
                  ),
                  const Divider(
                    height: AppSpacing.xxl,
                  ),
                  _DetailRow(
                    label: l10n.reservationSingleClass,
                    value: r'$28.00',
                    valueBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: AppColors.grey,
                ),
                const SizedBox(
                  width: AppSpacing.sm,
                ),
                Expanded(
                  child: Text(
                    l10n.reservationNote,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            Text(
              l10n.reservationUpsellTitle,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            // Upsell product card.
            Container(
              padding: const EdgeInsets.all(
                AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppRadius.lg,
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 72,
                    child: FormImagePlaceholder(
                      height: 72,
                      borderRadius: AppRadius.md,
                    ),
                  ),
                  const SizedBox(
                    width: AppSpacing.md,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.onboardingProductBottle,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          l10n.reservationUpsellMeta,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: AppSpacing.xs,
                        ),
                        Row(
                          children: [
                            Text(
                              l10n.reservationUpsellCta,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            FormCtaButton(
              label: l10n.reservationGoToCart(
                1,
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
            _SecondaryButton(
              label: l10n.reservationKeepExploring,
              onPressed: () => Navigator.pop(
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow
    extends
        StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final bool valueBold;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.grey,
          ),
        ),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: valueBold
                ? FontWeight.w800
                : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// White outlined button used under the lime CTA.
class _SecondaryButton
    extends
        StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
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
        child: Row(
          children: [
            const Spacer(),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              AppAssets.iconArrowUpRight,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.charcoal,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
