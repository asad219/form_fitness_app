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
            const SizedBox(
              height: AppSpacing.xxl,
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
