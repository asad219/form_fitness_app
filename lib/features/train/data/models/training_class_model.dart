import 'package:equatable/equatable.dart';

/// A class from `GET /train/classes`.
class TrainingClassModel
    extends
        Equatable {
  const TrainingClassModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.durationMinutes,
    required this.level,
    required this.coachName,
    required this.price,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    required this.includedInMembership,
    required this.cancellationWindowHours,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final int durationMinutes;
  final String level;
  final String coachName;
  final double price;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  final bool includedInMembership;
  final int cancellationWindowHours;

  factory TrainingClassModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    return TrainingClassModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      title:
          json['title']
              as String? ??
          '',
      description:
          json['description']
              as String? ??
          '',
      category:
          json['category']
              as String? ??
          'GROUP_CLASS',
      durationMinutes:
          (json['durationMinutes']
                  as num?)
              ?.toInt() ??
          0,
      level:
          json['level']
              as String? ??
          '',
      coachName:
          json['coachName']
              as String? ??
          '',
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
      imageUrl:
          json['imageUrl']
              as String?,
      includedInMembership:
          json['includedInMembership']
              as bool? ??
          false,
      cancellationWindowHours:
          (json['cancellationWindowHours']
                  as num?)
              ?.toInt() ??
          12,
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

/// A scheduled session of a class. `classId` can be a bare id or a populated
/// [TrainingClassModel].
class ClassSessionModel
    extends
        Equatable {
  const ClassSessionModel({
    required this.id,
    this.classRef,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.totalSpots,
    required this.bookedSpots,
    required this.availableSpots,
    required this.status,
  });

  final String id;
  final TrainingClassModel? classRef;
  final String location;

  /// Date-only, stored as UTC midnight. Display the UTC date as-is.
  final DateTime date;
  final String startTime;
  final String endTime;
  final int totalSpots;
  final int bookedSpots;
  final int availableSpots;
  final String status;

  bool get isBookable =>
      status ==
          'OPEN' &&
      availableSpots >
          0;

  factory ClassSessionModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    // `classId` may be a string id or a populated class object.
    TrainingClassModel? classRef;
    final classIdValue = json['classId'];
    if (classIdValue
        is Map<
          String,
          dynamic
        >) {
      classRef = TrainingClassModel.fromJson(
        classIdValue,
      );
    }

    return ClassSessionModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      classRef: classRef,
      location:
          json['location']
              as String? ??
          '',
      date:
          DateTime.tryParse(
            json['date']
                    as String? ??
                '',
          ) ??
          DateTime.fromMillisecondsSinceEpoch(
            0,
            isUtc: true,
          ),
      startTime:
          json['startTime']
              as String? ??
          '',
      endTime:
          json['endTime']
              as String? ??
          '',
      totalSpots:
          (json['totalSpots']
                  as num?)
              ?.toInt() ??
          0,
      bookedSpots:
          (json['bookedSpots']
                  as num?)
              ?.toInt() ??
          0,
      availableSpots:
          (json['availableSpots']
                  as num?)
              ?.toInt() ??
          0,
      status:
          json['status']
              as String? ??
          'CANCELLED',
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
