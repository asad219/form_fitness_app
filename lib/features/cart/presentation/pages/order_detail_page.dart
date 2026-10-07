import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/cart/data/models/order_model.dart';
import 'package:app_boilerplate/features/cart/presentation/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Order detail: classes with QR entry passes, products, totals, cancel.
/// Receives the order id via route arguments.
class OrderDetailPage
    extends
        StatelessWidget {
  const OrderDetailPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final orderId =
        ModalRoute.of(
              context,
            )?.settings.arguments
            as String?;
    return BlocProvider(
      create:
          (
            _,
          ) =>
              getIt<
                  OrdersBloc
                >()
                ..add(
                  OrderDetailRequested(
                    orderId ??
                        '',
                  ),
                ),
      child: const _OrderDetailView(),
    );
  }
}

class _OrderDetailView
    extends
        StatelessWidget {
  const _OrderDetailView();

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return BlocListener<
      OrdersBloc,
      OrdersState
    >(
      listenWhen:
          (
            prev,
            curr,
          ) =>
              (curr.errorMessage !=
                      null &&
                  prev.errorMessage !=
                      curr.errorMessage) ||
              (curr.actionMessage !=
                      null &&
                  prev.actionMessage !=
                      curr.actionMessage),
      listener:
          (
            context,
            state,
          ) {
            if (state.errorMessage !=
                null) {
              AppSnackBar.show(
                context,
                state.errorMessage!,
                type: AppSnackBarType.error,
              );
            } else if (state.actionMessage !=
                null) {
              AppSnackBar.show(
                context,
                state.actionMessage!,
              );
            }
          },
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          child:
              BlocBuilder<
                OrdersBloc,
                OrdersState
              >(
                builder:
                    (
                      context,
                      state,
                    ) {
                      final order = state.selectedOrder;

                      if (state.isLoading ||
                          order ==
                              null) {
                        return const Center(
                          child: AppLoader(),
                        );
                      }

                      if (state.status ==
                          OrdersStatus.failure) {
                        return AppErrorState(
                          message:
                              state.errorMessage ??
                              l10n.errorUnknown,
                          onRetry: () => context
                              .read<
                                OrdersBloc
                              >()
                              .add(
                                OrderDetailRequested(
                                  order.id,
                                ),
                              ),
                        );
                      }

                      return ListView(
                        padding: const EdgeInsets.all(
                          AppSpacing.xl,
                        ),
                        children: [
                          InsideAppBar(
                            title: l10n.orderDetailTitle,
                          ),
                          const SizedBox(
                            height: AppSpacing.xl,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FormHeadline(
                                  '#${order.orderNumber}',
                                  fontSize: 30,
                                ),
                              ),
                              _StatusChip(
                                status: order.paymentStatus,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSpacing.xs,
                          ),
                          Text(
                            _formatDate(
                              order.createdAt,
                            ),
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          if (order.paymentMethod !=
                              null) ...[
                            const SizedBox(
                              height: AppSpacing.xs,
                            ),
                            Text(
                              order.paymentMethod!,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                          const SizedBox(
                            height: AppSpacing.xxl,
                          ),
                          if (order.bookedClasses.isNotEmpty) ...[
                            FormTagline(
                              l10n.orderClassesSection,
                            ),
                            const SizedBox(
                              height: AppSpacing.md,
                            ),
                            for (final booking in order.bookedClasses)
                              _BookingCard(
                                order: order,
                                booking: booking,
                                isCancelling:
                                    state.cancellingBookingId ==
                                    booking.id,
                              ),
                            const SizedBox(
                              height: AppSpacing.lg,
                            ),
                          ],
                          if (order.purchasedProducts.isNotEmpty) ...[
                            FormTagline(
                              l10n.orderProductsSection,
                            ),
                            const SizedBox(
                              height: AppSpacing.md,
                            ),
                            for (final product in order.purchasedProducts)
                              _ProductCard(
                                product: product,
                              ),
                            const SizedBox(
                              height: AppSpacing.lg,
                            ),
                          ],
                          _TotalsCard(
                            order: order,
                          ),
                        ],
                      );
                    },
              ),
        ),
      ),
    );
  }

  static String _formatDate(
    DateTime? date,
  ) {
    if (date ==
        null)
      return '';
    final local = date.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-'
        '${local.day.toString().padLeft(2, '0')}';
  }
}

class _BookingCard
    extends
        StatelessWidget {
  const _BookingCard({
    required this.order,
    required this.booking,
    required this.isCancelling,
  });

  final OrderModel order;
  final BookedClassModel booking;
  final bool isCancelling;

  Future<
    void
  >
  _confirmCancel(
    BuildContext context,
  ) async {
    final l10n = context.l10n;
    final confirmed = await AppDialog.confirm(
      context,
      title: l10n.orderCancelConfirmTitle,
      message: l10n.orderCancelConfirmMessage,
      confirmLabel: l10n.orderCancelBooking,
      isDestructive: true,
    );
    if (confirmed &&
        context.mounted) {
      context
          .read<
            OrdersBloc
          >()
          .add(
            OrderCancelBookingRequested(
              orderId: order.id,
              bookingId: booking.id,
            ),
          );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final canCancel = booking.isConfirmed;

    return Opacity(
      opacity: booking.isCancelled
          ? 0.6
          : 1,
      child: Container(
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
                Expanded(
                  child: Text(
                    booking.className,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                _BookingStatusChip(
                  status: booking.bookingStatus,
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.xs,
            ),
            Text(
              '${booking.dateLabel} · ${booking.timeSlot}\n'
              '${booking.coachName} · ${booking.location}',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Row(
              children: [
                Text(
                  l10n.orderAttendees(
                    booking.attendeesCount,
                  ),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${booking.price.toStringAsFixed(2)}',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            if (booking.isCancelled &&
                booking.cancelledAt !=
                    null) ...[
              const SizedBox(
                height: AppSpacing.sm,
              ),
              Text(
                l10n.orderCancelledOn(
                  _OrderDetailView._formatDate(
                    booking.cancelledAt,
                  ),
                ),
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
            // QR entry pass for confirmed, not-yet-started bookings.
            if (booking.isConfirmed &&
                booking.entryPassToken !=
                    null &&
                booking.isUpcoming) ...[
              const SizedBox(
                height: AppSpacing.md,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => _openFullScreenPass(
                    context,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(
                      AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppRadius.md,
                      ),
                      border: Border.all(
                        color: AppColors.grey.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: QrImageView(
                      data: booking.entryPassToken!,
                      size: 140,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSpacing.xs,
              ),
              Center(
                child: Text(
                  l10n.orderViewEntryPass,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ],
            if (canCancel) ...[
              const Divider(
                height: AppSpacing.xxl,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isCancelling
                      ? null
                      : () => _confirmCancel(
                          context,
                        ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(
                      color: AppColors.error,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppRadius.md,
                      ),
                    ),
                  ),
                  child: isCancelling
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          l10n.orderCancelBooking,
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _openFullScreenPass(
    BuildContext context,
  ) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    Navigator.of(
          context,
        )
        .push(
          MaterialPageRoute<
            void
          >(
            builder:
                (
                  _,
                ) => _FullScreenPass(
                  token: booking.entryPassToken!,
                ),
          ),
        )
        .then(
          (
            _,
          ) => SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.edgeToEdge,
          ),
        );
  }
}

class _FullScreenPass
    extends
        StatelessWidget {
  const _FullScreenPass({
    required this.token,
  });

  final String token;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => Navigator.pop(
          context,
        ),
        child: Center(
          child: QrImageView(
            data: token,
            size: 320,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ProductCard
    extends
        StatelessWidget {
  const _ProductCard({
    required this.product,
  });

  final PurchasedProductModel product;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final variant =
        [
              product.selectedColor,
              product.selectedSize,
            ]
            .whereType<
              String
            >()
            .join(
              ' · ',
            );

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
              Expanded(
                child: Text(
                  product.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _BookingStatusChip(
                status: product.fulfillmentStatus,
              ),
            ],
          ),
          if (variant.isNotEmpty) ...[
            const SizedBox(
              height: AppSpacing.xs,
            ),
            Text(
              variant,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
          const SizedBox(
            height: AppSpacing.xs,
          ),
          Text(
            l10n.orderQtyTimes(
              product.quantity,
              '\$${product.price.toStringAsFixed(2)}',
            ),
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey,
            ),
          ),
          if (product.isClubPickup &&
              product.pickupLocation !=
                  null) ...[
            const SizedBox(
              height: AppSpacing.xs,
            ),
            Text(
              product.pickupLocation!,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TotalsCard
    extends
        StatelessWidget {
  const _TotalsCard({
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
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
        children: [
          _row(
            l10n.cartSubtotal,
            order.subtotal,
          ),
          if (order.shippingFee >
              0)
            _row(
              l10n.orderShippingFee,
              order.shippingFee,
            ),
          _row(
            l10n.cartEstimatedTax,
            order.tax,
          ),
          const Divider(
            height: AppSpacing.xxl,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.orderTotalPaidLabel,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '\$${order.totalPaid.toStringAsFixed(2)}',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    double value,
  ) {
    return Builder(
      builder:
          (
            context,
          ) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.xs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  '\$${value.toStringAsFixed(2)}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class _BookingStatusChip
    extends
        StatelessWidget {
  const _BookingStatusChip({
    required this.status,
  });

  final String status;

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
          alpha: 0.3,
        ),
        borderRadius: BorderRadius.circular(
          AppRadius.pill,
        ),
      ),
      child: Text(
        status,
        style: context.textTheme.labelLarge?.copyWith(
          fontSize: 9,
          letterSpacing: 0.6,
          color: AppColors.charcoal,
        ),
      ),
    );
  }
}

class _StatusChip
    extends
        StatelessWidget {
  const _StatusChip({
    required this.status,
  });

  final String status;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(
          AppRadius.pill,
        ),
      ),
      child: Text(
        status,
        style: context.textTheme.labelLarge?.copyWith(
          fontSize: 10,
          letterSpacing: 1,
          color: AppColors.lime,
        ),
      ),
    );
  }
}
