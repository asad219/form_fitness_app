import 'package:app_boilerplate/app/routes/routes_name.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

/// My Orders: paginated list of past orders.
class OrdersPage
    extends
        StatelessWidget {
  const OrdersPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create:
          (
            _,
          ) =>
              getIt<
                  OrdersBloc
                >()
                ..add(
                  const OrdersLoadRequested(),
                ),
      child: const _OrdersView(),
    );
  }
}

class _OrdersView
    extends
        StatefulWidget {
  const _OrdersView();

  @override
  State<
    _OrdersView
  >
  createState() => _OrdersViewState();
}

class _OrdersViewState
    extends
        State<
          _OrdersView
        > {
  final _scrollController = ScrollController();
  String? _statusFilter;

  static const _statuses = [
    null,
    'PAID',
    'PENDING',
    'FAILED',
    'REFUNDED',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      _onScroll,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels >=
        max -
            200) {
      context
          .read<
            OrdersBloc
          >()
          .add(
            const OrdersLoadMoreRequested(),
          );
    }
  }

  void _selectFilter(
    String? status,
  ) {
    setState(
      () => _statusFilter = status,
    );
    context
        .read<
          OrdersBloc
        >()
        .add(
          OrdersLoadRequested(
            paymentStatus: status,
          ),
        );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return Scaffold(
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
                    return RefreshIndicator(
                      onRefresh: () async => context
                          .read<
                            OrdersBloc
                          >()
                          .add(
                            OrdersLoadRequested(
                              paymentStatus: _statusFilter,
                            ),
                          ),
                      child: ListView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(
                          AppSpacing.xl,
                        ),
                        children: [
                          InsideAppBar(
                            title: l10n.ordersTitle,
                          ),
                          const SizedBox(
                            height: AppSpacing.xl,
                          ),
                          FormHeadline(
                            l10n.ordersHeadline,
                            fontSize: 34,
                          ),
                          const SizedBox(
                            height: AppSpacing.xl,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (final status in _statuses) ...[
                                  FilterChipPill(
                                    label:
                                        status ??
                                        l10n.trainFilterAll,
                                    selected:
                                        _statusFilter ==
                                        status,
                                    onTap: () => _selectFilter(
                                      status,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: AppSpacing.sm,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppSpacing.lg,
                          ),
                          _buildBody(
                            context,
                            state,
                          ),
                        ],
                      ),
                    );
                  },
            ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    OrdersState state,
  ) {
    final l10n = context.l10n;

    if (state.isLoading) {
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
              OrdersLoadRequested(
                paymentStatus: _statusFilter,
              ),
            ),
      );
    }

    if (state.orders.isEmpty) {
      return AppEmptyState(
        icon: Icons.receipt_long_outlined,
        title: l10n.ordersEmptyTitle,
        message: l10n.ordersEmptyMessage,
        actionLabel: l10n.navShop,
        onAction: () => Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.home,
          (
            route,
          ) => false,
        ),
      );
    }

    return Column(
      children: [
        for (final order in state.orders)
          _OrderCard(
            order: order,
          ),
        if (state.isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(
              AppSpacing.lg,
            ),
            child: Center(
              child: AppLoader(),
            ),
          ),
      ],
    );
  }
}

class _OrderCard
    extends
        StatelessWidget {
  const _OrderCard({
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final classCount = order.bookedClasses.length;
    final productCount = order.purchasedProducts.length;

    final summaryParts =
        <
          String
        >[
          if (classCount >
              0)
            '$classCount ${l10n.ordersClassesLabel}',
          if (productCount >
              0)
            '$productCount ${l10n.ordersProductsLabel}',
        ];

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RoutesName.orderDetail,
        arguments: order.id,
      ),
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
                    '#${order.orderNumber}',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
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
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
              ),
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    summaryParts.join(
                      ' · ',
                    ),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
                Text(
                  '\$${order.totalPaid.toStringAsFixed(2)}',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(
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
    final color = switch (status) {
      'PAID' => AppColors.lime,
      'PENDING' => AppColors.warning,
      'FAILED' => AppColors.error,
      'REFUNDED' => AppColors.grey,
      _ => AppColors.grey,
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.25,
        ),
        borderRadius: BorderRadius.circular(
          AppRadius.pill,
        ),
      ),
      child: Text(
        status,
        style: context.textTheme.labelLarge?.copyWith(
          fontSize: 10,
          letterSpacing: 0.8,
          color: AppColors.charcoal,
        ),
      ),
    );
  }
}
