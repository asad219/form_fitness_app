import 'dart:async';

import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/shop/data/models/product_model.dart';
import 'package:app_boilerplate/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shop tab: searchable, paginated grid of FORM essentials.
class ShopPage
    extends
        StatelessWidget {
  const ShopPage({
    super.key,
  });

  static const _categories = [
    (
      label: 'All gear',
      value: null,
    ),
    (
      label: 'Apparel',
      value: 'APPAREL',
    ),
    (
      label: 'Equipment',
      value: 'EQUIPMENT',
    ),
    (
      label: 'Recovery',
      value: 'RECOVERY',
    ),
  ];

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
                  ShopBloc
                >()
                ..add(
                  const ShopLoadRequested(),
                ),
      child: const _ShopView(),
    );
  }
}

class _ShopView
    extends
        StatefulWidget {
  const _ShopView();

  @override
  State<
    _ShopView
  >
  createState() => _ShopViewState();
}

class _ShopViewState
    extends
        State<
          _ShopView
        > {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _debounce;
  int _filter = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      _onScroll,
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String? get _category => ShopPage._categories[_filter].value;

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels >=
        max -
            200) {
      context
          .read<
            ShopBloc
          >()
          .add(
            const ShopLoadMoreRequested(),
          );
    }
  }

  void _selectFilter(
    int index,
  ) {
    setState(
      () => _filter = index,
    );
    context
        .read<
          ShopBloc
        >()
        .add(
          ShopLoadRequested(
            category: _category,
            search: _searchController.text,
          ),
        );
  }

  void _onSearchChanged(
    String value,
  ) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(
        milliseconds: 400,
      ),
      () {
        context
            .read<
              ShopBloc
            >()
            .add(
              ShopLoadRequested(
                category: _category,
                search: value,
              ),
            );
      },
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
              ShopBloc,
              ShopState
            >(
              builder:
                  (
                    context,
                    state,
                  ) {
                    return ListView(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(
                        AppSpacing.xl,
                      ),
                      children: [
                        InsideAppBar(
                          title: l10n.shopTitle,
                          onBack: () {},
                        ),
                        const SizedBox(
                          height: AppSpacing.xl,
                        ),
                        FormHeadline(
                          l10n.shopHeadline,
                          fontSize: 34,
                        ),
                        const SizedBox(
                          height: AppSpacing.sm,
                        ),
                        Text(
                          l10n.shopSubtitle,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: AppSpacing.xl,
                        ),
                        TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            hintText: l10n.shopSearchHint,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(
                                AppSpacing.md,
                              ),
                              child: SvgPicture.asset(
                                AppAssets.iconSearch,
                                width: 18,
                                height: 18,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.grey,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppRadius.md,
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSpacing.lg,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (
                                var i = 0;
                                i <
                                    ShopPage._categories.length;
                                i++
                              ) ...[
                                FilterChipPill(
                                  label: ShopPage._categories[i].label,
                                  selected:
                                      _filter ==
                                      i,
                                  onTap: () => _selectFilter(
                                    i,
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
                    );
                  },
            ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ShopState state,
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
        ShopStatus.failure) {
      return AppErrorState(
        message:
            state.errorMessage ??
            l10n.errorUnknown,
        onRetry: () => context
            .read<
              ShopBloc
            >()
            .add(
              ShopLoadRequested(
                category: _category,
                search: _searchController.text,
              ),
            ),
      );
    }

    if (state.products.isEmpty) {
      return AppEmptyState(
        title: l10n.shopTitle,
        message: l10n.noResultsFor(
          _searchController.text,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.shopMeta(
            state.products.length,
          ),
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.grey,
          ),
        ),
        const SizedBox(
          height: AppSpacing.md,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.lg,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.62,
          ),
          itemCount: state.products.length,
          itemBuilder:
              (
                context,
                index,
              ) => _ProductCard(
                product: state.products[index],
              ),
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

class _ProductCard
    extends
        StatelessWidget {
  const _ProductCard({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RoutesName.productDetails,
        arguments: product.id,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(
                  0xFFE8E4DA,
                ),
                borderRadius: BorderRadius.circular(
                  AppRadius.lg,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppRadius.lg,
                ),
                child:
                    product.imageUrl ==
                        null
                    ? const FormImagePlaceholder(
                        showHeart: true,
                      )
                    : Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        errorBuilder:
                            (
                              _,
                              _,
                              _,
                            ) => const FormImagePlaceholder(
                              showHeart: true,
                            ),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          SizedBox(
            height: 24,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child:
                  product.badge !=
                      'NONE'
                  ? FormTag(
                      product.badge,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          const SizedBox(
            height: AppSpacing.xs,
          ),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            product.subtitle ??
                product.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            '\$${product.price.toStringAsFixed(0)}',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
