import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<
    Result<
      UserEntity
    >
  >
  login({
    required String email,
    required String password,
  });

  /// Register, then sign in. The API has no email-verification step yet, so
  /// the user logs in right after.
  Future<
    Result<
      UserEntity
    >
  >
  register({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? phone,
  });

  /// Always clears the local session, even if the server call fails.
  Future<
    Result<
      void
    >
  >
  logout();

  /// `Success(null)` means there is no stored session.
  Future<
    Result<
      UserEntity?
    >
  >
  getCurrentUser();

  /// Step 1 of the reset flow: emails a 6-digit code, returns the reset token.
  Future<
    Result<
      String
    >
  >
  sendResetCode(
    String email,
  );

  /// Step 2: verifies the code. `Success(true)` means it matches.
  Future<
    Result<
      bool
    >
  >
  verifyResetCode({
    required String token,
    required String code,
  });

  /// Step 3: sets the new password.
  Future<
    Result<
      void
    >
  >
  updatePassword({
    required String email,
    required String password,
    required String token,
    required String code,
  });
}
