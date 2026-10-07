import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';

/// Shown while the saved session is checked. `app.dart` opens the next
/// screen.
class SplashPage
    extends
        StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.charcoal,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FormLogo(
                color: AppColors.lime,
              ),
              const SizedBox(
                height: AppSpacing.md,
              ),
              Text(
                'TRAIN HARD. LIVE WELL.',
                style:
                    Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(
                      fontSize: 11,
                      letterSpacing: 1.4,
                      color: Colors.white70,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
