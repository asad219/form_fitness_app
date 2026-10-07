import 'package:app_boilerplate/features/cart/data/models/order_model.dart';
import 'package:app_boilerplate/features/cart/data/repositories/order_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class OrdersEvent
    extends
        Equatable {
  const OrdersEvent();
  @override
  List<
    Object?
  >
  get props => [];
}

final class OrdersLoadRequested
    extends
        OrdersEvent {
  const OrdersLoadRequested({
    this.paymentStatus,
  });
  final String? paymentStatus;
  @override
  List<
    Object?
  >
  get props => [
    paymentStatus,
  ];
}

final class OrdersLoadMoreRequested
    extends
        OrdersEvent {
  const OrdersLoadMoreRequested();
}

final class OrderDetailRequested
    extends
        OrdersEvent {
  const OrderDetailRequested(
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

final class OrderCancelBookingRequested
    extends
        OrdersEvent {
  const OrderCancelBookingRequested({
    required this.orderId,
    required this.bookingId,
  });
  final String orderId;
  final String bookingId;
  @override
  List<
    Object?
  >
  get props => [
    orderId,
    bookingId,
  ];
}

// States
enum OrdersStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

final class OrdersState
    extends
        Equatable {
  const OrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const [],
    this.page = 0,
    this.totalPages = 1,
    this.paymentStatus,
    this.selectedOrder,
    this.cancellingBookingId,
    this.errorMessage,
    this.actionMessage,
  });

  final OrdersStatus status;
  final List<
    OrderModel
  >
  orders;
  final int page;
  final int totalPages;
  final String? paymentStatus;
  final OrderModel? selectedOrder;
  final String? cancellingBookingId;
  final String? errorMessage;
  final String? actionMessage;

  bool get hasMore =>
      page <
      totalPages;
  bool get isLoading =>
      status ==
      OrdersStatus.loading;
  bool get isLoadingMore =>
      status ==
      OrdersStatus.loadingMore;

  OrdersState copyWith({
    OrdersStatus? status,
    List<
      OrderModel
    >?
    orders,
    int? page,
    int? totalPages,
    String? paymentStatus,
    OrderModel? selectedOrder,
    String? cancellingBookingId,
    bool clearCancelling = false,
    String? errorMessage,
    String? actionMessage,
  }) {
    return OrdersState(
      status:
          status ??
          this.status,
      orders:
          orders ??
          this.orders,
      page:
          page ??
          this.page,
      totalPages:
          totalPages ??
          this.totalPages,
      paymentStatus:
          paymentStatus ??
          this.paymentStatus,
      selectedOrder:
          selectedOrder ??
          this.selectedOrder,
      cancellingBookingId: clearCancelling
          ? null
          : (cancellingBookingId ??
                this.cancellingBookingId),
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
    orders,
    page,
    totalPages,
    paymentStatus,
    selectedOrder,
    cancellingBookingId,
    errorMessage,
    actionMessage,
  ];
}

class OrdersBloc
    extends
        Bloc<
          OrdersEvent,
          OrdersState
        > {
  OrdersBloc({
    required this._repository,
  }) : super(
         const OrdersState(),
       ) {
    on<
      OrdersLoadRequested
    >(
      _onLoad,
    );
    on<
      OrdersLoadMoreRequested
    >(
      _onLoadMore,
    );
    on<
      OrderDetailRequested
    >(
      _onDetail,
    );
    on<
      OrderCancelBookingRequested
    >(
      _onCancelBooking,
    );
  }

  final OrderRepository _repository;

  Future<
    void
  >
  _onLoad(
    OrdersLoadRequested event,
    Emitter<
      OrdersState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: OrdersStatus.loading,
        orders: const [],
        page: 0,
        paymentStatus: event.paymentStatus,
      ),
    );
    final result = await _repository.getOrders(
      page: 1,
      paymentStatus: event.paymentStatus,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: OrdersStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (
        p,
      ) => emit(
        state.copyWith(
          status: OrdersStatus.success,
          orders: p.orders,
          page: p.page,
          totalPages: p.totalPages,
        ),
      ),
    );
  }

  Future<
    void
  >
  _onLoadMore(
    OrdersLoadMoreRequested event,
    Emitter<
      OrdersState
    >
    emit,
  ) async {
    if (!state.hasMore ||
        state.isLoading ||
        state.isLoadingMore)
      return;
    emit(
      state.copyWith(
        status: OrdersStatus.loadingMore,
      ),
    );
    final result = await _repository.getOrders(
      page:
          state.page +
          1,
      paymentStatus: state.paymentStatus,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: OrdersStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (
        p,
      ) => emit(
        state.copyWith(
          status: OrdersStatus.success,
          orders: [
            ...state.orders,
            ...p.orders,
          ],
          page: p.page,
          totalPages: p.totalPages,
        ),
      ),
    );
  }

  Future<
    void
  >
  _onDetail(
    OrderDetailRequested event,
    Emitter<
      OrdersState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: OrdersStatus.loading,
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
          status: OrdersStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (
        order,
      ) => emit(
        state.copyWith(
          status: OrdersStatus.success,
          selectedOrder: order,
        ),
      ),
    );
  }

  Future<
    void
  >
  _onCancelBooking(
    OrderCancelBookingRequested event,
    Emitter<
      OrdersState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        cancellingBookingId: event.bookingId,
      ),
    );
    final result = await _repository.cancelBooking(
      orderId: event.orderId,
      bookingId: event.bookingId,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          clearCancelling: true,
          errorMessage: failure.message,
        ),
      ),
      (
        order,
      ) => emit(
        state.copyWith(
          clearCancelling: true,
          selectedOrder: order,
          actionMessage: 'Booking cancelled',
          orders: [
            for (final o in state.orders)
              if (o.id ==
                  order.id)
                order
              else
                o,
          ],
        ),
      ),
    );
  }
}
