import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:app_boilerplate/features/shop/data/models/product_model.dart';
import 'package:app_boilerplate/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:flutter/material.dart';

/// Product details: photo, color/size pickers, stock note, add to cart.
/// Receives the product id via route arguments.
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
  ProductModel? _product;
  String? _error;
  bool _loading = true;
  String? _color;
  String? _size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_product !=
            null ||
        _error !=
            null) {
      return;
    }
    final id =
        ModalRoute.of(
              context,
            )?.settings.arguments
            as String?;
    _load(
      id ??
          '',
    );
  }

  Future<
    void
  >
  _load(
    String id,
  ) async {
    setState(
      () {
        _loading = true;
        _error = null;
      },
    );
    final result =
        await getIt<
              ShopRepository
            >()
            .getProduct(
              id,
            );
    if (!mounted) return;
    result.fold(
      (
        failure,
      ) => setState(
        () {
          _loading = false;
          _error =
              failure.message ??
              context.l10n.errorUnknown;
        },
      ),
      (
        product,
      ) => setState(
        () {
          _loading = false;
          _product = product;
          _color = product.hasColors
              ? product.colors.first
              : null;
          _size = product.hasSizes
              ? product.sizes.first
              : null;
        },
      ),
    );
  }

  void _addToCart() {
    final product = _product;
    if (product ==
            null ||
        !product.isInStock) {
      return;
    }
    getIt<
          CartBloc
        >()
        .add(
          CartAddProductRequested(
            productId: product.id,
            quantity: 1,
            selectedColor: _color,
            selectedSize: _size,
            fulfillmentMethod: 'CLUB_PICKUP',
          ),
        );
    Navigator.pushNamed(
      context,
      RoutesName.cart,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final product = _product;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: _loading
            ? const Center(
                child: AppLoader(),
              )
            : _error !=
                  null
            ? AppErrorState(
                message: _error!,
                onRetry: () => _load(
                  ModalRoute.of(
                            context,
                          )?.settings.arguments
                          as String? ??
                      '',
                ),
              )
            : product ==
                  null
            ? Center(
                child: Text(
                  l10n.errorUnknown,
                ),
              )
            : _buildContent(
                context,
                product,
              ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProductModel product,
  ) {
    final l10n = context.l10n;
    return ListView(
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
        Container(
          width: double.infinity,
          height: 320,
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
                    height: 320,
                  )
                : Image.network(
                    product.imageUrl!,
                    width: double.infinity,
                    height: 320,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder:
                        (
                          _,
                          _,
                          _,
                        ) => const FormImagePlaceholder(
                          height: 320,
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
              product.badge ==
                      'NONE'
                  ? product.category
                  : product.badge,
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
              '${product.rating.toStringAsFixed(1)} (${product.reviewCount})',
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
                product.name.toUpperCase(),
                fontSize: 34,
              ),
            ),
            Text(
              '\$${product.price.toStringAsFixed(0)}',
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
          product.description,
          style: context.textTheme.bodyLarge?.copyWith(
            color: AppColors.grey,
            height: 1.5,
          ),
        ),
        if (product.hasColors) ...[
          const SizedBox(
            height: AppSpacing.lg,
          ),
          Text(
            'Color',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final color in product.colors)
                _ColorSwatchChip(
                  colorValue: color,
                  selected:
                      _color ==
                      color,
                  onTap: () => setState(
                    () => _color = color,
                  ),
                ),
            ],
          ),
        ],
        if (product.hasSizes) ...[
          const SizedBox(
            height: AppSpacing.lg,
          ),
          Text(
            'Size',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final size in product.sizes)
                _OptionChip(
                  label: size,
                  selected:
                      _size ==
                      size,
                  onTap: () => setState(
                    () => _size = size,
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(
          height: AppSpacing.lg,
        ),
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
              Icon(
                product.isInStock
                    ? Icons.check_circle
                    : Icons.cancel_outlined,
                size: 20,
                color: product.isInStock
                    ? AppColors.charcoal
                    : AppColors.error,
              ),
              const SizedBox(
                width: AppSpacing.sm,
              ),
              Expanded(
                child: Text(
                  product.isInStock
                      ? l10n.productInStock
                      : l10n.noOptions,
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
        SizedBox(
          height: 56,
          child: FilledButton(
            onPressed: product.isInStock
                ? _addToCart
                : null,
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
              l10n.productAddToCart(
                '\$${product.price.toStringAsFixed(0)}',
              ),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        if (product.features.isNotEmpty) ...[
          const SizedBox(
            height: AppSpacing.md,
          ),
          Center(
            child: Text(
              product.features.join(
                ' · ',
              ),
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ColorSwatchChip
    extends
        StatelessWidget {
  const _ColorSwatchChip({
    required this.colorValue,
    required this.selected,
    required this.onTap,
  });

  final String colorValue;
  final bool selected;
  final VoidCallback onTap;

  Color? _parseColor(
    String val,
  ) {
    var hex = val.trim();
    if (hex.startsWith(
      '#',
    )) {
      hex = hex.substring(
        1,
      );
    }
    if (hex.length ==
        6) {
      hex = 'FF$hex';
    }
    final intValue = int.tryParse(
      hex,
      radix: 16,
    );
    if (intValue !=
        null) {
      return Color(
        intValue,
      );
    }
    return switch (val.toLowerCase()) {
      'charcoal' ||
      'black' => AppColors.charcoal,
      'sand' ||
      'cream' => const Color(
        0xFFD8C7B5,
      ),
      'green' ||
      'lime' => AppColors.lime,
      'grey' ||
      'gray' => AppColors.grey,
      'white' => Colors.white,
      _ => null,
    };
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final parsed = _parseColor(
      colorValue,
    );

    if (parsed ==
        null) {
      return _OptionChip(
        label: colorValue,
        selected: selected,
        onTap: onTap,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: parsed,
          shape: BoxShape.circle,
          border: Border.all(
            width: selected
                ? 3.0
                : 1.5,
            color: selected
                ? AppColors.charcoal
                : AppColors.grey.withValues(
                    alpha: 0.35,
                  ),
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.charcoal.withValues(
                      alpha: 0.15,
                    ),
                    blurRadius: 6,
                    offset: const Offset(
                      0,
                      2,
                    ),
                  ),
                ]
              : null,
        ),
        child: selected
            ? Center(
                child: Icon(
                  Icons.check,
                  size: 20,
                  color:
                      parsed.computeLuminance() >
                          0.5
                      ? AppColors.charcoal
                      : Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}

class _OptionChip
    extends
        StatelessWidget {
  const _OptionChip({
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
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.lime
              : Colors.white,
          borderRadius: BorderRadius.circular(
            AppRadius.pill,
          ),
          border: Border.all(
            color: AppColors.grey.withValues(
              alpha: 0.3,
            ),
          ),
        ),
        child: Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
      ),
    );
  }
}
