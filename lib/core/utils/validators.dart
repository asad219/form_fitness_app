import 'package:app_boilerplate/l10n/generated/app_localizations.dart';

/// Form validators. They return a translated error, or `null` if valid:
/// `validator: (value) => Validators.email(value, context.l10n)`.
class Validators {
  Validators._();

  static final RegExp _emailRegExp = RegExp(
    r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$',
  );

  static String? required(
    String? value,
    AppLocalizations l10n, {
    String? fieldName,
  }) {
    if (value ==
            null ||
        value.trim().isEmpty) {
      return fieldName ==
              null
          ? l10n.validationFieldRequired
          : l10n.validationRequired(
              fieldName,
            );
    }
    return null;
  }

  static String? email(
    String? value,
    AppLocalizations l10n,
  ) {
    final trimmed =
        value?.trim() ??
        '';
    if (trimmed.isEmpty) return l10n.validationEmailRequired;
    if (!_emailRegExp.hasMatch(
      trimmed,
    )) {
      return l10n.validationEmailInvalid;
    }
    return null;
  }

  static String? password(
    String? value,
    AppLocalizations l10n, {
    int minLength = 6,
  }) {
    if (value ==
            null ||
        value.isEmpty) {
      return l10n.validationPasswordRequired;
    }
    if (value.length <
        minLength) {
      return l10n.validationPasswordTooShort(
        minLength,
      );
    }
    return null;
  }

  /// Registration rule: min 8 chars with upper, lower, number and symbol.
  static String? strongPassword(
    String? value,
    AppLocalizations l10n,
  ) {
    if (value ==
            null ||
        value.isEmpty) {
      return l10n.validationPasswordRequired;
    }
    final strong = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
    );
    if (!strong.hasMatch(
      value,
    )) {
      return l10n.passwordHint;
    }
    return null;
  }
}
