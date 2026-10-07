import 'package:app_boilerplate/core/constants/api_endpoints.dart';
import 'package:app_boilerplate/core/error/error_handler.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/features/cart/data/models/cart_model.dart';

abstract interface class CartRepository {
  Future<
    Result<
      CartModel
    >
  >
  getCart();

  Future<
    Result<
      CartModel
    >
  >
  addServiceItem({
    required String sessionId,
    int attendeesCount = 1,
  });

  Future<
    Result<
      CartModel
    >
  >
  addProductItem({
    required String productId,
    required int quantity,
    String? selectedColor,
    String? selectedSize,
    required String fulfillmentMethod,
  });

  Future<
    Result<
      CartModel
    >
  >
  updateProductItem({
    required String itemId,
    int? quantity,
    String? fulfillmentMethod,
  });

  Future<
    Result<
      CartModel
    >
  >
  removeItem(
    String itemId,
  );
}

class CartRepositoryImpl
    implements
        CartRepository {
  const CartRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<
    Result<
      CartModel
    >
  >
  getCart() {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.cart,
        );
        return CartModel.fromJson(
          json,
        );
      },
    );
  }

  @override
  Future<
    Result<
      CartModel
    >
  >
  addServiceItem({
    required String sessionId,
    int attendeesCount = 1,
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.post(
          ApiEndpoints.cartServiceItems,
          body: {
            'sessionId': sessionId,
            'attendeesCount': attendeesCount,
          },
          successCodes: const [
            200,
            201,
          ],
        );
        return CartModel.fromJson(
          json,
        );
      },
    );
  }

  @override
  Future<
    Result<
      CartModel
    >
  >
  addProductItem({
    required String productId,
    required int quantity,
    String? selectedColor,
    String? selectedSize,
    required String fulfillmentMethod,
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.post(
          ApiEndpoints.cartProductItems,
          body: {
            'productId': productId,
            'quantity': quantity,
            'selectedColor': ?selectedColor,
            'selectedSize': ?selectedSize,
            'fulfillmentMethod': fulfillmentMethod,
          },
          successCodes: const [
            200,
            201,
          ],
        );
        return CartModel.fromJson(
          json,
        );
      },
    );
  }

  @override
  Future<
    Result<
      CartModel
    >
  >
  updateProductItem({
    required String itemId,
    int? quantity,
    String? fulfillmentMethod,
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.patch(
          ApiEndpoints.cartItem(
            itemId,
          ),
          body: {
            'quantity': ?quantity,
            'fulfillmentMethod': ?fulfillmentMethod,
          },
        );
        return CartModel.fromJson(
          json,
        );
      },
    );
  }

  @override
  Future<
    Result<
      CartModel
    >
  >
  removeItem(
    String itemId,
  ) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.delete(
          ApiEndpoints.cartItem(
            itemId,
          ),
        );
        return CartModel.fromJson(
          json,
        );
      },
    );
  }
}
