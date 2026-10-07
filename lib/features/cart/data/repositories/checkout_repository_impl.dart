import 'package:app_boilerplate/core/constants/api_endpoints.dart';
import 'package:app_boilerplate/core/error/error_handler.dart';
import 'package:app_boilerplate/core/error/exceptions.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/features/cart/data/models/order_model.dart';

abstract interface class CheckoutRepository {
  Future<
    Result<
      OrderModel
    >
  >
  processCheckout({
    String? paymentMethod,
    String? billingEmail,
  });

  Future<
    Result<
      OrderModel
    >
  >
  getOrder(
    String id,
  );
}

class CheckoutRepositoryImpl
    implements
        CheckoutRepository {
  const CheckoutRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<
    Result<
      OrderModel
    >
  >
  processCheckout({
    String? paymentMethod,
    String? billingEmail,
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.post(
          ApiEndpoints.checkoutProcess,
          body: {
            if (paymentMethod !=
                    null ||
                billingEmail !=
                    null)
              'paymentDetails': {
                'method': ?paymentMethod,
                'billingEmail': ?billingEmail,
              },
          },
          successCodes: const [
            200,
            201,
          ],
        );
        final order = json['order'];
        if (order
            is Map<
              String,
              dynamic
            >) {
          return OrderModel.fromJson(
            json,
          );
        }
        throw const ApiException(
          type: ApiErrorType.unexpected,
        );
      },
    );
  }

  @override
  Future<
    Result<
      OrderModel
    >
  >
  getOrder(
    String id,
  ) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.order(
            id,
          ),
        );
        final order = json['order'];
        if (order
            is Map<
              String,
              dynamic
            >) {
          return OrderModel.fromJson(
            json,
          );
        }
        throw const ApiException(
          type: ApiErrorType.unexpected,
        );
      },
    );
  }
}
