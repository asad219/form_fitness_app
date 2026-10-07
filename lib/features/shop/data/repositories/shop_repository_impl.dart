import 'package:app_boilerplate/core/constants/api_endpoints.dart';
import 'package:app_boilerplate/core/error/error_handler.dart';
import 'package:app_boilerplate/core/error/exceptions.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/features/shop/data/models/product_model.dart';

/// Paginated product list result.
class ProductPage {
  const ProductPage({
    required this.products,
    required this.page,
    required this.totalPages,
    required this.total,
  });

  final List<
    ProductModel
  >
  products;
  final int page;
  final int totalPages;
  final int total;

  bool get hasMore =>
      page <
      totalPages;
}

abstract interface class ShopRepository {
  Future<
    Result<
      ProductPage
    >
  >
  getProducts({
    int page = 1,
    int limit = 10,
    String? category,
    String? search,
  });

  Future<
    Result<
      ProductModel
    >
  >
  getProduct(
    String id,
  );
}

class ShopRepositoryImpl
    implements
        ShopRepository {
  const ShopRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<
    Result<
      ProductPage
    >
  >
  getProducts({
    int page = 1,
    int limit = 10,
    String? category,
    String? search,
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.products,
          queryParameters: {
            'page': page,
            'limit': limit,
            if (category !=
                    null &&
                category.isNotEmpty)
              'category': category,
            if (search !=
                    null &&
                search.isNotEmpty)
              'search': search,
          },
          requiresAuth: false,
        );

        final products =
            json['products']
                is List
            ? (json['products']
                      as List)
                  .whereType<
                    Map<
                      String,
                      dynamic
                    >
                  >()
                  .map(
                    ProductModel.fromJson,
                  )
                  .toList()
            : const <
                ProductModel
              >[];

        final pagination = json['pagination'];
        final paginationMap =
            pagination
                is Map<
                  String,
                  dynamic
                >
            ? pagination
            : null;

        return ProductPage(
          products: products,
          page:
              (paginationMap?['page']
                      as num?)
                  ?.toInt() ??
              page,
          totalPages:
              (paginationMap?['pages']
                      as num?)
                  ?.toInt() ??
              1,
          total:
              (paginationMap?['total']
                      as num?)
                  ?.toInt() ??
              products.length,
        );
      },
    );
  }

  @override
  Future<
    Result<
      ProductModel
    >
  >
  getProduct(
    String id,
  ) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.product(
            id,
          ),
          requiresAuth: false,
        );
        final product = json['product'];
        if (product
            is Map<
              String,
              dynamic
            >) {
          return ProductModel.fromJson(
            product,
          );
        }
        throw const ApiException(
          type: ApiErrorType.unexpected,
        );
      },
    );
  }
}
