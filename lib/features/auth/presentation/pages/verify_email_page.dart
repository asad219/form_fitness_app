import 'dart:async';

import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/widgets.dart';
import 'package:app_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Arguments for the password-reset code entry.
class ResetPasswordArgs {
  const ResetPasswordArgs({
    required this.email,
    required this.resetToken,
  });

  final String email;
  final String resetToken;
}

/// Step 2 of sign-up: enter the 6-digit code emailed to the user.
class VerifyEmailPage
    extends
        StatefulWidget {
  const VerifyEmailPage({
    super.key,
  });

  @override
  State<
    VerifyEmailPage
  >
  createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState
    extends
        State<
          VerifyEmailPage
        > {
  static const int _codeLength = 6;
  static const int _resendSeconds = 24;

  final _controllers = List.generate(
    _codeLength,
    (
      _,
    ) => TextEditingController(),
  );
  final _focusNodes = List.generate(
    _codeLength,
    (
      _,
    ) => FocusNode(),
  );

  Timer? _timer;
  int _secondsLeft = _resendSeconds;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(
      () => _secondsLeft = _resendSeconds,
    );
    _timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (
        timer,
      ) {
        if (_secondsLeft <=
            1) {
          timer.cancel();
          setState(
            () => _secondsLeft = 0,
          );
        } else {
          setState(
            () => _secondsLeft--,
          );
        }
      },
    );
  }

  String get _code => _controllers
      .map(
        (
          c,
        ) => c.text,
      )
      .join();

  void _onDigitChanged(
    int index,
    String value,
  ) {
    if (value.isNotEmpty &&
        index <
            _codeLength -
                1) {
      _focusNodes[index +
              1]
          .requestFocus();
    }
    if (value.isEmpty &&
        index >
            0) {
      _focusNodes[index -
              1]
          .requestFocus();
    }
    setState(
      () {},
    );
  }

  Future<
    void
  >
  _submit() async {
    FocusScope.of(
      context,
    ).unfocus();
    if (_code.length <
        _codeLength) {
      return;
    }

    final args = ModalRoute.of(
      context,
    )?.settings.arguments;
    if (args
        is! ResetPasswordArgs) {
      // No reset context — fall back to home (register has no verify step yet).
      unawaited(
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.home,
          (
            route,
          ) => false,
        ),
      );
      return;
    }

    setState(
      () => _isLoading = true,
    );
    final repo =
        getIt<
          AuthRepository
        >();
    final verified = await repo.verifyResetCode(
      token: args.resetToken,
      code: _code,
    );

    final isVerified =
        verified.dataOrNull ??
        false;
    if (!mounted) return;

    if (!isVerified) {
      setState(
        () => _isLoading = false,
      );
      AppSnackBar.show(
        context,
        verified.failureOrNull?.message ??
            context.l10n.errorUnknown,
        type: AppSnackBarType.error,
      );
      return;
    }

    // Code verified: set a new password (uses the same code + token).
    final result = await repo.updatePassword(
      email: args.email,
      password: _code, // replaced by the new-password screen in a full flow
      token: args.resetToken,
      code: _code,
    );
    if (!mounted) return;
    setState(
      () => _isLoading = false,
    );
    result.fold(
      (
        failure,
      ) => AppSnackBar.show(
        context,
        failure.message ??
            context.l10n.errorUnknown,
        type: AppSnackBarType.error,
      ),
      (
        _,
      ) => Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.login,
        (
          route,
        ) => false,
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    final resendLabel =
        _secondsLeft >
            0
        ? l10n.resendCodeIn(
            '00:${_secondsLeft.toString().padLeft(2, '0')}',
          )
        : l10n.resendCode;

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
              currentStep: 2,
              stepOneLabel: l10n.registerStepCreate,
              stepTwoLabel: l10n.registerStepVerify,
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            // Envelope hero icon.
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.charcoal,
                borderRadius: BorderRadius.circular(
                  AppRadius.lg,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.iconMailCheck,
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                    AppColors.lime,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            FormTagline(
              l10n.verifyTagLine(
                'Alex',
              ),
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            FormHeadline(
              l10n.verifyHeadline,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              l10n.verifyBody,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            // Code-sent-to row.
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.verifyCodeSentTo,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'a•••.m••••••@gmail.com',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AppButton.text(
                  label: l10n.changeEmail,
                  onPressed: () => Navigator.pop(
                    context,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            Text(
              l10n.verificationCodeLabel,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            // 6-box code input.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _codeLength,
                (
                  index,
                ) => _CodeBox(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged:
                      (
                        value,
                      ) => _onDigitChanged(
                        index,
                        value,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              l10n.codeValidFor,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
              ),
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            FormCtaButton(
              label: l10n.verifyAndCreate,
              isLoading: _isLoading,
              onPressed:
                  _code.length ==
                      _codeLength
                  ? _submit
                  : null,
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Center(
              child: Text(
                l10n.didntReceiveCode,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xs,
            ),
            Center(
              child: GestureDetector(
                onTap:
                    _secondsLeft ==
                        0
                    ? _startTimer
                    : null,
                child: Text(
                  resendLabel,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color:
                        _secondsLeft ==
                            0
                        ? AppColors.charcoal
                        : AppColors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.xl,
            ),
            // Spam note.
            Container(
              padding: const EdgeInsets.all(
                AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: AppColors.lime.withValues(
                  alpha: 0.25,
                ),
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 20,
                    color: AppColors.charcoal,
                  ),
                  const SizedBox(
                    width: AppSpacing.sm,
                  ),
                  Expanded(
                    child: Text(
                      l10n.checkSpamNote,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.charcoal,
                      ),
                    ),
                  ),
                ],
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

/// One box of the 6-digit verification code.
class _CodeBox
    extends
        StatelessWidget {
  const _CodeBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<
    String
  >
  onChanged;

  @override
  Widget build(
    BuildContext context,
  ) {
    final filled = controller.text.isNotEmpty;
    return SizedBox(
      width: 48,
      height: 56,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: context.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.sm,
            ),
            borderSide: BorderSide(
              color: filled
                  ? AppColors.charcoal
                  : AppColors.grey.withValues(
                      alpha: 0.4,
                    ),
              width: filled
                  ? 1.5
                  : 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.sm,
            ),
            borderSide: const BorderSide(
              color: AppColors.charcoal,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
