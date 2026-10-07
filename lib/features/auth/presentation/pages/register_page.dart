import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/utils/validators.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Step 1 of creating an account: name, email, password, terms.
class RegisterPage
    extends
        StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<
    RegisterPage
  >
  createState() => _RegisterPageState();
}

class _RegisterPageState
    extends
        State<
          RegisterPage
        > {
  final _formKey =
      GlobalKey<
        FormState
      >();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
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
    final fullName = _nameController.text.trim();
    final parts = fullName.split(
      RegExp(
        r'\s+',
      ),
    );
    context
        .read<
          AuthBloc
        >()
        .add(
          AuthRegisterSubmitted(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            firstName: parts.isEmpty
                ? null
                : parts.first,
            lastName:
                parts.length >
                    1
                ? parts
                      .sublist(
                        1,
                      )
                      .join(
                        ' ',
                      )
                : null,
          ),
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
              height: AppSpacing.xl,
            ),
            AuthStepIndicator(
              currentStep: 1,
              stepOneLabel: l10n.registerStepCreate,
              stepTwoLabel: l10n.registerStepVerify,
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            FormTagline(
              l10n.registerTagLine,
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            FormHeadline(
              l10n.registerHeadline,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              l10n.registerBody,
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
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      controller: _nameController,
                      label: l10n.fullNameLabel,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [
                        AutofillHints.name,
                      ],
                      validator:
                          (
                            value,
                          ) => Validators.required(
                            value,
                            l10n,
                          ),
                    ),
                    const SizedBox(
                      height: AppSpacing.lg,
                    ),
                    AppTextField(
                      controller: _emailController,
                      label: l10n.emailLabel,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
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
                    ),
                    const SizedBox(
                      height: AppSpacing.lg,
                    ),
                    AppPasswordField(
                      controller: _passwordController,
                      hint: l10n.passwordHint,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [
                        AutofillHints.newPassword,
                      ],
                      validator:
                          (
                            value,
                          ) => Validators.strongPassword(
                            value,
                            l10n,
                          ),
                    ),
                    const SizedBox(
                      height: AppSpacing.lg,
                    ),
                    AppPasswordField(
                      controller: _confirmController,
                      label: l10n.confirmPasswordLabel,
                      autofillHints: const [
                        AutofillHints.newPassword,
                      ],
                      onSubmitted:
                          (
                            _,
                          ) => _submit(),
                      validator:
                          (
                            value,
                          ) {
                            if (value !=
                                _passwordController.text) {
                              return l10n.validationPasswordRequired;
                            }
                            return null;
                          },
                    ),
                    const SizedBox(
                      height: AppSpacing.lg,
                    ),
                    AppCheckboxField(
                      label: l10n.agreeToTerms,
                      value: _agreed,
                      mustBeChecked: true,
                      onChanged:
                          (
                            checked,
                          ) => setState(
                            () => _agreed = checked,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            FormCtaButton(
              label: l10n.createAccount,
              onPressed: _submit,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Center(
              child: Text(
                l10n.registerNextNote,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: '${l10n.alreadyHaveAccount} ',
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
              height: AppSpacing.xl,
            ),
          ],
        ),
      ),
    );
  }
}
