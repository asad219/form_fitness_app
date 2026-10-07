import 'package:app_boilerplate/core/constants/api_endpoints.dart';
import 'package:app_boilerplate/core/error/error_handler.dart';
import 'package:app_boilerplate/core/error/exceptions.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/features/train/data/models/training_class_model.dart';

/// Class detail with its upcoming sessions.
class ClassDetailResult {
  const ClassDetailResult({
    required this.trainingClass,
    required this.upcomingSessions,
  });

  final TrainingClassModel trainingClass;
  final List<
    ClassSessionModel
  >
  upcomingSessions;
}

abstract interface class TrainRepository {
  Future<
    Result<
      List<
        TrainingClassModel
      >
    >
  >
  getClasses({
    String? category,
  });

  Future<
    Result<
      ClassDetailResult
    >
  >
  getClassDetail(
    String id,
  );

  Future<
    Result<
      List<
        ClassSessionModel
      >
    >
  >
  getSessions(
    DateTime date,
  );
}

class TrainRepositoryImpl
    implements
        TrainRepository {
  const TrainRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<
    Result<
      List<
        TrainingClassModel
      >
    >
  >
  getClasses({
    String? category,
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.classes,
          queryParameters: {
            if (category !=
                    null &&
                category.isNotEmpty)
              'category': category,
          },
          requiresAuth: false,
        );
        return json['classes']
                is List
            ? (json['classes']
                      as List)
                  .whereType<
                    Map<
                      String,
                      dynamic
                    >
                  >()
                  .map(
                    TrainingClassModel.fromJson,
                  )
                  .toList()
            : const <
                TrainingClassModel
              >[];
      },
    );
  }

  @override
  Future<
    Result<
      ClassDetailResult
    >
  >
  getClassDetail(
    String id,
  ) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.classDetail(
            id,
          ),
          requiresAuth: false,
        );
        final classJson = json['class'];
        if (classJson
            is! Map<
              String,
              dynamic
            >) {
          throw const ApiException(
            type: ApiErrorType.unexpected,
          );
        }
        final sessions =
            json['upcomingSessions']
                is List
            ? (json['upcomingSessions']
                      as List)
                  .whereType<
                    Map<
                      String,
                      dynamic
                    >
                  >()
                  .map(
                    ClassSessionModel.fromJson,
                  )
                  .toList()
            : const <
                ClassSessionModel
              >[];

        return ClassDetailResult(
          trainingClass: TrainingClassModel.fromJson(
            classJson,
          ),
          upcomingSessions: sessions,
        );
      },
    );
  }

  @override
  Future<
    Result<
      List<
        ClassSessionModel
      >
    >
  >
  getSessions(
    DateTime date,
  ) {
    return ErrorHandler.guard(
      () async {
        final dateStr =
            '${date.year.toString().padLeft(4, '0')}-'
            '${date.month.toString().padLeft(2, '0')}-'
            '${date.day.toString().padLeft(2, '0')}';
        final json = await _apiClient.get(
          ApiEndpoints.sessions,
          queryParameters: {
            'date': dateStr,
          },
          requiresAuth: false,
        );
        return json['sessions']
                is List
            ? (json['sessions']
                      as List)
                  .whereType<
                    Map<
                      String,
                      dynamic
                    >
                  >()
                  .map(
                    ClassSessionModel.fromJson,
                  )
                  .toList()
            : const <
                ClassSessionModel
              >[];
      },
    );
  }
}
