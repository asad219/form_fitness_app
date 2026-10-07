import 'package:app_boilerplate/features/auth/domain/entities/user_entity.dart';

class UserModel
    extends
        UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.firstName,
    super.lastName,
    super.phone,
    super.profilePicUrl,
    super.isVerified,
    super.role,
    super.authProvider,
    super.membershipStatus,
  });

  factory UserModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    return UserModel(
      // MongoDB returns `_id`.
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      email:
          json['email']
              as String? ??
          '',
      firstName:
          json['firstName']
              as String?,
      lastName:
          json['lastName']
              as String?,
      phone:
          json['phone']
              as String?,
      profilePicUrl:
          json['profilePicUrl']
              as String?,
      isVerified:
          json['isVerified']
              as bool? ??
          false,
      role:
          json['role']
              as String? ??
          'user',
      authProvider:
          json['authProvider']
              as String? ??
          'LOCAL',
      membershipStatus:
          json['membershipStatus']
              as String? ??
          'NONE',
    );
  }

  Map<
    String,
    dynamic
  >
  toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'profilePicUrl': profilePicUrl,
      'isVerified': isVerified,
      'role': role,
      'authProvider': authProvider,
      'membershipStatus': membershipStatus,
    };
  }
}
