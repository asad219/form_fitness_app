import 'package:app_boilerplate/core/network/result.dart';
import 'package:app_boilerplate/core/usecase/usecase.dart';
import 'package:app_boilerplate/features/auth/domain/entities/user_entity.dart';
import 'package:app_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase
    implements
        UseCase<
          UserEntity,
          RegisterParams
        > {
  const RegisterUseCase(
    this._repository,
  );

  final AuthRepository _repository;

  @override
  Future<
    Result<
      UserEntity
    >
  >
  call(
    RegisterParams params,
  ) {
    return _repository.register(
      email: params.email.trim(),
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

class RegisterParams
    extends
        Equatable {
  const RegisterParams({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
  });

  final String email;
  final String password;
  final String? firstName;
  final String? lastName;

  @override
  List<
    Object?
  >
  get props => [
    email,
    password,
    firstName,
    lastName,
  ];
}
