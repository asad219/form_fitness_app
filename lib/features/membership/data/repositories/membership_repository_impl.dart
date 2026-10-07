import 'package:app_boilerplate/core/constants/api_endpoints.dart';
import 'package:app_boilerplate/core/error/error_handler.dart';
import 'package:app_boilerplate/core/error/exceptions.dart';
import 'package:app_boilerplate/core/network/api_client.dart';
import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/features/membership/data/models/membership_model.dart';

/// Result of `GET /memberships/me`.
class MyMembershipResult {
  const MyMembershipResult({
    this.membership,
    this.history = const [],
  });

  /// The live membership, or null.
  final MembershipModel? membership;

  /// All memberships, newest first (includes the live one).
  final List<
    MembershipModel
  >
  history;
}

abstract interface class MembershipRepository {
  Future<
    Result<
      List<
        MembershipPlanModel
      >
    >
  >
  getPlans();

  Future<
    Result<
      MyMembershipResult
    >
  >
  getMyMembership();

  Future<
    Result<
      MembershipModel
    >
  >
  subscribe({
    required String plan,
    String billingCycle = 'MONTHLY',
  });

  Future<
    Result<
      MembershipModel
    >
  >
  cancel();
}

class MembershipRepositoryImpl
    implements
        MembershipRepository {
  const MembershipRepositoryImpl(
    this._apiClient,
  );

  final ApiClient _apiClient;

  @override
  Future<
    Result<
      List<
        MembershipPlanModel
      >
    >
  >
  getPlans() {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.membershipPlans,
          requiresAuth: false,
        );
        return json['plans']
                is List
            ? (json['plans']
                      as List)
                  .whereType<
                    Map<
                      String,
                      dynamic
                    >
                  >()
                  .map(
                    MembershipPlanModel.fromJson,
                  )
                  .toList()
            : const <
                MembershipPlanModel
              >[];
      },
    );
  }

  @override
  Future<
    Result<
      MyMembershipResult
    >
  >
  getMyMembership() {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.get(
          ApiEndpoints.myMembership,
        );
        final membership = json['membership'];
        final history =
            json['history']
                is List
            ? (json['history']
                      as List)
                  .whereType<
                    Map<
                      String,
                      dynamic
                    >
                  >()
                  .map(
                    MembershipModel.fromJson,
                  )
                  .toList()
            : const <
                MembershipModel
              >[];

        return MyMembershipResult(
          membership:
              membership
                  is Map<
                    String,
                    dynamic
                  >
              ? MembershipModel.fromJson(
                  membership,
                )
              : null,
          history: history,
        );
      },
    );
  }

  @override
  Future<
    Result<
      MembershipModel
    >
  >
  subscribe({
    required String plan,
    String billingCycle = 'MONTHLY',
  }) {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.post(
          ApiEndpoints.subscribeMembership,
          body: {
            'plan': plan,
            'billingCycle': billingCycle,
          },
          successCodes: const [
            200,
            201,
          ],
        );
        final membership = json['membership'];
        if (membership
            is Map<
              String,
              dynamic
            >) {
          return MembershipModel.fromJson(
            membership,
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
      MembershipModel
    >
  >
  cancel() {
    return ErrorHandler.guard(
      () async {
        final json = await _apiClient.post(
          ApiEndpoints.cancelMembership,
        );
        final membership = json['membership'];
        if (membership
            is Map<
              String,
              dynamic
            >) {
          return MembershipModel.fromJson(
            membership,
          );
        }
        throw const ApiException(
          type: ApiErrorType.unexpected,
        );
      },
    );
  }
}
