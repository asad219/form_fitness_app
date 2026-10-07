import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/cart/data/models/cart_model.dart';
import 'package:app_boilerplate/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:app_boilerplate/features/cart/presentation/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cart tab: reserved classes + products, totals and checkout.
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
  @override
  void initState() {
    super.initState();
    getIt<
          CartBloc
        >()
        .add(
          const CartLoadRequested(),
        );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return BlocProvider(
      create:
          (
            _,
          ) =>
              getIt<
                CheckoutBloc
              >(),
      child:
          BlocListener<
            CartBloc,
            CartState
          >(
            listenWhen:
                (
                  prev,
                  curr,
                ) =>
                    curr.errorMessage !=
                        null &&
                    prev.errorMessage !=
                        curr.errorMessage,
            listener:
                (
                  context,
                  state,
                ) => AppSnackBar.show(
                  context,
                  state.errorMessage!,
                  type: AppSnackBarType.error,
                ),
            child:
                BlocListener<
                  CheckoutBloc,
                  CheckoutState
                >(
                  listener:
                      (
                        context,
                        state,
                      ) {
                        if (state.status ==
                                CheckoutStatus.success &&
                            state.order !=
                                null) {
                          getIt<
                                CartBloc
                              >()
                              .add(
                                const CartLoadRequested(),
                              );
                          Navigator.pushNamed(
                            context,
                            RoutesName.orderComplete,
                            arguments: state.order,
                          );
                        } else if (state.status ==
                            CheckoutStatus.conflict) {
                          AppSnackBar.show(
                            context,
                            state.errorMessage ??
                                l10n.errorUnknown,
                            type: AppSnackBarType.error,
                          );
                          getIt<
                                CartBloc
                              >()
                              .add(
                                const CartLoadRequested(),
                              );
                        } else if (state.status ==
                            CheckoutStatus.failure) {
                          AppSnackBar.show(
                            context,
                            state.errorMessage ??
                                l10n.errorUnknown,
                            type: AppSnackBarType.error,
                          );
                        }
                      },
                  child: Scaffold(
                    backgroundColor: AppColors.cream,
                    body: SafeArea(
                      child:
                          BlocBuilder<
                            CartBloc,
                            CartState
                          >(
                            builder:
                                (
                                  context,
                                  state,
                                ) {
                                  final cart = state.cart;
                                  return ListView(
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
                                          cart?.itemCount ??
                                              0,
                                        ),
                                        style: context.textTheme.bodyLarge?.copyWith(
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppSpacing.xl,
                                      ),
                                      _buildBody(
                                        context,
                                        state,
                                        cart,
                                      ),
                                    ],
                                  );
                                },
                          ),
                    ),
                  ),
                ),
          ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    CartState state,
    CartModel? cart,
  ) {
    final l10n = context.l10n;

    if (state.isLoading &&
        cart ==
            null) {
      return const Padding(
        padding: EdgeInsets.all(
          AppSpacing.xxl,
        ),
        child: Center(
          child: AppLoader(),
        ),
      );
    }

    if (state.status ==
            CartStatus.failure &&
        cart ==
            null) {
      return AppErrorState(
        message:
            state.errorMessage ??
            l10n.errorUnknown,
        onRetry: () =>
            getIt<
                  CartBloc
                >()
                .add(
                  const CartLoadRequested(),
                ),
      );
    }

    if (cart ==
            null ||
        cart.isEmpty) {
      return AppEmptyState(
        icon: Icons.shopping_bag_outlined,
        title: l10n.cartTitle,
        message: l10n.noOptions,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in cart.serviceItems)
          _ServiceCartCard(
            item: item,
          ),
        for (final item in cart.productItems)
          _ProductCartCard(
            item: item,
          ),
        const SizedBox(
          height: AppSpacing.lg,
        ),
        const Divider(),
        _TotalRow(
          label: l10n.cartSubtotal,
          value: cart.subtotal,
        ),
        _TotalRow(
          label: l10n.cartPickupFree,
          value:
              cart.deliveryFee ==
                  0
              ? l10n.cartFree
              : '\$${cart.deliveryFee.toStringAsFixed(2)}',
        ),
        _TotalRow(
          label: l10n.cartEstimatedTax,
          value: '\$${cart.estimatedTax.toStringAsFixed(2)}',
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
              '\$${cart.total.toStringAsFixed(2)}',
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
        BlocBuilder<
          CheckoutBloc,
          CheckoutState
        >(
          builder:
              (
                context,
                checkoutState,
              ) {
                return _PayButton(
                  label: l10n.cartPayCta(
                    '\$${cart.total.toStringAsFixed(2)}',
                  ),
                  isLoading: checkoutState.isProcessing,
                  onPressed: () => context
                      .read<
                        CheckoutBloc
                      >()
                      .add(
                        const CheckoutProcessRequested(),
                      ),
                );
              },
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
    );
  }
}

class _ServiceCartCard
    extends
        StatelessWidget {
  const _ServiceCartCard({
    required this.item,
  });

  final CartServiceItemModel item;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final session = item.sessionRef;
    final trainingClass = session?.classRef;

    return _CartCardShell(
      tag: l10n.cartTagService,
      title:
          trainingClass?.title ??
          l10n.errorUnknown,
      lines:
          session ==
              null
          ? const []
          : [
              '${session.date.year}-${session.date.month}-${session.date.day} '
                  '· ${session.startTime}',
              session.location,
            ],
      price: item.price,
      imageUrl: trainingClass?.imageUrl,
      onRemove: () =>
          getIt<
                CartBloc
              >()
              .add(
                CartRemoveItemRequested(
                  item.id,
                ),
              ),
      footer:
          session ==
              null
          ? Text(
              l10n.errorUnknown,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
              ),
            )
          : null,
    );
  }
}

class _ProductCartCard
    extends
        StatelessWidget {
  const _ProductCartCard({
    required this.item,
  });

  final CartProductItemModel item;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final product = item.productRef;

    return _CartCardShell(
      tag: l10n.cartTagProduct,
      title:
          product?.name ??
          l10n.errorUnknown,
      lines: [
        [
              item.selectedColor,
              item.selectedSize,
            ]
            .whereType<
              String
            >()
            .join(
              ' · ',
            ),
      ],
      price: item.price,
      imageUrl: product?.imageUrl,
      onRemove: () =>
          getIt<
                CartBloc
              >()
              .add(
                CartRemoveItemRequested(
                  item.id,
                ),
              ),
      footer:
          product ==
              null
          ? Text(
              l10n.errorUnknown,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
              ),
            )
          : _QuantityStepper(
              quantity: item.quantity,
              onChanged:
                  (
                    q,
                  ) =>
                      getIt<
                            CartBloc
                          >()
                          .add(
                            CartUpdateProductRequested(
                              itemId: item.id,
                              quantity: q,
                            ),
                          ),
            ),
    );
  }
}

class _CartCardShell
    extends
        StatelessWidget {
  const _CartCardShell({
    required this.tag,
    required this.title,
    required this.lines,
    required this.price,
    required this.imageUrl,
    required this.onRemove,
    this.footer,
  });

  final String tag;
  final String title;
  final List<
    String
  >
  lines;
  final double price;
  final String? imageUrl;
  final VoidCallback onRemove;
  final Widget? footer;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),
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
              SizedBox(
                width: 88,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
                  child:
                      imageUrl ==
                          null
                      ? const FormImagePlaceholder(
                          height: 88,
                        )
                      : Image.network(
                          imageUrl!,
                          height: 88,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (
                                _,
                                _,
                                _,
                              ) => const FormImagePlaceholder(
                                height: 88,
                              ),
                        ),
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
                    for (final line
                        in lines)
                      if (line.isNotEmpty)
                        Text(
                          line,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                            height: 1.4,
                          ),
                        ),
                    const SizedBox(
                      height: AppSpacing.xs,
                    ),
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onRemove,
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
          if (footer !=
              null) ...[
            const Divider(
              height: AppSpacing.xxl,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: footer!,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove,
            size: 18,
          ),
          onPressed:
              quantity >
                  1
              ? () => onChanged(
                  quantity -
                      1,
                )
              : null,
        ),
        Text(
          '$quantity',
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.add,
            size: 18,
          ),
          onPressed:
              quantity <
                  99
              ? () => onChanged(
                  quantity +
                      1,
                )
              : null,
        ),
      ],
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
  final Object value;

  @override
  Widget build(
    BuildContext context,
  ) {
    final text =
        value
            is double
        ? '\$${(value as double).toStringAsFixed(2)}'
        : value.toString();
    return Padding(
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
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PayButton
    extends
        StatelessWidget {
  const _PayButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading
            ? null
            : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.lime,
          foregroundColor: AppColors.charcoal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.md,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.charcoal,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
