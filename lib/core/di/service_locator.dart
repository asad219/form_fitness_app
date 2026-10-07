import 'package:app_boilerplate/core/localization/locale_cubit.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/network/api_interceptors.dart';
import 'package:app_boilerplate/core/services/analytics/analytics_service.dart';
import 'package:app_boilerplate/core/services/navigation/navigation_service.dart';
import 'package:app_boilerplate/core/services/notification/fcm_token_registrar.dart';
import 'package:app_boilerplate/core/services/notification/local_notification_service.dart';
import 'package:app_boilerplate/core/services/notification/notification_payload_handler.dart';
import 'package:app_boilerplate/core/services/notification/push_notification_service.dart';
import 'package:app_boilerplate/core/services/session/session_expired_notifier.dart';
import 'package:app_boilerplate/core/services/storage/secure_storage_service.dart';
import 'package:app_boilerplate/core/services/storage/secure_token_service.dart';
import 'package:app_boilerplate/core/services/storage/shared_preferences_service.dart';
import 'package:app_boilerplate/core/theme/theme_cubit.dart';
import 'package:app_boilerplate/features/auth/data/datasources/auth_local_ds.dart';
import 'package:app_boilerplate/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:app_boilerplate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_boilerplate/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:app_boilerplate/features/auth/domain/usecases/login_usecase.dart';
import 'package:app_boilerplate/features/auth/domain/usecases/logout_usecase.dart';
import 'package:app_boilerplate/features/auth/domain/usecases/register_usecase.dart';
import 'package:app_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app_boilerplate/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:app_boilerplate/features/cart/data/repositories/checkout_repository_impl.dart';
import 'package:app_boilerplate/features/cart/data/repositories/order_repository_impl.dart';
import 'package:app_boilerplate/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:app_boilerplate/features/cart/presentation/bloc/checkout_bloc.dart';
import 'package:app_boilerplate/features/cart/presentation/bloc/orders_bloc.dart';
import 'package:app_boilerplate/features/cms/data/repositories/cms_repository_impl.dart';
import 'package:app_boilerplate/features/cms/presentation/bloc/cms_bloc.dart';
import 'package:app_boilerplate/features/membership/data/repositories/membership_repository_impl.dart';
import 'package:app_boilerplate/features/membership/presentation/bloc/membership_bloc.dart';
import 'package:app_boilerplate/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:app_boilerplate/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:app_boilerplate/features/train/data/repositories/train_repository_impl.dart';
import 'package:app_boilerplate/features/train/presentation/bloc/class_detail_bloc.dart';
import 'package:app_boilerplate/features/train/presentation/bloc/train_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final GetIt
getIt = GetIt.instance;

/// Registers all dependencies. BLoCs are factories, everything else is a
/// lazy singleton.
Future<
  void
>
setupLocator() async {
  await _registerCore();
  _registerNetwork();
  _registerNotifications();
  _registerAuthFeature();
  _registerContentFeatures();
}

Future<
  void
>
_registerCore() async {
  final prefs = await SharedPreferencesService.create();

  getIt
    ..registerSingleton<
      SharedPreferencesService
    >(
      prefs,
    )
    ..registerLazySingleton<
      SecureStorageService
    >(
      SecureStorageService.new,
    )
    ..registerLazySingleton<
      SecureTokenService
    >(
      () => SecureTokenService(
        getIt<
          SecureStorageService
        >(),
      ),
    )
    ..registerLazySingleton<
      SessionExpiredNotifier
    >(
      SessionExpiredNotifier.new,
      dispose:
          (
            notifier,
          ) => notifier.dispose(),
    )
    ..registerLazySingleton<
      NavigationService
    >(
      NavigationService.new,
    )
    ..registerLazySingleton<
      AnalyticsService
    >(
      AnalyticsService.new,
    )
    ..registerFactory<
      ThemeCubit
    >(
      () => ThemeCubit(
        getIt<
          SharedPreferencesService
        >(),
      ),
    )
    ..registerFactory<
      LocaleCubit
    >(
      () => LocaleCubit(
        getIt<
          SharedPreferencesService
        >(),
      ),
    );
}

void
_registerNetwork() {
  getIt
    ..registerLazySingleton<
      Dio
    >(
      () =>
          Dio(
              ApiClient.defaultOptions,
            )
            ..interceptors.addAll(
              [
                AuthInterceptor(
                  tokenService:
                      getIt<
                        SecureTokenService
                      >(),
                  sessionExpiredNotifier:
                      getIt<
                        SessionExpiredNotifier
                      >(),
                ),
                ErrorInterceptor(),
                if (kDebugMode) LoggingInterceptor(),
              ],
            ),
    )
    ..registerLazySingleton<
      ApiClient
    >(
      () => ApiClient(
        getIt<
          Dio
        >(),
      ),
    );
}

void
_registerNotifications() {
  getIt
    ..registerLazySingleton<
      LocalNotificationService
    >(
      LocalNotificationService.new,
    )
    ..registerLazySingleton<
      NotificationPayloadHandler
    >(
      () => NotificationPayloadHandler(
        getIt<
          NavigationService
        >(),
      ),
    )
    ..registerLazySingleton<
      FcmTokenRegistrar
    >(
      () => FcmTokenRegistrar(
        getIt<
          ApiClient
        >(),
        getIt<
          SecureTokenService
        >(),
      ),
    )
    ..registerLazySingleton<
      PushNotificationService
    >(
      () => PushNotificationService(
        localNotifications:
            getIt<
              LocalNotificationService
            >(),
        payloadHandler:
            getIt<
              NotificationPayloadHandler
            >(),
        tokenRegistrar:
            getIt<
              FcmTokenRegistrar
            >(),
        prefs:
            getIt<
              SharedPreferencesService
            >(),
      ),
      dispose:
          (
            service,
          ) => service.dispose(),
    );
}

void
_registerAuthFeature() {
  getIt
    // Data sources
    ..registerLazySingleton<
      AuthRemoteDataSource
    >(
      () => AuthRemoteDataSourceImpl(
        getIt<
          ApiClient
        >(),
      ),
    )
    ..registerLazySingleton<
      AuthLocalDataSource
    >(
      () => AuthLocalDataSourceImpl(
        tokenService:
            getIt<
              SecureTokenService
            >(),
        prefs:
            getIt<
              SharedPreferencesService
            >(),
      ),
    )
    // Repositories
    ..registerLazySingleton<
      AuthRepository
    >(
      () => AuthRepositoryImpl(
        remoteDataSource:
            getIt<
              AuthRemoteDataSource
            >(),
        localDataSource:
            getIt<
              AuthLocalDataSource
            >(),
        sessionExpiredNotifier:
            getIt<
              SessionExpiredNotifier
            >(),
      ),
    )
    // Use cases
    ..registerLazySingleton<
      LoginUseCase
    >(
      () => LoginUseCase(
        getIt<
          AuthRepository
        >(),
      ),
    )
    ..registerLazySingleton<
      LogoutUseCase
    >(
      () => LogoutUseCase(
        getIt<
          AuthRepository
        >(),
      ),
    )
    ..registerLazySingleton<
      RegisterUseCase
    >(
      () => RegisterUseCase(
        getIt<
          AuthRepository
        >(),
      ),
    )
    ..registerLazySingleton<
      GetCurrentUserUseCase
    >(
      () => GetCurrentUserUseCase(
        getIt<
          AuthRepository
        >(),
      ),
    )
    // BLoCs
    ..registerFactory<
      AuthBloc
    >(
      () => AuthBloc(
        loginUseCase:
            getIt<
              LoginUseCase
            >(),
        registerUseCase:
            getIt<
              RegisterUseCase
            >(),
        logoutUseCase:
            getIt<
              LogoutUseCase
            >(),
        getCurrentUserUseCase:
            getIt<
              GetCurrentUserUseCase
            >(),
        sessionExpiredNotifier:
            getIt<
              SessionExpiredNotifier
            >(),
      ),
    );
}

void
_registerContentFeatures() {
  getIt
    // Repositories
    ..registerLazySingleton<
      CmsRepository
    >(
      () => CmsRepositoryImpl(
        getIt<
          ApiClient
        >(),
      ),
    )
    ..registerLazySingleton<
      ShopRepository
    >(
      () => ShopRepositoryImpl(
        getIt<
          ApiClient
        >(),
      ),
    )
    ..registerLazySingleton<
      TrainRepository
    >(
      () => TrainRepositoryImpl(
        getIt<
          ApiClient
        >(),
      ),
    )
    ..registerLazySingleton<
      CartRepository
    >(
      () => CartRepositoryImpl(
        getIt<
          ApiClient
        >(),
      ),
    )
    ..registerLazySingleton<
      CheckoutRepository
    >(
      () => CheckoutRepositoryImpl(
        getIt<
          ApiClient
        >(),
      ),
    )
    ..registerLazySingleton<
      OrderRepository
    >(
      () => OrderRepositoryImpl(
        getIt<
          ApiClient
        >(),
      ),
    )
    ..registerLazySingleton<
      MembershipRepository
    >(
      () => MembershipRepositoryImpl(
        getIt<
          ApiClient
        >(),
      ),
    )
    // BLoCs
    ..registerFactory<
      CmsBloc
    >(
      () => CmsBloc(
        repository:
            getIt<
              CmsRepository
            >(),
      ),
    )
    ..registerFactory<
      ShopBloc
    >(
      () => ShopBloc(
        repository:
            getIt<
              ShopRepository
            >(),
      ),
    )
    ..registerFactory<
      TrainBloc
    >(
      () => TrainBloc(
        repository:
            getIt<
              TrainRepository
            >(),
      ),
    )
    ..registerFactory<
      ClassDetailBloc
    >(
      () => ClassDetailBloc(
        repository:
            getIt<
              TrainRepository
            >(),
      ),
    )
    ..registerSingleton<
      CartBloc
    >(
      CartBloc(
        repository:
            getIt<
              CartRepository
            >(),
      ),
      dispose:
          (
            bloc,
          ) => bloc.close(),
    )
    ..registerFactory<
      CheckoutBloc
    >(
      () => CheckoutBloc(
        repository:
            getIt<
              CheckoutRepository
            >(),
      ),
    )
    ..registerFactory<
      OrdersBloc
    >(
      () => OrdersBloc(
        repository:
            getIt<
              OrderRepository
            >(),
      ),
    )
    ..registerFactory<
      MembershipBloc
    >(
      () => MembershipBloc(
        repository:
            getIt<
              MembershipRepository
            >(),
      ),
    );
}
