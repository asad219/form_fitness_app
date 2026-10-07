import 'package:equatable/equatable.dart';

/// A membership plan from `GET /memberships/plans` (public).
class MembershipPlanModel
    extends
        Equatable {
  const MembershipPlanModel({
    required this.code,
    required this.name,
    required this.description,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.perks,
  });

  final String code;
  final String name;
  final String description;
  final double monthlyPrice;
  final double yearlyPrice;
  final List<
    String
  >
  perks;

  /// How much a yearly plan saves vs 12 × monthly.
  double get yearlySaving =>
      (monthlyPrice *
          12) -
      yearlyPrice;

  double
  priceFor(
    String billingCycle,
  ) =>
      billingCycle ==
          'YEARLY'
      ? yearlyPrice
      : monthlyPrice;

  factory MembershipPlanModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final prices = json['prices'];
    final pricesMap =
        prices
            is Map<
              String,
              dynamic
            >
        ? prices
        : null;
    return MembershipPlanModel(
      code:
          json['code']
              as String? ??
          'ACTIVE',
      name:
          json['name']
              as String? ??
          '',
      description:
          json['description']
              as String? ??
          '',
      monthlyPrice:
          (pricesMap?['MONTHLY']
                  as num?)
              ?.toDouble() ??
          0,
      yearlyPrice:
          (pricesMap?['YEARLY']
                  as num?)
              ?.toDouble() ??
          0,
      perks:
          json['perks']
              is List
          ? (json['perks']
                    as List)
                .map(
                  (
                    e,
                  ) => e.toString(),
                )
                .toList()
          : const [],
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    code,
  ];
}

/// A user's membership.
class MembershipModel
    extends
        Equatable {
  const MembershipModel({
    required this.id,
    this.userId,
    required this.plan,
    required this.billingCycle,
    required this.price,
    required this.status,
    this.startDate,
    this.endDate,
    this.cancelledAt,
    this.paymentMethod,
    this.billingEmail,
  });

  final String id;
  final String? userId;
  final String plan;
  final String billingCycle;
  final double price;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? cancelledAt;
  final String? paymentMethod;
  final String? billingEmail;

  bool get isActive =>
      status ==
      'ACTIVE';
  bool get isCancelled =>
      status ==
      'CANCELLED';

  /// Days of access remaining (local time), 0 when expired.
  int get daysRemaining {
    final end = endDate;
    if (end ==
        null)
      return 0;
    final diff = end
        .toLocal()
        .difference(
          DateTime.now(),
        )
        .inDays;
    return diff <
            0
        ? 0
        : diff;
  }

  factory MembershipModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final payment = json['paymentDetails'];

    String? userId;
    final rawUser = json['userId'];
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

    return MembershipModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      userId: userId,
      plan:
          json['plan']
              as String? ??
          'ACTIVE',
      billingCycle:
          json['billingCycle']
              as String? ??
          'MONTHLY',
      price:
          (json['price']
                  as num?)
              ?.toDouble() ??
          0,
      status:
          json['status']
              as String? ??
          'EXPIRED',
      startDate: DateTime.tryParse(
        json['startDate']
                as String? ??
            '',
      ),
      endDate: DateTime.tryParse(
        json['endDate']
                as String? ??
            '',
      ),
      cancelledAt: DateTime.tryParse(
        json['cancelledAt']
                as String? ??
            '',
      ),
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
