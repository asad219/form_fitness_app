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

/// Shown after payment: order summary with the booked class and pickup info.
class OrderCompletePage
    extends
        StatelessWidget {
  const OrderCompletePage({
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
              title: l10n.orderCompleteTitle,
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            // Stepper row.
            Row(
              children: [
                _Step(
                  label: l10n.orderStepCart,
                ),
                const Spacer(),
                _Step(
                  label: l10n.orderStepPayment,
                ),
                const Spacer(),
                _Step(
                  label: l10n.orderStepConfirmed,
                ),
              ],
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
              l10n.orderHeadline(
                'ALEX',
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              l10n.orderBody,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            // Dark order summary card.
            Container(
              padding: const EdgeInsets.all(
                AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: AppColors.charcoal,
                borderRadius: BorderRadius.circular(
                  AppRadius.lg,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.orderNumber,
                        style: context.textTheme.labelLarge?.copyWith(
                          fontSize: 11,
                          letterSpacing: 1,
                          color: Colors.white70,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppRadius.pill,
                          ),
                        ),
                        child: Text(
                          l10n.orderPaid,
                          style: context.textTheme.labelLarge?.copyWith(
                            fontSize: 10,
                            color: AppColors.charcoal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSpacing.xl,
                  ),
                  Text(
                    l10n.orderTotalPaid,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.xs,
                  ),
                  Text(
                    r'$64.80',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: AppColors.lime,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.xl,
                  ),
                  Text(
                    l10n.orderPaymentMeta,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            // Booked class card.
            _OrderItemCard(
              icon: Icons.calendar_today_outlined,
              title: l10n.orderClassConfirmed,
              meta: l10n.orderClassMeta,
              action: l10n.orderViewEntryPass,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            // Pickup card.
            _OrderItemCard(
              icon: Icons.inventory_2_outlined,
              title: l10n.orderPickupTitle,
              meta: l10n.orderPickupMeta,
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            FormCtaButton(
              label: l10n.orderViewBookingCta,
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.home,
                (
                  route,
                ) => false,
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  l10n.orderNeedHelp,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
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

class _Step
    extends
        StatelessWidget {
  const _Step({
    required this.label,
  });

  final String label;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.check,
          size: 14,
          color: AppColors.grey,
        ),
        const SizedBox(
          width: AppSpacing.xs,
        ),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}

class _OrderItemCard
    extends
        StatelessWidget {
  const _OrderItemCard({
    required this.icon,
    required this.title,
    required this.meta,
    this.action,
  });

  final IconData icon;
  final String title;
  final String meta;
  final String? action;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
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
              Icon(
                icon,
                size: 20,
                color: AppColors.charcoal,
              ),
              const SizedBox(
                width: AppSpacing.sm,
              ),
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          Text(
            meta,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
          if (action !=
              null) ...[
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Row(
              children: [
                Text(
                  action!,
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
        ],
      ),
    );
  }
}
