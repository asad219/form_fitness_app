import 'package:app_boilerplate/features/train/data/models/training_class_model.dart';
import 'package:app_boilerplate/features/train/data/repositories/train_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class ClassDetailEvent
    extends
        Equatable {
  const ClassDetailEvent();
  @override
  List<
    Object?
  >
  get props => [];
}

final class ClassDetailLoadRequested
    extends
        ClassDetailEvent {
  const ClassDetailLoadRequested(
    this.classId,
  );
  final String classId;
  @override
  List<
    Object?
  >
  get props => [
    classId,
  ];
}

// States
enum ClassDetailStatus {
  initial,
  loading,
  success,
  failure,
}

final class ClassDetailState
    extends
        Equatable {
  const ClassDetailState({
    this.status = ClassDetailStatus.initial,
    this.trainingClass,
    this.sessions = const [],
    this.errorMessage,
  });

  final ClassDetailStatus status;
  final TrainingClassModel? trainingClass;
  final List<
    ClassSessionModel
  >
  sessions;
  final String? errorMessage;

  bool get isLoading =>
      status ==
      ClassDetailStatus.loading;

  ClassDetailState copyWith({
    ClassDetailStatus? status,
    TrainingClassModel? trainingClass,
    List<
      ClassSessionModel
    >?
    sessions,
    String? errorMessage,
  }) {
    return ClassDetailState(
      status:
          status ??
          this.status,
      trainingClass:
          trainingClass ??
          this.trainingClass,
      sessions:
          sessions ??
          this.sessions,
      errorMessage: errorMessage,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    status,
    trainingClass,
    sessions,
    errorMessage,
  ];
}

class ClassDetailBloc
    extends
        Bloc<
          ClassDetailEvent,
          ClassDetailState
        > {
  ClassDetailBloc({
    required this._repository,
  }) : super(
         const ClassDetailState(),
       ) {
    on<
      ClassDetailLoadRequested
    >(
      _onLoad,
    );
  }

  final TrainRepository _repository;

  Future<
    void
  >
  _onLoad(
    ClassDetailLoadRequested event,
    Emitter<
      ClassDetailState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: ClassDetailStatus.loading,
      ),
    );
    final result = await _repository.getClassDetail(
      event.classId,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: ClassDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (
        detail,
      ) => emit(
        state.copyWith(
          status: ClassDetailStatus.success,
          trainingClass: detail.trainingClass,
          sessions: detail.upcomingSessions,
        ),
      ),
    );
  }
}
