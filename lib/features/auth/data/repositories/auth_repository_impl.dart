import 'dart:async';

import 'package:app_boilerplate/core/error/error_handler.dart';
import 'package:app_boilerplate/core/error/exceptions.dart';
import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/core/services/session/session_expired_notifier.dart';
import 'package:app_boilerplate/core/utils/app_logger.dart';
import 'package:app_boilerplate/features/auth/data/datasources/auth_local_ds.dart';
import 'package:app_boilerplate/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:app_boilerplate/features/auth/domain/entities/user_entity.dart';
import 'package:app_boilerplate/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl
    implements
        AuthRepository {
  const AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
    required this._sessionExpiredNotifier,
  });

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final SessionExpiredNotifier _sessionExpiredNotifier;

  @override
  Future<
    Result<
      UserEntity
    >
  >
  login({
    required String email,
    required String password,
  }) {
    return ErrorHandler.guard(
      () async {
        final response = await _remoteDataSource.login(
          email: email,
          password: password,
        );

        final token =
            response.token?.trim() ??
            '';
        if (token.isEmpty) {
          throw const ApiException(
            type: ApiErrorType.unexpected,
          );
        }

        await _localDataSource.saveTokens(
          accessToken: token,
          refreshToken: response.refreshToken,
        );

        try {
          var user = response.user;
          user ??= await _remoteDataSource.getCurrentUser(
            user?.id ??
                '',
          );
          await _localDataSource.cacheUser(
            user,
          );
          _sessionExpiredNotifier.rearm();
          return user;
        } catch (
          _
        ) {
          // Don't keep a half-saved session.
          await _localDataSource.clearSession();
          rethrow;
        }
      },
    );
  }

  @override
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
  }) async {
    // The register response has no session token, so sign in right after.
    final registered = await ErrorHandler.guard(
      () => _remoteDataSource.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      ),
    );
    if (!registered.isSuccess) {
      return Failed(
        registered.failureOrNull!,
      );
    }
    return login(
      email: email,
      password: password,
    );
  }

  @override
  Future<
    Result<
      void
    >
  >
  logout() async {
    return ErrorHandler.guard(
      () async {
        try {
          await _remoteDataSource.logout();
        } finally {
          await _localDataSource.clearSession();
        }
      },
    );
  }

  @override
  Future<
    Result<
      UserEntity?
    >
  >
  getCurrentUser() async {
    return ErrorHandler.guard(
      () async {
        if (!await _localDataSource.hasSession()) return null;

        final cached = await _localDataSource.getCachedUser();
        if (cached !=
            null) {
          // Show the cached user now and refresh it in the background.
          unawaited(
            _refreshProfile(
              cached.id,
            ),
          );
          return cached;
        }

        return null;
      },
    );
  }

  @override
  Future<
    Result<
      String
    >
  >
  sendResetCode(
    String email,
  ) {
    return ErrorHandler.guard(
      () => _remoteDataSource.sendResetCode(
        email,
      ),
    );
  }

  @override
  Future<
    Result<
      bool
    >
  >
  verifyResetCode({
    required String token,
    required String code,
  }) {
    return ErrorHandler.guard(
      () => _remoteDataSource.verifyResetCode(
        token: token,
        code: code,
      ),
    );
  }

  @override
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
  }) {
    return ErrorHandler.guard(
      () => _remoteDataSource.updatePassword(
        email: email,
        password: password,
        token: token,
        code: code,
      ),
    );
  }

  Future<
    void
  >
  _refreshProfile(
    String userId,
  ) async {
    try {
      final user = await _remoteDataSource.getCurrentUser(
        userId,
      );
      await _localDataSource.cacheUser(
        user,
      );
    } catch (
      e
    ) {
      // A 401 here signs the user out through the auth interceptor.
      AppLogger.warning(
        'Background profile refresh failed',
        name: 'AuthRepository',
        error: e,
      );
    }
  }
}
