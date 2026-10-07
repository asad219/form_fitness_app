import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shop tab: searchable grid of FORM essentials.
class ShopPage
    extends
        StatefulWidget {
  const ShopPage({
    super.key,
  });

  @override
  State<
    ShopPage
  >
  createState() => _ShopPageState();
}

class _ShopPageState
    extends
        State<
          ShopPage
        > {
  int _filter = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final filters = [
      l10n.shopFilterAll,
      l10n.shopFilterApparel,
      l10n.shopFilterEquipment,
      l10n.shopFilterRecovery,
    ];

    final products = [
      _ProductData(
        filterIndex: 2,
        tag: l10n.shopTagBestseller,
        name: l10n.onboardingProductBottle,
        meta: l10n.shopBottleMeta,
        price: r'$32',
      ),
      _ProductData(
        filterIndex: 1,
        tag: l10n.shopTagNew,
        name: l10n.onboardingProductTee,
        meta: l10n.shopTeeMeta,
        price: r'$38',
      ),
      _ProductData(
        filterIndex: 2,
        tag: l10n.shopTagTraining,
        name: l10n.onboardingProductResistance,
        meta: l10n.shopResistanceMeta,
        price: r'$24',
      ),
      _ProductData(
        filterIndex: 3,
        tag: l10n.shopTagRecovery,
        name: l10n.onboardingProductRoller,
        meta: l10n.shopRollerMeta,
        price: r'$29',
      ),
    ];

    final visible =
        _filter ==
            0
        ? products
        : products
              .where(
                (
                  p,
                ) =>
                    p.filterIndex ==
                    _filter,
              )
              .toList();

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
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
            // Search field.
            TextField(
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
                        filters.length;
                    i++
                  ) ...[
                    FilterChipPill(
                      label: filters[i],
                      selected:
                          _filter ==
                          i,
                      onTap: () => setState(
                        () => _filter = i,
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.shopMeta(
                      visible.length,
                    ),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
                const Icon(
                  Icons.tune,
                  size: 20,
                  color: AppColors.charcoal,
                ),
              ],
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
                childAspectRatio: 0.68,
              ),
              itemCount: visible.length,
              itemBuilder:
                  (
                    context,
                    index,
                  ) => _ProductCard(
                    data: visible[index],
                  ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Center(
              child: Text(
                l10n.shopPickupNote,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductData {
  const _ProductData({
    required this.filterIndex,
    required this.tag,
    required this.name,
    required this.meta,
    required this.price,
  });

  final int filterIndex;
  final String tag;
  final String name;
  final String meta;
  final String price;
}

class _ProductCard
    extends
        StatelessWidget {
  const _ProductCard({
    required this.data,
  });

  final _ProductData data;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RoutesName.productDetails,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: FormImagePlaceholder(
              showHeart: true,
            ),
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          FormTag(
            data.tag,
          ),
          const SizedBox(
            height: AppSpacing.xs,
          ),
          Text(
            data.name,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            data.meta,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            data.price,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
