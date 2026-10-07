import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/utils/validators.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Password reset: enter email, get a reset link.
class ForgotPasswordPage
    extends
        StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  State<
    ForgotPasswordPage
  >
  createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends
        State<
          ForgotPasswordPage
        > {
  final _formKey =
      GlobalKey<
        FormState
      >();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(
      context,
    ).unfocus();
    if (!(_formKey.currentState?.validate() ??
        false)) {
      return;
    }
    // TODO: call reset use case.
    AppSnackBar.show(
      context,
      context.l10n.sendResetLink,
    );
  }

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
            AuthHeader(
              onBack: () => Navigator.pop(
                context,
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            _ResetHero(),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            FormTagline(
              l10n.forgotPasswordTagLine,
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            FormHeadline(
              l10n.forgotPasswordHeadline,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              l10n.forgotPasswordBody,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            Form(
              key: _formKey,
              child: AppTextField(
                controller: _emailController,
                label: l10n.emailLabel,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autofillHints: const [
                  AutofillHints.email,
                ],
                validator:
                    (
                      value,
                    ) => Validators.email(
                      value,
                      l10n,
                    ),
                onSubmitted:
                    (
                      _,
                    ) => _submit(),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            FormCtaButton(
              label: l10n.sendResetLink,
              onPressed: _submit,
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Text(
              l10n.resetLinkNote,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: '${l10n.rememberPassword} ',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                  ),
                  children: [
                    TextSpan(
                      text: l10n.logIn,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushReplacementNamed(
                          context,
                          RoutesName.login,
                        ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            Center(
              child: AppButton.text(
                label: l10n.cantAccessEmail,
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            Center(
              child: Text(
                l10n.trainHardLiveWell,
                style: context.textTheme.labelLarge?.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.4,
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

class _ResetHero
    extends
        StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Container(
      height: 170,
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
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lime,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.iconKeyRound,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.charcoal,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            l10n.forgotPasswordHeroTitle,
            style: context.textTheme.displaySmall?.copyWith(
              fontSize: 26,
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
