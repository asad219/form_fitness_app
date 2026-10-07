import 'package:equatable/equatable.dart';

/// A product from `GET /shop/products`.
class ProductModel
    extends
        Equatable {
  const ProductModel({
    required this.id,
    required this.name,
    this.subtitle,
    required this.description,
    required this.category,
    required this.badge,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.colors,
    required this.sizes,
    this.volume,
    required this.features,
    required this.stockQuantity,
    required this.isPickupAvailable,
    this.pickupLocation,
  });

  final String id;
  final String name;
  final String? subtitle;
  final String description;
  final String category;
  final String badge;
  final double price;
  final double rating;
  final int reviewCount;
  final List<
    String
  >
  images;
  final List<
    String
  >
  colors;
  final List<
    String
  >
  sizes;
  final String? volume;
  final List<
    String
  >
  features;
  final int stockQuantity;
  final bool isPickupAvailable;
  final String? pickupLocation;

  bool get isInStock =>
      stockQuantity >
      0;
  bool get hasColors => colors.isNotEmpty;
  bool get hasSizes => sizes.isNotEmpty;
  String? get imageUrl => images.isEmpty
      ? null
      : images.first;

  factory ProductModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final options = json['options'];
    final optionsMap =
        options
            is Map<
              String,
              dynamic
            >
        ? options
        : null;

    return ProductModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      name:
          json['name']
              as String? ??
          '',
      subtitle:
          json['subtitle']
              as String?,
      description:
          json['description']
              as String? ??
          '',
      category:
          json['category']
              as String? ??
          'EQUIPMENT',
      badge:
          json['badge']
              as String? ??
          'NONE',
      price:
          (json['price']
                  as num?)
              ?.toDouble() ??
          0,
      rating:
          (json['rating']
                  as num?)
              ?.toDouble() ??
          0,
      reviewCount:
          (json['reviewCount']
                  as num?)
              ?.toInt() ??
          0,
      images: _stringList(
        json['images'],
      ),
      colors: _stringList(
        optionsMap?['colors'],
      ),
      sizes: _stringList(
        optionsMap?['sizes'],
      ),
      volume:
          optionsMap?['volume']
              as String?,
      features: _stringList(
        json['features'],
      ),
      stockQuantity:
          (json['stockQuantity']
                  as num?)
              ?.toInt() ??
          0,
      isPickupAvailable:
          json['isPickupAvailable']
              as bool? ??
          false,
      pickupLocation:
          json['pickupLocation']
              as String?,
    );
  }

  static List<
    String
  >
  _stringList(
    Object? value,
  ) =>
      value
          is List
      ? value
            .map(
              (
                e,
              ) => e.toString(),
            )
            .toList()
      : const [];

  @override
  List<
    Object?
  >
  get props => [
    id,
  ];
}
