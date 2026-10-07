import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Home tab: greeting, hero card, category shortcuts and "your next move".
class HomePage
    extends
        StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final user = context
        .watch<
          AuthBloc
        >()
        .state
        .user;
    final firstName =
        (user?.firstName ??
                'Alex')
            .toUpperCase();

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(
            AppSpacing.xl,
          ),
          children: [
            // Header: logo + club + bell.
            Row(
              children: [
                const FormLogo(),
                const SizedBox(
                  width: AppSpacing.md,
                ),
                Expanded(
                  child: Text(
                    l10n.onboardingClubTag,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontSize: 10,
                      letterSpacing: 1.2,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                CircleIconButton(
                  asset: AppAssets.iconBell,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            FormTagline(
              l10n.homeGreetingMorning(
                firstName,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xs,
            ),
            FormHeadline(
              l10n.homeHeadline,
              fontSize: 34,
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            const _HeroCard(),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            _CategoryRow(),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            SectionTitleRow(
              title: l10n.homeNextMove,
              actionLabel: l10n.homeExploreAll,
              onAction: () {},
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            const _NextMoveRow(),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.iconMapPin,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: AppSpacing.sm,
                ),
                Expanded(
                  child: Text(
                    l10n.homeClubNote,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard
    extends
        StatelessWidget {
  const _HeroCard();

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(
          AppRadius.lg,
        ),
      ),
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeHeroTag,
            style: context.textTheme.labelLarge?.copyWith(
              fontSize: 10,
              letterSpacing: 1.2,
              color: AppColors.lime,
            ),
          ),
          const Spacer(),
          Text(
            l10n.homeHeroTitle,
            style: context.textTheme.displaySmall?.copyWith(
              fontSize: 30,
              height: 1.05,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.homeHeroCta,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
              SvgPicture.asset(
                AppAssets.iconArrowUpRight,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.lime,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryRow
    extends
        StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final items = [
      (
        AppAssets.iconTicket,
        l10n.homeCategoryMemberships,
      ),
      (
        AppAssets.iconDumbbell,
        l10n.homeCategoryCoaching,
      ),
      (
        AppAssets.iconShoppingBag,
        l10n.homeCategoryGear,
      ),
    ];
    return Row(
      children: [
        for (final (
              icon,
              label,
            )
            in items) ...[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.charcoal,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  Text(
                    label,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: AppSpacing.md,
          ),
        ],
      ],
    );
  }
}

class _NextMoveRow
    extends
        StatelessWidget {
  const _NextMoveRow();

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _NextMoveCard(
            tag: l10n.trainFilterClasses.toUpperCase(),
            title: l10n.trainClassName,
            meta: l10n.trainClassNext
                .split(
                  '·',
                )
                .first
                .trim(),
            price: l10n.trainClassPrice
                .split(
                  '/',
                )
                .first
                .trim(),
            onTap: () => Navigator.pushNamed(
              context,
              RoutesName.classDetails,
            ),
          ),
        ),
        const SizedBox(
          width: AppSpacing.md,
        ),
        Expanded(
          child: _NextMoveCard(
            tag: l10n.navShop.toUpperCase(),
            title: l10n.onboardingProductBottle,
            meta: '750 ml · In stock',
            price: r'$32',
            onTap: () => Navigator.pushNamed(
              context,
              RoutesName.productDetails,
            ),
          ),
        ),
      ],
    );
  }
}

class _NextMoveCard
    extends
        StatelessWidget {
  const _NextMoveCard({
    required this.tag,
    required this.title,
    required this.meta,
    required this.price,
    required this.onTap,
  });

  final String tag;
  final String title;
  final String meta;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormImagePlaceholder(
            height: 140,
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
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
          Text(
            meta,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.grey,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            price,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
