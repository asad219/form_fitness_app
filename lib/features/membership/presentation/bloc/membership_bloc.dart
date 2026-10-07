import 'package:app_boilerplate/features/membership/data/models/membership_model.dart';
import 'package:app_boilerplate/features/membership/data/repositories/membership_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class MembershipEvent
    extends
        Equatable {
  const MembershipEvent();
  @override
  List<
    Object?
  >
  get props => [];
}

final class MembershipLoadRequested
    extends
        MembershipEvent {
  const MembershipLoadRequested();
}

final class MembershipSubscribeRequested
    extends
        MembershipEvent {
  const MembershipSubscribeRequested({
    required this.plan,
    this.billingCycle = 'MONTHLY',
  });
  final String plan;
  final String billingCycle;
  @override
  List<
    Object?
  >
  get props => [
    plan,
    billingCycle,
  ];
}

final class MembershipCancelRequested
    extends
        MembershipEvent {
  const MembershipCancelRequested();
}

// States
enum MembershipStatus {
  initial,
  loading,
  actionInProgress,
  success,
  failure,
}

final class MembershipState
    extends
        Equatable {
  const MembershipState({
    this.status = MembershipStatus.initial,
    this.plans = const [],
    this.membership,
    this.history = const [],
    this.errorMessage,
    this.actionMessage,
  });

  final MembershipStatus status;
  final List<
    MembershipPlanModel
  >
  plans;
  final MembershipModel? membership;
  final List<
    MembershipModel
  >
  history;
  final String? errorMessage;
  final String? actionMessage;

  bool get isLoading =>
      status ==
      MembershipStatus.loading;
  bool get isBusy =>
      status ==
      MembershipStatus.actionInProgress;

  /// Past memberships, excluding the live one.
  List<
    MembershipModel
  >
  get pastHistory {
    final live = membership;
    if (live ==
        null)
      return history;
    return history
        .where(
          (
            m,
          ) =>
              m.id !=
              live.id,
        )
        .toList();
  }

  MembershipState copyWith({
    MembershipStatus? status,
    List<
      MembershipPlanModel
    >?
    plans,
    MembershipModel? membership,
    List<
      MembershipModel
    >?
    history,
    String? errorMessage,
    String? actionMessage,
  }) {
    return MembershipState(
      status:
          status ??
          this.status,
      plans:
          plans ??
          this.plans,
      membership:
          membership ??
          this.membership,
      history:
          history ??
          this.history,
      errorMessage: errorMessage,
      actionMessage: actionMessage,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    status,
    plans,
    membership,
    history,
    errorMessage,
    actionMessage,
  ];
}

class MembershipBloc
    extends
        Bloc<
          MembershipEvent,
          MembershipState
        > {
  MembershipBloc({
    required this._repository,
  }) : super(
         const MembershipState(),
       ) {
    on<
      MembershipLoadRequested
    >(
      _onLoad,
    );
    on<
      MembershipSubscribeRequested
    >(
      _onSubscribe,
    );
    on<
      MembershipCancelRequested
    >(
      _onCancel,
    );
  }

  final MembershipRepository _repository;

  Future<
    void
  >
  _onLoad(
    MembershipLoadRequested event,
    Emitter<
      MembershipState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: MembershipStatus.loading,
      ),
    );
    final plansResult = await _repository.getPlans();
    final myResult = await _repository.getMyMembership();

    if (plansResult.failureOrNull !=
            null &&
        plansResult.dataOrNull ==
            null) {
      emit(
        state.copyWith(
          status: MembershipStatus.failure,
          errorMessage: plansResult.failureOrNull?.message,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: MembershipStatus.success,
        plans:
            plansResult.dataOrNull ??
            state.plans,
        membership: myResult.dataOrNull?.membership,
        history:
            myResult.dataOrNull?.history ??
            const [],
        errorMessage: myResult.failureOrNull?.message,
      ),
    );
  }

  Future<
    void
  >
  _onSubscribe(
    MembershipSubscribeRequested event,
    Emitter<
      MembershipState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: MembershipStatus.actionInProgress,
      ),
    );
    final result = await _repository.subscribe(
      plan: event.plan,
      billingCycle: event.billingCycle,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: MembershipStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (
        membership,
      ) {
        emit(
          state.copyWith(
            status: MembershipStatus.success,
            membership: membership,
            actionMessage: 'Membership activated',
          ),
        );
        add(
          const MembershipLoadRequested(),
        );
      },
    );
  }

  Future<
    void
  >
  _onCancel(
    MembershipCancelRequested event,
    Emitter<
      MembershipState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: MembershipStatus.actionInProgress,
      ),
    );
    final result = await _repository.cancel();
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: MembershipStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (
        membership,
      ) {
        emit(
          state.copyWith(
            status: MembershipStatus.success,
            membership: membership,
            actionMessage: 'Membership cancelled',
          ),
        );
        add(
          const MembershipLoadRequested(),
        );
      },
    );
  }
}
