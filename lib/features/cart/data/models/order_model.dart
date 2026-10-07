import 'package:equatable/equatable.dart';

/// A booked class inside an order.
class BookedClassModel
    extends
        Equatable {
  const BookedClassModel({
    required this.id,
    this.classId,
    this.sessionId,
    required this.className,
    required this.date,
    required this.timeSlot,
    required this.location,
    required this.coachName,
    this.attendeesCount = 1,
    required this.price,
    this.entryPassToken,
    required this.bookingStatus,
    this.cancelledAt,
  });

  final String id;
  final String? classId;
  final String? sessionId;
  final String className;

  /// Calendar date stored as midnight UTC. Display via [dateLabel] (UTC).
  final String date;
  final String timeSlot;
  final String location;
  final String coachName;
  final int attendeesCount;
  final double price;
  final String? entryPassToken;
  final String bookingStatus;
  final DateTime? cancelledAt;

  bool get isConfirmed =>
      bookingStatus ==
      'CONFIRMED';
  bool get isCancelled =>
      bookingStatus ==
      'CANCELLED';
  bool get isAttended =>
      bookingStatus ==
      'ATTENDED';

  /// The booking's calendar date (UTC midnight, not converted to local).
  DateTime? get dateUtc {
    final parsed = DateTime.tryParse(
      date,
    );
    if (parsed ==
        null)
      return null;
    return DateTime.utc(
      parsed.year,
      parsed.month,
      parsed.day,
    );
  }

  /// YYYY-MM-DD using the UTC date.
  String get dateLabel {
    final d = dateUtc;
    if (d ==
        null)
      return date;
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  /// Whether the class date is today or in the future.
  bool get isUpcoming {
    final d = dateUtc;
    if (d ==
        null)
      return false;
    final now = DateTime.now().toUtc();
    final today = DateTime.utc(
      now.year,
      now.month,
      now.day,
    );
    return !d.isBefore(
      today,
    );
  }

  factory BookedClassModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    return BookedClassModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      classId: json['classId']?.toString(),
      sessionId: json['sessionId']?.toString(),
      className:
          json['className']
              as String? ??
          '',
      date:
          json['date']
              as String? ??
          '',
      timeSlot:
          json['timeSlot']
              as String? ??
          '',
      location:
          json['location']
              as String? ??
          '',
      coachName:
          json['coachName']
              as String? ??
          '',
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
      entryPassToken:
          json['entryPassToken']
              as String?,
      bookingStatus:
          json['bookingStatus']
              as String? ??
          'CONFIRMED',
      cancelledAt: DateTime.tryParse(
        json['cancelledAt']
                as String? ??
            '',
      ),
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

/// A purchased product inside an order.
class PurchasedProductModel
    extends
        Equatable {
  const PurchasedProductModel({
    required this.id,
    this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    this.selectedColor,
    this.selectedSize,
    required this.fulfillmentMethod,
    required this.fulfillmentStatus,
    this.pickupLocation,
  });

  final String id;
  final String? productId;
  final String name;
  final int quantity;
  final double price;
  final String? selectedColor;
  final String? selectedSize;
  final String fulfillmentMethod;
  final String fulfillmentStatus;
  final String? pickupLocation;

  bool get isClubPickup =>
      fulfillmentMethod ==
      'CLUB_PICKUP';

  factory PurchasedProductModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    return PurchasedProductModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      productId: json['productId']?.toString(),
      name:
          json['name']
              as String? ??
          '',
      quantity:
          (json['quantity']
                  as num?)
              ?.toInt() ??
          1,
      price:
          (json['price']
                  as num?)
              ?.toDouble() ??
          0,
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
      fulfillmentStatus:
          json['fulfillmentStatus']
              as String? ??
          '',
      pickupLocation:
          json['pickupLocation']
              as String?,
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

/// A completed order.
class OrderModel
    extends
        Equatable {
  const OrderModel({
    required this.id,
    required this.orderNumber,
    this.userId,
    required this.paymentStatus,
    this.paymentMethod,
    this.billingEmail,
    required this.bookedClasses,
    required this.purchasedProducts,
    required this.subtotal,
    required this.shippingFee,
    required this.tax,
    required this.totalPaid,
    this.createdAt,
  });

  final String id;
  final String orderNumber;
  final String? userId;
  final String paymentStatus;
  final String? paymentMethod;
  final String? billingEmail;
  final List<
    BookedClassModel
  >
  bookedClasses;
  final List<
    PurchasedProductModel
  >
  purchasedProducts;
  final double subtotal;
  final double shippingFee;
  final double tax;
  final double totalPaid;
  final DateTime? createdAt;

  /// "2 classes · 1 product" style summary.
  int get totalItems =>
      bookedClasses.length +
      purchasedProducts.length;

  factory OrderModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final order =
        json['order']
            is Map<
              String,
              dynamic
            >
        ? json['order']
              as Map<
                String,
                dynamic
              >
        : json;
    final payment = order['paymentDetails'];

    // `userId` can be a string or a populated object (admin).
    String? userId;
    final rawUser = order['userId'];
    if (rawUser
        is String) {
      userId = rawUser;
    } else if (rawUser
        is Map<
          String,
          dynamic
        >) {
      userId =
          (rawUser['_id'] ??
                  rawUser['id'])
              ?.toString();
    }

    return OrderModel(
      id:
          (order['_id'] ??
                  order['id'] ??
                  '')
              .toString(),
      orderNumber:
          order['orderNumber']
              as String? ??
          '',
      userId: userId,
      paymentStatus:
          order['paymentStatus']
              as String? ??
          '',
      paymentMethod:
          payment
              is Map<
                String,
                dynamic
              >
          ? payment['method']
                as String?
          : null,
      billingEmail:
          payment
              is Map<
                String,
                dynamic
              >
          ? payment['billingEmail']
                as String?
          : null,
      bookedClasses:
          order['bookedClasses']
              is List
          ? (order['bookedClasses']
                    as List)
                .whereType<
                  Map<
                    String,
                    dynamic
                  >
                >()
                .map(
                  BookedClassModel.fromJson,
                )
                .toList()
          : const [],
      purchasedProducts:
          order['purchasedProducts']
              is List
          ? (order['purchasedProducts']
                    as List)
                .whereType<
                  Map<
                    String,
                    dynamic
                  >
                >()
                .map(
                  PurchasedProductModel.fromJson,
                )
                .toList()
          : const [],
      subtotal:
          (order['subtotal']
                  as num?)
              ?.toDouble() ??
          0,
      shippingFee:
          (order['shippingFee']
                  as num?)
              ?.toDouble() ??
          0,
      tax:
          (order['tax']
                  as num?)
              ?.toDouble() ??
          0,
      totalPaid:
          (order['totalPaid']
                  as num?)
              ?.toDouble() ??
          0,
      createdAt: DateTime.tryParse(
        order['createdAt']
                as String? ??
            '',
      ),
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
