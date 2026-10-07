import 'package:app_boilerplate/features/shop/data/models/product_model.dart';
import 'package:app_boilerplate/features/train/data/models/training_class_model.dart';
import 'package:equatable/equatable.dart';

/// A booked class line in the cart. `sessionRef` is null when deleted server-side.
class CartServiceItemModel
    extends
        Equatable {
  const CartServiceItemModel({
    required this.id,
    this.sessionRef,
    required this.attendeesCount,
    required this.price,
  });

  final String id;
  final ClassSessionModel? sessionRef;
  final int attendeesCount;
  final double price;

  factory CartServiceItemModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final session = json['sessionRef'];
    return CartServiceItemModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      sessionRef:
          session
              is Map<
                String,
                dynamic
              >
          ? ClassSessionModel.fromJson(
              session,
            )
          : null,
      attendeesCount:
          (json['attendeesCount']
                  as num?)
              ?.toInt() ??
          1,
      price:
          (json['price']
                  as num?)
              ?.toDouble() ??
          0,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    id,
  ];
}

/// A product line in the cart. `productRef` is null when deleted server-side.
class CartProductItemModel
    extends
        Equatable {
  const CartProductItemModel({
    required this.id,
    this.productRef,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
    required this.fulfillmentMethod,
    required this.price,
  });

  final String id;
  final ProductModel? productRef;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final String fulfillmentMethod;
  final double price;

  factory CartProductItemModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final product = json['productRef'];
    return CartProductItemModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      productRef:
          product
              is Map<
                String,
                dynamic
              >
          ? ProductModel.fromJson(
              product,
            )
          : null,
      quantity:
          (json['quantity']
                  as num?)
              ?.toInt() ??
          1,
      selectedColor:
          json['selectedColor']
              as String?,
      selectedSize:
          json['selectedSize']
              as String?,
      fulfillmentMethod:
          json['fulfillmentMethod']
              as String? ??
          'CLUB_PICKUP',
      price:
          (json['price']
                  as num?)
              ?.toDouble() ??
          0,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    id,
  ];
}

/// The full cart, returned by every cart endpoint.
class CartModel
    extends
        Equatable {
  const CartModel({
    required this.id,
    required this.serviceItems,
    required this.productItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.estimatedTax,
    required this.total,
    this.appliedPromoCode,
    required this.discountAmount,
  });

  final String id;
  final List<
    CartServiceItemModel
  >
  serviceItems;
  final List<
    CartProductItemModel
  >
  productItems;
  final double subtotal;
  final double deliveryFee;
  final double estimatedTax;
  final double total;
  final String? appliedPromoCode;
  final double discountAmount;

  int get itemCount =>
      serviceItems.length +
      productItems.fold<
        int
      >(
        0,
        (
          sum,
          item,
        ) =>
            sum +
            item.quantity,
      );

  bool get isEmpty =>
      serviceItems.isEmpty &&
      productItems.isEmpty;

  factory CartModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final cart =
        json['cart']
            is Map<
              String,
              dynamic
            >
        ? json['cart']
              as Map<
                String,
                dynamic
              >
        : json;

    return CartModel(
      id:
          (cart['_id'] ??
                  cart['id'] ??
                  '')
              .toString(),
      serviceItems:
          cart['serviceItems']
              is List
          ? (cart['serviceItems']
                    as List)
                .whereType<
                  Map<
                    String,
                    dynamic
                  >
                >()
                .map(
                  CartServiceItemModel.fromJson,
                )
                .toList()
          : const [],
      productItems:
          cart['productItems']
              is List
          ? (cart['productItems']
                    as List)
                .whereType<
                  Map<
                    String,
                    dynamic
                  >
                >()
                .map(
                  CartProductItemModel.fromJson,
                )
                .toList()
          : const [],
      subtotal:
          (cart['subtotal']
                  as num?)
              ?.toDouble() ??
          0,
      deliveryFee:
          (cart['deliveryFee']
                  as num?)
              ?.toDouble() ??
          0,
      estimatedTax:
          (cart['estimatedTax']
                  as num?)
              ?.toDouble() ??
          0,
      total:
          (cart['total']
                  as num?)
              ?.toDouble() ??
          0,
      appliedPromoCode:
          cart['appliedPromoCode']
              as String?,
      discountAmount:
          (cart['discountAmount']
                  as num?)
              ?.toDouble() ??
          0,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    id,
  ];
}
