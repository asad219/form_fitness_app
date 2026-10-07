import 'package:app_boilerplate/core/constants/api_endpoints.dart';
import 'package:app_boilerplate/core/error/error_handler.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/features/cms/data/models/app_config_model.dart';

abstract interface class CmsRepository {
  Future<
    Result<
      AppConfigModel
    >
  >
  getAppConfig();
}

class CmsRepositoryImpl
    implements
        CmsRepository {
  const CmsRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<
    Result<
      AppConfigModel
    >
  >
  getAppConfig() {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.appConfig,
          requiresAuth: false,
        );
        return AppConfigModel.fromJson(
          json,
        );
      },
    );
  }
}
