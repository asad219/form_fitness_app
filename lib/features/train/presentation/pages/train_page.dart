import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Train tab: list of ways to train (class, coaching, membership).
class TrainPage
    extends
        StatefulWidget {
  const TrainPage({
    super.key,
  });

  @override
  State<
    TrainPage
  >
  createState() => _TrainPageState();
}

class _TrainPageState
    extends
        State<
          TrainPage
        > {
  int _filter = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final filters = [
      l10n.trainFilterAll,
      l10n.trainFilterClasses,
      l10n.trainFilterCoaching,
      l10n.trainFilterMemberships,
    ];

    final services = [
      _ServiceData(
        filterIndex: 1,
        tag: l10n.trainTagGroupClass,
        title: l10n.trainClassName,
        meta1: l10n.trainClassMeta,
        meta2: l10n.trainClassCoach,
        price: l10n.trainClassPrice,
        next: l10n.trainClassNext,
        onTap: () => Navigator.pushNamed(
          context,
          RoutesName.classDetails,
        ),
      ),
      _ServiceData(
        filterIndex: 2,
        tag: l10n.trainTagCoaching,
        title: l10n.trainPtName,
        meta1: l10n.trainPtMeta,
        meta2: l10n.trainPtCoach,
        price: l10n.trainPtPrice,
        next: l10n.trainPtNext,
      ),
      _ServiceData(
        filterIndex: 3,
        tag: l10n.trainTagMembership,
        title: l10n.trainMembershipName,
        meta1: l10n.trainMembershipMeta,
        meta2: l10n.trainMembershipPlan,
        price: l10n.trainMembershipPrice,
        next: l10n.trainMembershipNext,
      ),
    ];

    final visible =
        _filter ==
            0
        ? services
        : services
              .where(
                (
                  s,
                ) =>
                    s.filterIndex ==
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
              title: l10n.trainTitle,
              onBack: () {},
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            FormHeadline(
              l10n.trainHeadline,
              fontSize: 34,
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Text(
              l10n.trainSubtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
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
                    l10n.trainClubMeta(
                      'Brooklyn',
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
            for (final service in visible) ...[
              _ServiceCard(
                data: service,
              ),
              const SizedBox(
                height: AppSpacing.md,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ServiceData {
  const _ServiceData({
    required this.filterIndex,
    required this.tag,
    required this.title,
    required this.meta1,
    required this.meta2,
    required this.price,
    required this.next,
    this.onTap,
  });

  final int filterIndex;
  final String tag;
  final String title;
  final String meta1;
  final String meta2;
  final String price;
  final String next;
  final VoidCallback? onTap;
}

class _ServiceCard
    extends
        StatelessWidget {
  const _ServiceCard({
    required this.data,
  });

  final _ServiceData data;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
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
                  width: 96,
                  child: FormImagePlaceholder(
                    height: 96,
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
                        data.tag,
                      ),
                      const SizedBox(
                        height: AppSpacing.xs,
                      ),
                      Text(
                        data.title,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${data.meta1}\n${data.meta2}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(
                        height: AppSpacing.xs,
                      ),
                      Text(
                        data.price,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.next,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.iconArrowUpRight,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.charcoal,
                    BlendMode.srcIn,
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
