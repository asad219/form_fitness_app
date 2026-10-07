import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/train/data/models/training_class_model.dart';
import 'package:app_boilerplate/features/train/presentation/bloc/train_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Train tab: list of ways to train, loaded from the API.
class TrainPage
    extends
        StatelessWidget {
  const TrainPage({
    super.key,
  });

  static const _categories = [
    (
      label: 'All',
      value: null,
    ),
    (
      label: 'Classes',
      value: 'GROUP_CLASS',
    ),
    (
      label: 'Coaching',
      value: 'PERSONAL_TRAINING',
    ),
    (
      label: 'Memberships',
      value: 'MEMBERSHIP',
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
                  TrainBloc
                >()
                ..add(
                  const TrainLoadRequested(),
                ),
      child: const _TrainView(),
    );
  }
}

class _TrainView
    extends
        StatefulWidget {
  const _TrainView();

  @override
  State<
    _TrainView
  >
  createState() => _TrainViewState();
}

class _TrainViewState
    extends
        State<
          _TrainView
        > {
  int _filter = 0;

  String? get _category => TrainPage._categories[_filter].value;

  void _selectFilter(
    int index,
  ) {
    setState(
      () => _filter = index,
    );
    context
        .read<
          TrainBloc
        >()
        .add(
          TrainLoadRequested(
            category: _category,
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
              TrainBloc,
              TrainState
            >(
              builder:
                  (
                    context,
                    state,
                  ) {
                    return RefreshIndicator(
                      onRefresh: () async => context
                          .read<
                            TrainBloc
                          >()
                          .add(
                            TrainLoadRequested(
                              category: _category,
                            ),
                          ),
                      child: ListView(
                        padding: const EdgeInsets.all(
                          AppSpacing.xl,
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
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
                                      TrainPage._categories.length;
                                  i++
                                ) ...[
                                  FilterChipPill(
                                    label: TrainPage._categories[i].label,
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
                      ),
                    );
                  },
            ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    TrainState state,
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
        TrainStatus.failure) {
      return AppErrorState(
        message:
            state.errorMessage ??
            l10n.errorUnknown,
        onRetry: () => context
            .read<
              TrainBloc
            >()
            .add(
              TrainLoadRequested(
                category: _category,
              ),
            ),
      );
    }

    if (state.classes.isEmpty) {
      return AppEmptyState(
        title: l10n.trainTitle,
        message: l10n.noResultsFor(
          _category ??
              '',
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.trainClubMeta(
            'Brooklyn',
            state.classes.length,
          ),
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.grey,
          ),
        ),
        const SizedBox(
          height: AppSpacing.md,
        ),
        for (final item in state.classes) ...[
          _ServiceCard(
            trainingClass: item,
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
        ],
      ],
    );
  }
}

class _ServiceCard
    extends
        StatelessWidget {
  const _ServiceCard({
    required this.trainingClass,
  });

  final TrainingClassModel trainingClass;

  String
  _tagFor(
    String category,
  ) => switch (category) {
    'GROUP_CLASS' => 'GROUP CLASS',
    'PERSONAL_TRAINING' => '1:1 COACHING',
    'MEMBERSHIP' => 'MEMBERSHIP',
    _ => category,
  };

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RoutesName.classDetails,
        arguments: trainingClass.id,
      ),
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
                SizedBox(
                  width: 96,
                  child: _ClassThumbnail(
                    imageUrl: trainingClass.imageUrl,
                  ),
                ),
                const SizedBox(
                  width: AppSpacing.md,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: [
                          FormTag(
                            _tagFor(
                              trainingClass.category,
                            ),
                          ),
                          if (trainingClass.includedInMembership)
                            FormTag(
                              context.l10n.membershipIncluded,
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSpacing.xs,
                      ),
                      Text(
                        trainingClass.title,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${trainingClass.durationMinutes} min · '
                        '${trainingClass.level}\n${trainingClass.coachName}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(
                        height: AppSpacing.xs,
                      ),
                      Text(
                        '\$${trainingClass.price.toStringAsFixed(0)} / class',
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
                const Spacer(),
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

class _ClassThumbnail
    extends
        StatelessWidget {
  const _ClassThumbnail({
    this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(
    BuildContext context,
  ) {
    final url = imageUrl;
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: const Color(
          0xFFE8E4DA,
        ),
        borderRadius: BorderRadius.circular(
          AppRadius.md,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppRadius.md,
        ),
        child:
            url ==
                    null ||
                url.isEmpty
            ? const FormImagePlaceholder(
                height: 96,
              )
            : Image.network(
                url,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder:
                    (
                      _,
                      _,
                      _,
                    ) => const FormImagePlaceholder(
                      height: 96,
                    ),
              ),
      ),
    );
  }
}
