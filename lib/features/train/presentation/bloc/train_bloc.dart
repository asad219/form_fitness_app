import 'package:app_boilerplate/features/train/data/models/training_class_model.dart';
import 'package:app_boilerplate/features/train/data/repositories/train_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class TrainEvent
    extends
        Equatable {
  const TrainEvent();
  @override
  List<
    Object?
  >
  get props => [];
}

final class TrainLoadRequested
    extends
        TrainEvent {
  const TrainLoadRequested({
    this.category,
  });
  final String? category;
  @override
  List<
    Object?
  >
  get props => [
    category,
  ];
}

// States
enum TrainStatus {
  initial,
  loading,
  success,
  failure,
}

final class TrainState
    extends
        Equatable {
  const TrainState({
    this.status = TrainStatus.initial,
    this.classes = const [],
    this.category,
    this.errorMessage,
  });

  final TrainStatus status;
  final List<
    TrainingClassModel
  >
  classes;
  final String? category;
  final String? errorMessage;

  bool get isLoading =>
      status ==
      TrainStatus.loading;

  TrainState copyWith({
    TrainStatus? status,
    List<
      TrainingClassModel
    >?
    classes,
    String? category,
    String? errorMessage,
  }) {
    return TrainState(
      status:
          status ??
          this.status,
      classes:
          classes ??
          this.classes,
      category:
          category ??
          this.category,
      errorMessage: errorMessage,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    status,
    classes,
    category,
    errorMessage,
  ];
}

class TrainBloc
    extends
        Bloc<
          TrainEvent,
          TrainState
        > {
  TrainBloc({
    required this._repository,
  }) : super(
         const TrainState(),
       ) {
    on<
      TrainLoadRequested
    >(
      _onLoad,
    );
  }

  final TrainRepository _repository;

  Future<
    void
  >
  _onLoad(
    TrainLoadRequested event,
    Emitter<
      TrainState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: TrainStatus.loading,
        category: event.category,
      ),
    );
    final result = await _repository.getClasses(
      category: event.category,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: TrainStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (
        classes,
      ) => emit(
        state.copyWith(
          status: TrainStatus.success,
          classes: classes,
        ),
      ),
    );
  }
}
