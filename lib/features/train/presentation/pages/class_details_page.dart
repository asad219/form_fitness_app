import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/constants/app_dimens.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/core/widgets/form_ui.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:app_boilerplate/features/auth/presentation/widgets/form_brand.dart';
import 'package:flutter/material.dart';

/// Class details: hero, info, day/time picker and reserve CTA.
class ClassDetailsPage
    extends
        StatefulWidget {
  const ClassDetailsPage({
    super.key,
  });

  @override
  State<
    ClassDetailsPage
  >
  createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState
    extends
        State<
          ClassDetailsPage
        > {
  int _selectedDay = 0;
  int _selectedTime = 0;

  static const _days = [
    (
      'WED',
      '07',
    ),
    (
      'THU',
      '08',
    ),
    (
      'FRI',
      '09',
    ),
    (
      'SAT',
      '10',
    ),
    (
      'SUN',
      '11',
    ),
  ];
  static const _times = [
    '7:00 AM',
    '12:30 PM',
    '6:00 PM',
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(
            AppSpacing.xl,
          ),
          children: [
            InsideAppBar(
              title: l10n.classDetailsTitle,
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            const FormImagePlaceholder(
              height: 220,
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Row(
              children: [
                FormTag(
                  l10n.trainTagGroupClass,
                ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  size: 16,
                  color: AppColors.charcoal,
                ),
                const SizedBox(
                  width: AppSpacing.xs,
                ),
                Text(
                  l10n.classRating,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            FormHeadline(
              l10n.trainClassName.toUpperCase(),
              fontSize: 36,
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Text(
              l10n.classDescription,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Row(
              children: [
                _MetaItem(
                  l10n.classDuration,
                ),
                const SizedBox(
                  width: AppSpacing.xl,
                ),
                _MetaItem(
                  l10n.classLevel,
                ),
                const SizedBox(
                  width: AppSpacing.xl,
                ),
                _MetaItem(
                  l10n.classCoach,
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.xxl,
            ),
            SectionTitleRow(
              title: l10n.classPickSession,
              actionLabel: 'October',
              onAction: () {},
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            // Day picker.
            Row(
              children: List.generate(
                _days.length,
                (
                  index,
                ) {
                  final selected =
                      index ==
                      _selectedDay;
                  final (
                    day,
                    date,
                  ) = _days[index];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(
                        () => _selectedDay = index,
                      ),
                      child: Container(
                        margin: EdgeInsetsDirectional.only(
                          end:
                              index <
                                  _days.length -
                                      1
                              ? AppSpacing.sm
                              : 0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.charcoal
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppRadius.md,
                          ),
                          border: Border.all(
                            color: AppColors.grey.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              day,
                              style: context.textTheme.labelLarge?.copyWith(
                                fontSize: 10,
                                letterSpacing: 1,
                                color: selected
                                    ? Colors.white70
                                    : AppColors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: AppSpacing.xs,
                            ),
                            Text(
                              date,
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: selected
                                    ? AppColors.lime
                                    : AppColors.charcoal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            // Time picker.
            Row(
              children: List.generate(
                _times.length,
                (
                  index,
                ) {
                  final selected =
                      index ==
                      _selectedTime;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(
                        () => _selectedTime = index,
                      ),
                      child: Container(
                        margin: EdgeInsetsDirectional.only(
                          end:
                              index <
                                  _times.length -
                                      1
                              ? AppSpacing.sm
                              : 0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.lime
                              : Colors.white,
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
                          child: Text(
                            _times[index],
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.charcoal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  size: 18,
                  color: AppColors.grey,
                ),
                const SizedBox(
                  width: AppSpacing.sm,
                ),
                Expanded(
                  child: Text(
                    l10n.classSpotsLeft(
                      6,
                      'Brooklyn',
                    ),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            // Ticket summary.
            Container(
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
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.grey.withValues(
                          alpha: 0.4,
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.circle_outlined,
                      size: 16,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: AppSpacing.md,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.classTicketLabel,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          l10n.classTicketNote,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    r'$28',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            FormCtaButton(
              label: l10n.classReserveCta(
                r'$28',
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                RoutesName.reservation,
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Center(
              child: Text(
                l10n.classCancelNote,
                style: context.textTheme.bodySmall?.copyWith(
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

class _MetaItem
    extends
        StatelessWidget {
  const _MetaItem(
    this.text,
  );

  final String text;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Text(
      text,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
