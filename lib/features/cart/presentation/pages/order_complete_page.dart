import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/cart/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shown after checkout: order summary with booked classes and pickup info.
/// Receives the [OrderModel] via route arguments.
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
    final order = ModalRoute.of(
      context,
    )?.settings.arguments;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child:
            order
                is! OrderModel
            ? Center(
                child: Text(
                  l10n.errorUnknown,
                ),
              )
            : _OrderCompleteBody(
                order: order,
              ),
      ),
    );
  }
}

class _OrderCompleteBody
    extends
        StatelessWidget {
  const _OrderCompleteBody({
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      children: [
        InsideAppBar(
          title: l10n.orderCompleteTitle,
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
            '',
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
                    'ORDER #${order.orderNumber}',
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
                      order.paymentStatus.toUpperCase(),
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
                '\$${order.totalPaid.toStringAsFixed(2)}',
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: AppColors.lime,
                ),
              ),
              if (order.billingEmail !=
                  null) ...[
                const SizedBox(
                  height: AppSpacing.xl,
                ),
                Text(
                  order.billingEmail!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(
          height: AppSpacing.md,
        ),
        for (final booked in order.bookedClasses)
          _OrderItemCard(
            icon: Icons.calendar_today_outlined,
            title: '${booked.className} · ${booked.bookingStatus}',
            meta:
                '${booked.date} · ${booked.timeSlot}\n'
                '${booked.coachName} · ${booked.location}',
          ),
        for (final product in order.purchasedProducts)
          _OrderItemCard(
            icon: Icons.inventory_2_outlined,
            title: product.name,
            meta:
                '${product.fulfillmentMethod}'
                '${product.pickupLocation != null ? ' · ${product.pickupLocation}' : ''}',
          ),
        const SizedBox(
          height: AppSpacing.xl,
        ),
        FormCtaButton(
          label: l10n.orderViewBookingCta,
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.orders,
            (
              route,
            ) => route.isFirst,
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
  });

  final IconData icon;
  final String title;
  final String meta;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),
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
        ],
      ),
    );
  }
}
