import 'package:equatable/equatable.dart';

class UserEntity
    extends
        Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.profilePicUrl,
    this.isVerified = false,
    this.role = 'user',
    this.authProvider = 'LOCAL',
    this.membershipStatus = 'NONE',
  });

  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? profilePicUrl;
  final bool isVerified;
  final String role;
  final String authProvider;
  final String membershipStatus;

  String get fullName {
    final name =
        [
              firstName,
              lastName,
            ]
            .whereType<
              String
            >()
            .where(
              (
                part,
              ) => part.trim().isNotEmpty,
            )
            .join(
              ' ',
            );
    return name.isEmpty
        ? email
        : name;
  }

  @override
  List<
    Object?
  >
  get props => [
    id,
    email,
    firstName,
    lastName,
    phone,
    profilePicUrl,
    isVerified,
    role,
    authProvider,
    membershipStatus,
  ];
}
