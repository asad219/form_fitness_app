import 'package:app_boilerplate/features/cart/data/models/order_model.dart';
import 'package:app_boilerplate/features/cart/data/repositories/checkout_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class CheckoutEvent
    extends
        Equatable {
  const CheckoutEvent();
  @override
  List<
    Object?
  >
  get props => [];
}

final class CheckoutProcessRequested
    extends
        CheckoutEvent {
  const CheckoutProcessRequested();
}

final class CheckoutOrderLoaded
    extends
        CheckoutEvent {
  const CheckoutOrderLoaded(
    this.orderId,
  );
  final String orderId;
  @override
  List<
    Object?
  >
  get props => [
    orderId,
  ];
}

// States
enum CheckoutStatus {
  initial,
  processing,
  success,
  failure,
  conflict,
}

final class CheckoutState
    extends
        Equatable {
  const CheckoutState({
    this.status = CheckoutStatus.initial,
    this.order,
    this.errorMessage,
  });

  final CheckoutStatus status;
  final OrderModel? order;
  final String? errorMessage;

  bool get isProcessing =>
      status ==
      CheckoutStatus.processing;

  CheckoutState copyWith({
    CheckoutStatus? status,
    OrderModel? order,
    String? errorMessage,
  }) {
    return CheckoutState(
      status:
          status ??
          this.status,
      order:
          order ??
          this.order,
      errorMessage: errorMessage,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    status,
    order,
    errorMessage,
  ];
}

class CheckoutBloc
    extends
        Bloc<
          CheckoutEvent,
          CheckoutState
        > {
  CheckoutBloc({
    required this._repository,
  }) : super(
         const CheckoutState(),
       ) {
    on<
      CheckoutProcessRequested
    >(
      _onProcess,
    );
    on<
      CheckoutOrderLoaded
    >(
      _onLoadOrder,
    );
  }

  final CheckoutRepository _repository;

  Future<
    void
  >
  _onProcess(
    CheckoutProcessRequested event,
    Emitter<
      CheckoutState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: CheckoutStatus.processing,
      ),
    );
    final result = await _repository.processCheckout();
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status:
              failure.statusCode ==
                  409
              ? CheckoutStatus.conflict
              : CheckoutStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (
        order,
      ) => emit(
        state.copyWith(
          status: CheckoutStatus.success,
          order: order,
        ),
      ),
    );
  }

  Future<
    void
  >
  _onLoadOrder(
    CheckoutOrderLoaded event,
    Emitter<
      CheckoutState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: CheckoutStatus.processing,
      ),
    );
    final result = await _repository.getOrder(
      event.orderId,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: CheckoutStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (
        order,
      ) => emit(
        state.copyWith(
          status: CheckoutStatus.success,
          order: order,
        ),
      ),
    );
  }
}
