import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:app_boilerplate/features/train/data/models/training_class_model.dart';
import 'package:app_boilerplate/features/train/presentation/bloc/class_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Class details: info, upcoming session picker and reserve CTA.
/// Receives the class id via route arguments.
class ClassDetailsPage
    extends
        StatelessWidget {
  const ClassDetailsPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final classId =
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
                  ClassDetailBloc
                >()
                ..add(
                  ClassDetailLoadRequested(
                    classId ??
                        '',
                  ),
                ),
      child: const _ClassDetailsView(),
    );
  }
}

class _ClassDetailsView
    extends
        StatefulWidget {
  const _ClassDetailsView();

  @override
  State<
    _ClassDetailsView
  >
  createState() => _ClassDetailsViewState();
}

class _ClassDetailsViewState
    extends
        State<
          _ClassDetailsView
        > {
  ClassSessionModel? _selectedSession;

  void _reserve() {
    final session = _selectedSession;
    if (session ==
            null ||
        !session.isBookable) {
      return;
    }
    getIt<
          CartBloc
        >()
        .add(
          CartAddServiceRequested(
            sessionId: session.id,
          ),
        );
    Navigator.pushNamed(
      context,
      RoutesName.reservation,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return BlocListener<
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
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          child:
              BlocBuilder<
                ClassDetailBloc,
                ClassDetailState
              >(
                builder:
                    (
                      context,
                      state,
                    ) {
                      final trainingClass = state.trainingClass;

                      if (state.isLoading ||
                          trainingClass ==
                              null) {
                        return const Center(
                          child: AppLoader(),
                        );
                      }

                      if (state.status ==
                          ClassDetailStatus.failure) {
                        return AppErrorState(
                          message:
                              state.errorMessage ??
                              l10n.errorUnknown,
                          onRetry: () {},
                        );
                      }

                      final bookable = state.sessions
                          .where(
                            (
                              s,
                            ) => s.isBookable,
                          )
                          .toList();
                      _selectedSession ??= bookable.isEmpty
                          ? null
                          : bookable.first;

                      return ListView(
                        padding: const EdgeInsets.all(
                          AppSpacing.xl,
                        ),
                        children: [
                          InsideAppBar(
                            title: l10n.classDetailsTitle,
                          ),
                          const SizedBox(
                            height: AppSpacing.lg,
                          ),
                          Container(
                            width: double.infinity,
                            height: 220,
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
                                  trainingClass.imageUrl ==
                                      null
                                  ? const FormImagePlaceholder(
                                      height: 220,
                                    )
                                  : Image.network(
                                      trainingClass.imageUrl!,
                                      width: double.infinity,
                                      height: 220,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      errorBuilder:
                                          (
                                            _,
                                            _,
                                            _,
                                          ) => const FormImagePlaceholder(
                                            height: 220,
                                          ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSpacing.lg,
                          ),
                          Row(
                            children: [
                              FormTag(
                                trainingClass.category,
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
                                '${trainingClass.rating.toStringAsFixed(1)} '
                                '(${trainingClass.reviewCount})',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSpacing.md,
                          ),
                          FormHeadline(
                            trainingClass.title.toUpperCase(),
                            fontSize: 36,
                          ),
                          const SizedBox(
                            height: AppSpacing.sm,
                          ),
                          Text(
                            trainingClass.description,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColors.grey,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(
                            height: AppSpacing.md,
                          ),
                          Text(
                            '${trainingClass.durationMinutes} min · '
                            '${trainingClass.level} · ${trainingClass.coachName}',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: AppSpacing.xxl,
                          ),
                          SectionTitleRow(
                            title: l10n.classPickSession,
                          ),
                          const SizedBox(
                            height: AppSpacing.lg,
                          ),
                          if (state.sessions.isEmpty)
                            Text(
                              l10n.noOptions,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.grey,
                              ),
                            )
                          else
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              children: [
                                for (final session in state.sessions)
                                  _SessionChip(
                                    session: session,
                                    selected:
                                        _selectedSession?.id ==
                                        session.id,
                                    onTap: session.isBookable
                                        ? () => setState(
                                            () => _selectedSession = session,
                                          )
                                        : null,
                                  ),
                              ],
                            ),
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
                                Expanded(
                                  child: Text(
                                    l10n.classTicketLabel,
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$${trainingClass.price.toStringAsFixed(0)}',
                                  style: context.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
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
                              onPressed:
                                  _selectedSession ==
                                      null
                                  ? null
                                  : _reserve,
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
                                l10n.classReserveCta(
                                  '\$${trainingClass.price.toStringAsFixed(0)}',
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSpacing.md,
                          ),
                          Center(
                            child: Text(
                              l10n.classCancelNote,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
              ),
        ),
      ),
    );
  }
}

class _SessionChip
    extends
        StatelessWidget {
  const _SessionChip({
    required this.session,
    required this.selected,
    this.onTap,
  });

  final ClassSessionModel session;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    final bookable = session.isBookable;
    // Display the UTC date as-is (date-only value stored as UTC midnight).
    final dateLabel =
        '${session.date.year}-${session.date.month.toString().padLeft(2, '0')}-'
        '${session.date.day.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.lime
              : Colors.white,
          borderRadius: BorderRadius.circular(
            AppRadius.md,
          ),
          border: Border.all(
            color: AppColors.grey.withValues(
              alpha: 0.3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateLabel,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: 11,
                color: bookable
                    ? AppColors.charcoal
                    : AppColors.grey,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              '${session.startTime} · ${session.availableSpots} left',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: bookable
                    ? AppColors.charcoal
                    : AppColors.grey,
                decoration: bookable
                    ? null
                    : TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
