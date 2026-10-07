import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';

/// Three-page swipeable intro. "Get started" opens the login screen.
class OnboardingPage
    extends
        StatefulWidget {
  const OnboardingPage({
    super.key,
  });

  @override
  State<
    OnboardingPage
  >
  createState() => _OnboardingPageState();
}

class _OnboardingPageState
    extends
        State<
          OnboardingPage
        > {
  final _pageController = PageController();
  int _currentPage = 0;

  static const int _pageCount = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLast =>
      _currentPage ==
      _pageCount -
          1;

  void _next() {
    if (_isLast) {
      Navigator.pushReplacementNamed(
        context,
        RoutesName.login,
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(
          milliseconds: 350,
        ),
        curve: Curves.easeOut,
      );
    }
  }

  void _skip() => Navigator.pushReplacementNamed(
    context,
    RoutesName.login,
  );

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final buttonLabel = switch (_currentPage) {
      0 => l10n.next,
      1 => l10n.continueLabel,
      _ => l10n.getStarted,
    };

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.md,
                AppSpacing.xl,
                0,
              ),
              child: AuthHeader(
                trailing: TextButton(
                  onPressed: _skip,
                  child: Text(
                    l10n.skip,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.charcoal,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged:
                    (
                      page,
                    ) => setState(
                      () => _currentPage = page,
                    ),
                children: const [
                  _OnboardingOne(),
                  _OnboardingTwo(),
                  _OnboardingThree(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                children: [
                  _PageIndicator(
                    count: _pageCount,
                    current: _currentPage,
                    pageLabel: '0${_currentPage + 1} / 0$_pageCount',
                  ),
                  const SizedBox(
                    height: AppSpacing.lg,
                  ),
                  FormCtaButton(
                    label: buttonLabel,
                    onPressed: _next,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dots on the start, "01 / 03" counter on the end.
class _PageIndicator
    extends
        StatelessWidget {
  const _PageIndicator({
    required this.count,
    required this.current,
    required this.pageLabel,
  });

  final int count;
  final int current;
  final String pageLabel;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        Row(
          children: List.generate(
            count,
            (
              index,
            ) => AnimatedContainer(
              duration: const Duration(
                milliseconds: 250,
              ),
              margin: const EdgeInsetsDirectional.only(
                end: AppSpacing.xs,
              ),
              width:
                  index ==
                      current
                  ? 22
                  : 8,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppRadius.pill,
                ),
                color:
                    index ==
                        current
                    ? AppColors.lime
                    : AppColors.grey.withValues(
                        alpha: 0.35,
                      ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Text(
          pageLabel,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Page 1 — "YOUR GOALS. YOUR PACE." hero with image.
// ---------------------------------------------------------------------------

class _OnboardingOne
    extends
        StatelessWidget {
  const _OnboardingOne();

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSpacing.lg,
          ),
          _HeroImageCard(
            tag: l10n.onboardingClubTag,
            title: l10n.onboardingCardTitle1,
            chips: [
              l10n.onboardingChipMemberships,
              l10n.onboardingChipClasses,
              l10n.onboardingChipPersonalTraining,
            ],
          ),
          const SizedBox(
            height: AppSpacing.xxxl,
          ),
          FormTagline(
            l10n.onboardingLabel1,
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          FormHeadline(
            l10n.onboardingTitle1,
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          Text(
            l10n.onboardingSubtitle1,
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page 2 — product grid "GOOD SESSIONS. GREAT ESSENTIALS."
// ---------------------------------------------------------------------------

class _OnboardingTwo
    extends
        StatelessWidget {
  const _OnboardingTwo();

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSpacing.lg,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
                Row(
                  children: [
                    Text(
                      l10n.onboardingEverydayLineup,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontSize: 11,
                        letterSpacing: 1.2,
                        color: AppColors.grey,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 22,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.lime,
                        borderRadius: BorderRadius.circular(
                          AppRadius.pill,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSpacing.lg,
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.92,
                  children: [
                    _ProductTile(
                      name: l10n.onboardingProductBottle,
                    ),
                    _ProductTile(
                      name: l10n.onboardingProductTee,
                    ),
                    _ProductTile(
                      name: l10n.onboardingProductResistance,
                    ),
                    _ProductTile(
                      name: l10n.onboardingProductRoller,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppSpacing.xxxl,
          ),
          FormTagline(
            l10n.onboardingLabel2,
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          FormHeadline(
            l10n.onboardingTitle2,
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          Text(
            l10n.onboardingSubtitle2,
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductTile
    extends
        StatelessWidget {
  const _ProductTile({
    required this.name,
  });

  final String name;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(
                AppRadius.md,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: AppSpacing.sm,
        ),
        Text(
          name,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Page 3 — "YOUR NEXT MOVE" card with class + product.
// ---------------------------------------------------------------------------

class _OnboardingThree
    extends
        StatelessWidget {
  const _OnboardingThree();

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSpacing.lg,
          ),
          Container(
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
                Row(
                  children: [
                    Text(
                      l10n.onboardingNextMove,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lime,
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style: context.textTheme.labelLarge?.copyWith(
                            color: AppColors.charcoal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSpacing.lg,
                ),
                _NextMoveCard(
                  tag: l10n.onboardingBookAClass,
                  title: l10n.onboardingClassName,
                  meta: l10n.onboardingClassMeta,
                  price: l10n.onboardingClassPrice,
                ),
                const SizedBox(
                  height: AppSpacing.md,
                ),
                _NextMoveCard(
                  tag: l10n.onboardingPickupTag,
                  title: l10n.onboardingProductBottle,
                  meta: l10n.onboardingBottleMeta,
                  price: l10n.onboardingBottlePrice,
                ),
                const SizedBox(
                  height: AppSpacing.md,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(
                    AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: BorderRadius.circular(
                      AppRadius.md,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.charcoal,
                        size: 20,
                      ),
                      const SizedBox(
                        width: AppSpacing.sm,
                      ),
                      Text(
                        l10n.onboardingCartNote,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.charcoal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppSpacing.xxxl,
          ),
          FormTagline(
            l10n.onboardingLabel3,
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          FormHeadline(
            l10n.onboardingTitle3,
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          Text(
            l10n.onboardingSubtitle3,
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
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
  });

  final String tag;
  final String title;
  final String meta;
  final String price;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppRadius.md,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(
                AppRadius.sm,
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
                Text(
                  tag,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: 10,
                    letterSpacing: 1,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(
                  height: 2,
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
              ],
            ),
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

// ---------------------------------------------------------------------------
// Shared hero image card with tag + title + chips overlay.
// ---------------------------------------------------------------------------

class _HeroImageCard
    extends
        StatelessWidget {
  const _HeroImageCard({
    required this.tag,
    required this.title,
    this.chips = const [],
  });

  final String tag;
  final String title;
  final List<
    String
  >
  chips;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: 300,
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.16,
              ),
              borderRadius: BorderRadius.circular(
                AppRadius.pill,
              ),
            ),
            child: Text(
              tag,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: 10,
                letterSpacing: 1.2,
                color: AppColors.lime,
              ),
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: context.textTheme.displaySmall?.copyWith(
              fontSize: 32,
              height: 1.05,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          if (chips.isNotEmpty) ...[
            const SizedBox(
              height: AppSpacing.md,
            ),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final chip in chips)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: 0.16,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppRadius.pill,
                      ),
                    ),
                    child: Text(
                      chip,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.lime,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
