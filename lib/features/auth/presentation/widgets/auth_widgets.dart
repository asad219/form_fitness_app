import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The lime primary button used across auth screens. Rounded, full width,
/// with an optional up-right arrow at the end.
class FormCtaButton
    extends
        StatelessWidget {
  const FormCtaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.showArrow = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  /// Shows the up-right arrow icon at the end (the design's signature).
  final bool showArrow;

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading
            ? null
            : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.lime,
          foregroundColor: AppColors.charcoal,
          disabledBackgroundColor: AppColors.lime.withValues(
            alpha: 0.6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.md,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.charcoal,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  if (showArrow)
                    SvgPicture.asset(
                      AppAssets.iconArrowUpRight,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.charcoal,
                        BlendMode.srcIn,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

/// A social sign-in button with an SVG logo (Google / Apple).
class SocialButton
    extends
        StatelessWidget {
  const SocialButton({
    super.key,
    required this.asset,
    required this.onPressed,
    this.tooltip,
  });

  final String asset;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Tooltip(
      message:
          tooltip ??
          '',
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(
          AppRadius.md,
        ),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppRadius.md,
            ),
            border: Border.all(
              color: AppColors.grey.withValues(
                alpha: 0.3,
              ),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              asset,
              width: 26,
              height: 26,
            ),
          ),
        ),
      ),
    );
  }
}

/// "OR CONTINUE WITH" divider row.
class OrDivider
    extends
        StatelessWidget {
  const OrDivider({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        const Expanded(
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: Text(
            label,
            style:
                Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(
                  fontSize: 11,
                  letterSpacing: 1.2,
                  color: AppColors.grey,
                ),
          ),
        ),
        const Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}

/// The step indicator shown on register / verify ("1 Create account — 2 Verify").
class AuthStepIndicator
    extends
        StatelessWidget {
  const AuthStepIndicator({
    super.key,
    required this.currentStep,
    required this.stepOneLabel,
    required this.stepTwoLabel,
  });

  /// 1 = create account, 2 = verify email.
  final int currentStep;
  final String stepOneLabel;
  final String stepTwoLabel;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        _Step(
          number: 1,
          label: stepOneLabel,
          isActive:
              currentStep ==
              1,
          isDone:
              currentStep >
              1,
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
            ),
            color: AppColors.grey.withValues(
              alpha: 0.4,
            ),
          ),
        ),
        _Step(
          number: 2,
          label: stepTwoLabel,
          isActive:
              currentStep ==
              2,
          isDone: false,
        ),
      ],
    );
  }
}

class _Step
    extends
        StatelessWidget {
  const _Step({
    required this.number,
    required this.label,
    required this.isActive,
    required this.isDone,
  });

  final int number;
  final String label;
  final bool isActive;
  final bool isDone;

  @override
  Widget build(
    BuildContext context,
  ) {
    final filled =
        isActive ||
        isDone;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled
                ? AppColors.lime
                : AppColors.grey.withValues(
                    alpha: 0.25,
                  ),
          ),
          child: Center(
            child: isDone
                ? SvgPicture.asset(
                    AppAssets.iconCheck,
                    width: 13,
                    height: 13,
                    colorFilter: const ColorFilter.mode(
                      AppColors.charcoal,
                      BlendMode.srcIn,
                    ),
                  )
                : Text(
                    '$number',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: filled
                          ? AppColors.charcoal
                          : AppColors.grey,
                    ),
                  ),
          ),
        ),
        const SizedBox(
          width: AppSpacing.sm,
        ),
        Text(
          label,
          style:
              Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: filled
                    ? AppColors.charcoal
                    : AppColors.grey,
              ),
        ),
      ],
    );
  }
}
