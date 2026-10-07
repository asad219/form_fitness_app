import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage
    extends
        StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            _LoginHero(),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            FormTagline(
              l10n.loginTagLine,
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            FormHeadline(
              l10n.loginHeadline,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              l10n.loginBody,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            const LoginForm(),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: AppButton.text(
                foregroundColor: AppColors.darkSurface,
                label: l10n.forgotPassword,
                onPressed: () => Navigator.pushNamed(
                  context,
                  RoutesName.forgotPassword,
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: '${l10n.newToForm} ',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                  ),
                  children: [
                    TextSpan(
                      text: l10n.createAccount,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(
                          context,
                          RoutesName.register,
                        ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            OrDivider(
              label: l10n.orContinueWith,
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialButton(
                  asset: AppAssets.iconGoogle,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: AppSpacing.lg,
                ),
                SocialButton(
                  asset: AppAssets.iconApple,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.home,
                  (
                    route,
                  ) => false,
                ),
                child: Text(
                  l10n.exploreAsGuest,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The dark hero image card behind the login form.
class _LoginHero
    extends
        StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Container(
      height: 200,
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
              l10n.onboardingClubTag,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: 10,
                letterSpacing: 1.2,
                color: AppColors.lime,
              ),
            ),
          ),
          const Spacer(),
          Text(
            l10n.loginHeroTitle,
            style: context.textTheme.displaySmall?.copyWith(
              fontSize: 28,
              height: 1.05,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
