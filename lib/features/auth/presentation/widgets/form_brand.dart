import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The bold "FORM" wordmark shown at the top of auth screens.
class FormLogo
    extends
        StatelessWidget {
  const FormLogo({
    super.key,
    this.color,
  });

  /// Defaults to the brand charcoal color.
  final Color? color;

  @override
  Widget build(
    BuildContext context,
  ) {
    return SvgPicture.asset(
      AppAssets.logo,
      height: 28,
      colorFilter:
          color !=
              null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}

/// Top bar with the logo on the start and a back / skip action on the end.
class AuthHeader
    extends
        StatelessWidget {
  const AuthHeader({
    super.key,
    this.trailing,
    this.onBack,
  });

  /// Shown at the end (e.g. a "Skip" text button).
  final Widget? trailing;

  /// When set, shows a back arrow with this callback.
  final VoidCallback? onBack;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        if (onBack !=
            null)
          _BackButton(
            onPressed: onBack!,
          )
        else
          const FormLogo(),
        const Spacer(),
        ?trailing,
      ],
    );
  }
}

class _BackButton
    extends
        StatelessWidget {
  const _BackButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppAssets.iconArrowLeft,
          width: 18,
          height: 18,
          colorFilter: const ColorFilter.mode(
            AppColors.charcoal,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(
          width: AppSpacing.xs,
        ),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            'Back',
            style:
                Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}

/// Small uppercase caption used above headlines (e.g. "FIND YOUR STRONG").
class FormTagline
    extends
        StatelessWidget {
  const FormTagline(
    this.text, {
    super.key,
    this.color,
  });

  final String text;
  final Color? color;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      text.toUpperCase(),
      style:
          Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(
            fontSize: 11,
            letterSpacing: 1.2,
            color:
                color ??
                AppColors.grey,
          ),
    );
  }
}

/// Big bold condensed headline, e.g. "WELCOME BACK.".
class FormHeadline
    extends
        StatelessWidget {
  const FormHeadline(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
  });

  final String text;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      text,
      style:
          Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(
            fontSize:
                fontSize ??
                40,
            height: 1.05,
            fontWeight: FontWeight.w800,
            color:
                color ??
                AppColors.charcoal,
          ),
    );
  }
}
