import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/membership/data/models/membership_model.dart';
import 'package:app_boilerplate/features/membership/presentation/bloc/membership_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Membership screen: plans (no membership), current plan, or history.
class MembershipPage
    extends
        StatelessWidget {
  const MembershipPage({
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
                  MembershipBloc
                >()
                ..add(
                  const MembershipLoadRequested(),
                ),
      child: const _MembershipView(),
    );
  }
}

class _MembershipView
    extends
        StatefulWidget {
  const _MembershipView();

  @override
  State<
    _MembershipView
  >
  createState() => _MembershipViewState();
}

class _MembershipViewState
    extends
        State<
          _MembershipView
        > {
  String _cycle = 'MONTHLY';

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final isLoggedIn =
        context.select<
          AuthBloc,
          bool
        >(
          (
            bloc,
          ) =>
              bloc.state.status ==
              AuthStatus.authenticated,
        );

    return BlocListener<
      MembershipBloc,
      MembershipState
    >(
      listenWhen:
          (
            prev,
            curr,
          ) =>
              (curr.errorMessage !=
                      null &&
                  prev.errorMessage !=
                      curr.errorMessage) ||
              (curr.actionMessage !=
                      null &&
                  prev.actionMessage !=
                      curr.actionMessage),
      listener:
          (
            context,
            state,
          ) {
            if (state.errorMessage !=
                null) {
              AppSnackBar.show(
                context,
                state.errorMessage!,
                type: AppSnackBarType.error,
              );
            } else if (state.actionMessage !=
                null) {
              AppSnackBar.show(
                context,
                state.actionMessage!,
              );
            }
          },
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          child:
              BlocBuilder<
                MembershipBloc,
                MembershipState
              >(
                builder:
                    (
                      context,
                      state,
                    ) {
                      if (state.isLoading) {
                        return const Center(
                          child: AppLoader(),
                        );
                      }
                      if (state.status ==
                          MembershipStatus.failure) {
                        return AppErrorState(
                          message:
                              state.errorMessage ??
                              l10n.errorUnknown,
                          onRetry: () => context
                              .read<
                                MembershipBloc
                              >()
                              .add(
                                const MembershipLoadRequested(),
                              ),
                        );
                      }

                      final live = state.membership;
                      return ListView(
                        padding: const EdgeInsets.all(
                          AppSpacing.xl,
                        ),
                        children: [
                          InsideAppBar(
                            title: l10n.membershipTitle,
                          ),
                          const SizedBox(
                            height: AppSpacing.xl,
                          ),
                          FormHeadline(
                            l10n.membershipHeadline,
                            fontSize: 34,
                          ),
                          const SizedBox(
                            height: AppSpacing.xl,
                          ),
                          if (!isLoggedIn) _LoginRequiredCard(),
                          if (isLoggedIn &&
                              live !=
                                  null)
                            _CurrentMembershipCard(
                              membership: live,
                              isBusy: state.isBusy,
                            ),
                          if (isLoggedIn &&
                              live ==
                                  null) ...[
                            _CycleToggle(
                              cycle: _cycle,
                              onChanged:
                                  (
                                    c,
                                  ) => setState(
                                    () => _cycle = c,
                                  ),
                            ),
                            const SizedBox(
                              height: AppSpacing.lg,
                            ),
                            for (final plan in state.plans)
                              _PlanCard(
                                plan: plan,
                                cycle: _cycle,
                                isBusy: state.isBusy,
                              ),
                          ],
                          if (isLoggedIn &&
                              state.pastHistory.isNotEmpty) ...[
                            const SizedBox(
                              height: AppSpacing.xxl,
                            ),
                            FormTagline(
                              l10n.membershipHistoryTitle,
                            ),
                            const SizedBox(
                              height: AppSpacing.md,
                            ),
                            for (final m in state.pastHistory)
                              _HistoryCard(
                                membership: m,
                              ),
                          ],
                        ],
                      );
                    },
              ),
        ),
      ),
    );
  }
}

class _LoginRequiredCard
    extends
        StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Container(
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
        children: [
          Text(
            l10n.membershipLoginRequired,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSpacing.lg,
          ),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: () => Navigator.pushNamed(
                context,
                RoutesName.login,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.lime,
                foregroundColor: AppColors.charcoal,
              ),
              child: Text(
                l10n.logIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CycleToggle
    extends
        StatelessWidget {
  const _CycleToggle({
    required this.cycle,
    required this.onChanged,
  });

  final String cycle;
  final ValueChanged<
    String
  >
  onChanged;

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(
        4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppRadius.pill,
        ),
      ),
      child: Row(
        children: [
          _option(
            l10n.membershipMonthly,
            'MONTHLY',
          ),
          _option(
            l10n.membershipYearly,
            'YEARLY',
          ),
        ],
      ),
    );
  }

  Widget _option(
    String label,
    String value,
  ) {
    final selected =
        cycle ==
        value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(
          value,
        ),
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.lime
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              AppRadius.pill,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: selected
                    ? AppColors.charcoal
                    : AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanCard
    extends
        StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.cycle,
    required this.isBusy,
  });

  final MembershipPlanModel plan;
  final String cycle;
  final bool isBusy;

  void _subscribe(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final price = plan.priceFor(
      cycle,
    );
    final months =
        cycle ==
            'YEARLY'
        ? 12
        : 1;
    final endDate = DateTime.now().add(
      Duration(
        days:
            30 *
            months,
      ),
    );
    final endLabel =
        '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-'
        '${endDate.day.toString().padLeft(2, '0')}';

    showModalBottomSheet<
      void
    >(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppRadius.lg,
          ),
        ),
      ),
      builder:
          (
            sheetContext,
          ) => Padding(
            padding: const EdgeInsets.all(
              AppSpacing.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.membershipConfirmTitle,
                  style: sheetContext.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.md,
                ),
                Text(
                  '${plan.name} · $cycle',
                  style: sheetContext.textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: AppSpacing.xs,
                ),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: sheetContext.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.xs,
                ),
                Text(
                  l10n.membershipEndsOn(
                    endLabel,
                  ),
                  style: sheetContext.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.xl,
                ),
                SizedBox(
                  height: 52,
                  child: FilledButton(
                    onPressed: isBusy
                        ? null
                        : () {
                            Navigator.pop(
                              sheetContext,
                            );
                            context
                                .read<
                                  MembershipBloc
                                >()
                                .add(
                                  MembershipSubscribeRequested(
                                    plan: plan.code,
                                    billingCycle: cycle,
                                  ),
                                );
                          },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.lime,
                      foregroundColor: AppColors.charcoal,
                    ),
                    child: Text(
                      l10n.membershipConfirmCta,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final price = plan.priceFor(
      cycle,
    );
    final cycleLabel =
        cycle ==
            'YEARLY'
        ? l10n.perYear
        : l10n.perMonth;

    return Container(
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
        border:
            plan.code ==
                'VIP'
            ? Border.all(
                color: AppColors.lime,
                width: 2,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.name,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: AppSpacing.xs,
          ),
          Text(
            plan.description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.grey,
            ),
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${price.toStringAsFixed(0)}',
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(
                width: AppSpacing.xs,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 6,
                ),
                child: Text(
                  cycleLabel,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ],
          ),
          if (cycle ==
                  'YEARLY' &&
              plan.yearlySaving >
                  0) ...[
            const SizedBox(
              height: AppSpacing.xs,
            ),
            Text(
              l10n.membershipYearlySaving(
                '\$${plan.yearlySaving.toStringAsFixed(0)}',
              ),
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.charcoal,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(
            height: AppSpacing.md,
          ),
          for (final perk in plan.perks)
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    size: 16,
                    color: AppColors.charcoal,
                  ),
                  const SizedBox(
                    width: AppSpacing.sm,
                  ),
                  Expanded(
                    child: Text(
                      perk,
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: isBusy
                  ? null
                  : () => _subscribe(
                      context,
                    ),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.charcoal,
                foregroundColor: AppColors.lime,
              ),
              child: Text(
                l10n.membershipJoin(
                  plan.name,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentMembershipCard
    extends
        StatelessWidget {
  const _CurrentMembershipCard({
    required this.membership,
    required this.isBusy,
  });

  final MembershipModel membership;
  final bool isBusy;

  Future<
    void
  >
  _confirmCancel(
    BuildContext context,
  ) async {
    final l10n = context.l10n;
    final endLabel = _formatDate(
      membership.endDate,
    );
    final confirmed = await AppDialog.confirm(
      context,
      title: l10n.membershipCancelConfirmTitle,
      message: l10n.membershipCancelConfirmMessage(
        endLabel,
      ),
      confirmLabel: l10n.membershipCancel,
      isDestructive: true,
    );
    if (confirmed &&
        context.mounted) {
      context
          .read<
            MembershipBloc
          >()
          .add(
            const MembershipCancelRequested(),
          );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(
          AppRadius.lg,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormTag(
            l10n.membershipCurrentPlan,
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          Text(
            membership.plan,
            style: context.textTheme.displaySmall?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.lime,
            ),
          ),
          const SizedBox(
            height: AppSpacing.xs,
          ),
          Text(
            '${membership.billingCycle} · '
            '\$${membership.price.toStringAsFixed(2)}',
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          _metaRow(
            l10n.membershipMemberSince(
              _formatDate(
                membership.startDate,
              ),
            ),
          ),
          _metaRow(
            l10n.membershipValidUntil(
              _formatDate(
                membership.endDate,
              ),
            ),
          ),
          _metaRow(
            l10n.membershipDaysRemaining(
              membership.daysRemaining,
            ),
          ),
          if (membership.isCancelled) ...[
            const SizedBox(
              height: AppSpacing.md,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.12,
                ),
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
              child: Text(
                l10n.membershipCancelledBanner(
                  _formatDate(
                    membership.endDate,
                  ),
                ),
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ] else ...[
            const SizedBox(
              height: AppSpacing.lg,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: isBusy
                    ? null
                    : () => _confirmCancel(
                        context,
                      ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.white54,
                  ),
                ),
                child: Text(
                  l10n.membershipCancel,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _metaRow(
    String text,
  ) {
    return Builder(
      builder:
          (
            context,
          ) => Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacing.xs,
            ),
            child: Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
    );
  }

  static String _formatDate(
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

class _HistoryCard
    extends
        StatelessWidget {
  const _HistoryCard({
    required this.membership,
  });

  final MembershipModel membership;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.sm,
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  membership.plan,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '${membership.billingCycle} · '
                  '${_formatDate(membership.startDate)} – '
                  '${_formatDate(membership.endDate)}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${membership.price.toStringAsFixed(0)}',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(
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
