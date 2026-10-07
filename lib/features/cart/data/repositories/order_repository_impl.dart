import 'package:app_boilerplate/core/constants/api_endpoints.dart';
import 'package:app_boilerplate/core/error/error_handler.dart';
import 'package:app_boilerplate/core/error/exceptions.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/features/cart/data/models/order_model.dart';

/// Paginated orders result.
class OrderPage {
  const OrderPage({
    required this.orders,
    required this.page,
    required this.totalPages,
    required this.total,
  });

  final List<
    OrderModel
  >
  orders;
  final int page;
  final int totalPages;
  final int total;

  bool get hasMore =>
      page <
      totalPages;
}

abstract interface class OrderRepository {
  Future<
    Result<
      OrderPage
    >
  >
  getOrders({
    int page = 1,
    int limit = 10,
    String? paymentStatus,
  });

  Future<
    Result<
      OrderModel
    >
  >
  getOrder(
    String id,
  );

  Future<
    Result<
      OrderModel
    >
  >
  cancelBooking({
    required String orderId,
    required String bookingId,
  });
}

class OrderRepositoryImpl
    implements
        OrderRepository {
  const OrderRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<
    Result<
      OrderPage
    >
  >
  getOrders({
    int page = 1,
    int limit = 10,
    String? paymentStatus,
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.orders,
          queryParameters: {
            'page': page,
            'limit': limit,
            if (paymentStatus !=
                    null &&
                paymentStatus.isNotEmpty)
              'paymentStatus': paymentStatus,
          },
        );

        final orders =
            json['orders']
                is List
            ? (json['orders']
                      as List)
                  .whereType<
                    Map<
                      String,
                      dynamic
                    >
                  >()
                  .map(
                    OrderModel.fromJson,
                  )
                  .toList()
            : const <
                OrderModel
              >[];

        final pagination = json['pagination'];
        final p =
            pagination
                is Map<
                  String,
                  dynamic
                >
            ? pagination
            : null;

        return OrderPage(
          orders: orders,
          page:
              (p?['page']
                      as num?)
                  ?.toInt() ??
              page,
          totalPages:
              (p?['pages']
                      as num?)
                  ?.toInt() ??
              1,
          total:
              (p?['total']
                      as num?)
                  ?.toInt() ??
              orders.length,
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
          ApiEndpoints.orderById(
            id,
          ),
        );
        final order = json['order'];
        if (order
            is Map<
              String,
              dynamic
            >)
          return OrderModel.fromJson(
            json,
          );
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
  cancelBooking({
    required String orderId,
    required String bookingId,
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.post(
          ApiEndpoints.cancelBooking(
            orderId,
            bookingId,
          ),
        );
        final order = json['order'];
        if (order
            is Map<
              String,
              dynamic
            >)
          return OrderModel.fromJson(
            json,
          );
        throw const ApiException(
          type: ApiErrorType.unexpected,
        );
      },
    );
  }
}
