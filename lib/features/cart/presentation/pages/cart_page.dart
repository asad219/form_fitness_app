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

/// Cart tab: reserved class + physical products, totals and payment.
class CartPage
    extends
        StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<
    CartPage
  >
  createState() => _CartPageState();
}

class _CartPageState
    extends
        State<
          CartPage
        > {
  int _quantity = 1;
  bool _shipToMe = false;

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
              title: l10n.cartTitle,
              onBack: () {},
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            FormHeadline(
              l10n.cartHeadline,
              fontSize: 34,
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Text(
              l10n.cartMeta(
                2,
              ),
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            // Class item.
            _CartCard(
              tag: l10n.cartTagService,
              title: l10n.trainClassName,
              lines: const [
                'Wed, 7 Oct · 7:00 AM',
                'Brooklyn · Studio 01',
              ],
              price: r'$28.00',
              note: l10n.cartEntryPassNote,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            // Product item.
            _CartCard(
              tag: l10n.cartTagProduct,
              title: l10n.onboardingProductBottle,
              lines: const [
                r'Charcoal · 750 ml · $32.00',
              ],
              price: null,
              quantity: _quantity,
              onQuantityChanged:
                  (
                    q,
                  ) => setState(
                    () => _quantity = q,
                  ),
              fulfillment: Column(
                children: [
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _FulfillmentOption(
                          label: l10n.cartClubPickup,
                          selected: !_shipToMe,
                          onTap: () => setState(
                            () => _shipToMe = false,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: AppSpacing.sm,
                      ),
                      Expanded(
                        child: _FulfillmentOption(
                          label: l10n.cartShipToMe,
                          selected: _shipToMe,
                          onTap: () => setState(
                            () => _shipToMe = true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.cartPickupNote,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            // Promo code.
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.cartPromoCode,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppAssets.iconPlus,
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            _TotalRow(
              label: l10n.cartSubtotal,
              value: r'$60.00',
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            _TotalRow(
              label: l10n.cartPickupFree,
              value: l10n.cartFree,
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            _TotalRow(
              label: l10n.cartEstimatedTax,
              value: r'$4.80',
            ),
            const Divider(
              height: AppSpacing.xxl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.cartTotal,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  r'$64.80',
                  style: context.textTheme.displaySmall?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            // Payment method card.
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
              child: Row(
                children: [
                  const Icon(
                    Icons.credit_card,
                    size: 22,
                    color: AppColors.charcoal,
                  ),
                  const SizedBox(
                    width: AppSpacing.md,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.cartPayWith,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          l10n.cartBillingSaved(
                            'Alex Morgan',
                          ),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      l10n.cartChange,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            FormCtaButton(
              label: l10n.cartPayCta(
                r'$64.80',
              ),
              showArrow: false,
              onPressed: () => Navigator.pushNamed(
                context,
                RoutesName.orderComplete,
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              l10n.cartTerms,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartCard
    extends
        StatelessWidget {
  const _CartCard({
    required this.tag,
    required this.title,
    required this.lines,
    required this.price,
    this.note,
    this.quantity,
    this.onQuantityChanged,
    this.fulfillment,
  });

  final String tag;
  final String title;
  final List<
    String
  >
  lines;
  final String? price;
  final String? note;
  final int? quantity;
  final ValueChanged<
    int
  >?
  onQuantityChanged;
  final Widget? fulfillment;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppRadius.lg,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 88,
                child: FormImagePlaceholder(
                  height: 88,
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
                    FormTag(
                      tag,
                    ),
                    const SizedBox(
                      height: AppSpacing.xs,
                    ),
                    Text(
                      title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    for (final line in lines)
                      Text(
                        line,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                          height: 1.4,
                        ),
                      ),
                    if (price !=
                        null) ...[
                      const SizedBox(
                        height: AppSpacing.xs,
                      ),
                      Text(
                        price!,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                    if (quantity !=
                        null) ...[
                      const SizedBox(
                        height: AppSpacing.sm,
                      ),
                      _QuantityStepper(
                        quantity: quantity!,
                        onChanged: onQuantityChanged!,
                      ),
                    ],
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  l10n.cartRemove,
                  style: context.textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ],
          ),
          if (fulfillment !=
              null) ...[
            const Divider(
              height: AppSpacing.xxl,
            ),
            fulfillment!,
          ],
          if (note !=
              null) ...[
            const Divider(
              height: AppSpacing.xxl,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                note!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _QuantityStepper
    extends
        StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onChanged,
  });

  final int quantity;
  final ValueChanged<
    int
  >
  onChanged;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey.withValues(
            alpha: 0.3,
          ),
        ),
        borderRadius: BorderRadius.circular(
          AppRadius.md,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stepButton(
            AppAssets.iconMinus,
            () {
              if (quantity >
                  1)
                onChanged(
                  quantity -
                      1,
                );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
            child: Text(
              '$quantity',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _stepButton(
            AppAssets.iconPlus,
            () => onChanged(
              quantity +
                  1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepButton(
    String asset,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.sm,
        ),
        child: SvgPicture.asset(
          asset,
          width: 16,
          height: 16,
        ),
      ),
    );
  }
}

class _FulfillmentOption
    extends
        StatelessWidget {
  const _FulfillmentOption({
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
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.lime.withValues(
                  alpha: 0.4,
                )
              : Colors.transparent,
          borderRadius: BorderRadius.circular(
            AppRadius.md,
          ),
          border: Border.all(
            color: AppColors.grey.withValues(
              alpha: 0.3,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _TotalRow
    extends
        StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

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
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
