import 'package:app_boilerplate/core/constants/api_endpoints.dart';
import 'package:app_boilerplate/core/error/exceptions.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/utils/app_logger.dart';
import 'package:app_boilerplate/features/auth/data/models/login_response_model.dart';
import 'package:app_boilerplate/features/auth/data/models/user_model.dart';

/// Throws [ApiException] on failure.
abstract interface class AuthRemoteDataSource {
  Future<
    LoginResponseModel
  >
  login({
    required String email,
    required String password,
  });

  Future<
    LoginResponseModel
  >
  register({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? phone,
  });

  Future<
    void
  >
  logout();

  Future<
    UserModel
  >
  getCurrentUser(
    String userId,
  );

  Future<
    String
  >
  sendResetCode(
    String email,
  );

  Future<
    bool
  >
  verifyResetCode({
    required String token,
    required String code,
  });

  Future<
    void
  >
  updatePassword({
    required String email,
    required String password,
    required String token,
    required String code,
  });
}

class AuthRemoteDataSourceImpl
    implements
        AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<
    LoginResponseModel
  >
  login({
    required String email,
    required String password,
  }) async {
    final json = await _apiClient.post(
      ApiEndpoints.login,
      body: {
        'email': email,
        'password': password,
      },
      requiresAuth: false,
    );
    return LoginResponseModel.fromJson(
      json,
    );
  }

  @override
  Future<
    LoginResponseModel
  >
  register({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    final json = await _apiClient.post(
      ApiEndpoints.register,
      body: {
        'email': email,
        'password': password,
        'firstName': ?firstName,
        'lastName': ?lastName,
        'phone': ?phone,
      },
      requiresAuth: false,
      successCodes: const [
        200,
        201,
      ],
    );
    return LoginResponseModel.fromJson(
      json,
    );
  }

  @override
  Future<
    void
  >
  logout() async {
    try {
      await _apiClient.post(
        ApiEndpoints.logout,
      );
    } catch (
      error,
      stackTrace
    ) {
      AppLogger.warning(
        'Server sign-out failed; local session will still be cleared',
        name: 'AuthRemoteDataSource.logout',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<
    UserModel
  >
  getCurrentUser(
    String userId,
  ) async {
    final json = await _apiClient.get(
      ApiEndpoints.user(
        userId,
      ),
    );

    // The user can be under `user`, under `data`, or at the top level.
    final nested =
        json['user'] ??
        json['data'];
    if (nested
        is Map<
          String,
          dynamic
        >) {
      return UserModel.fromJson(
        nested,
      );
    }
    return UserModel.fromJson(
      json,
    );
  }

  @override
  Future<
    String
  >
  sendResetCode(
    String email,
  ) async {
    final json = await _apiClient.post(
      ApiEndpoints.sendResetCode,
      body: {
        'email': email,
      },
      requiresAuth: false,
    );
    final token =
        (json['token'] ??
                json['data']?['token'])
            as String?;
    if (token ==
            null ||
        token.isEmpty) {
      throw const ApiException(
        type: ApiErrorType.unexpected,
      );
    }
    return token;
  }

  @override
  Future<
    bool
  >
  verifyResetCode({
    required String token,
    required String code,
  }) async {
    final json = await _apiClient.post(
      ApiEndpoints.verifyResetCode,
      body: {
        'token': token,
        'code': code,
      },
      requiresAuth: false,
    );
    return json['verified']
            as bool? ??
        false;
  }

  @override
  Future<
    void
  >
  updatePassword({
    required String email,
    required String password,
    required String token,
    required String code,
  }) async {
    await _apiClient.post(
      ApiEndpoints.updatePassword,
      body: {
        'email': email,
        'password': password,
        'token': token,
        'code': code,
      },
      requiresAuth: false,
    );
  }
}
