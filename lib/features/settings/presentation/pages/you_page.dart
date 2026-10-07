import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/settings/presentation/widgets/language_switcher.dart';
import 'package:app_boilerplate/features/settings/presentation/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// "You" tab: profile, preferences and sign out.
class YouPage
    extends
        StatelessWidget {
  const YouPage({
    super.key,
  });

  Future<
    void
  >
  _confirmSignOut(
    BuildContext context,
  ) async {
    final l10n = context.l10n;
    final confirmed = await AppDialog.confirm(
      context,
      title: l10n.signOutConfirmTitle,
      message: l10n.signOutConfirmMessage,
      confirmLabel: l10n.signOut,
      isDestructive: true,
    );
    if (confirmed &&
        context.mounted) {
      context
          .read<
            AuthBloc
          >()
          .add(
            const AuthLogoutRequested(),
          );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final authState = context
        .watch<
          AuthBloc
        >()
        .state;
    final user = authState.user;
    final isLoading =
        authState.status ==
        AuthStatus.loading;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(
            AppSpacing.xl,
          ),
          children: [
            InsideAppBar(
              title: l10n.navYou,
              onBack: () {},
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            FormHeadline(
              (user?.fullName ??
                      'Alex Morgan')
                  .toUpperCase(),
              fontSize: 34,
            ),
            const SizedBox(
              height: AppSpacing.xs,
            ),
            Text(
              user?.email ??
                  'alex.morgan@gmail.com',
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
              ),
            ),
            if (user !=
                    null &&
                user.membershipStatus !=
                    'NONE') ...[
              const SizedBox(
                height: AppSpacing.sm,
              ),
              _MembershipBadge(
                status: user.membershipStatus,
              ),
            ],
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            _MenuTile(
              icon: Icons.receipt_long_outlined,
              label: l10n.ordersTitle,
              onTap: () => Navigator.pushNamed(
                context,
                RoutesName.orders,
              ),
            ),
            _MenuTile(
              icon: Icons.card_membership_outlined,
              label: l10n.membershipTitle,
              onTap: () => Navigator.pushNamed(
                context,
                RoutesName.membership,
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.themeLabel,
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  const ThemeSwitcher(),
                  const Divider(
                    height: AppSpacing.xxl,
                  ),
                  Text(
                    l10n.languageLabel,
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  const LanguageSwitcher(),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            AppButton.danger(
              label: l10n.signOut,
              isLoading: isLoading,
              onPressed: () => _confirmSignOut(
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small badge showing the live membership plan (ACTIVE / VIP).
class _MembershipBadge
    extends
        StatelessWidget {
  const _MembershipBadge({
    required this.status,
  });

  final String status;

  @override
  Widget build(
    BuildContext context,
  ) {
    final isVip =
        status ==
        'VIP';
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isVip
            ? AppColors.charcoal
            : AppColors.lime,
        borderRadius: BorderRadius.circular(
          AppRadius.pill,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVip
                ? Icons.star
                : Icons.check_circle,
            size: 14,
            color: isVip
                ? AppColors.lime
                : AppColors.charcoal,
          ),
          const SizedBox(
            width: AppSpacing.xs,
          ),
          Text(
            status,
            style: context.textTheme.labelLarge?.copyWith(
              fontSize: 11,
              letterSpacing: 1,
              color: isVip
                  ? AppColors.lime
                  : AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}

/// A tappable settings/menu row.
class _MenuTile
    extends
        StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppRadius.md,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.charcoal,
        ),
        title: Text(
          label,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
