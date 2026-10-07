import 'package:app_boilerplate/features/cart/data/models/cart_model.dart';
import 'package:app_boilerplate/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class CartEvent
    extends
        Equatable {
  const CartEvent();
  @override
  List<
    Object?
  >
  get props => [];
}

final class CartLoadRequested
    extends
        CartEvent {
  const CartLoadRequested();
}

final class CartAddServiceRequested
    extends
        CartEvent {
  const CartAddServiceRequested({
    required this.sessionId,
    this.attendees = 1,
  });
  final String sessionId;
  final int attendees;
  @override
  List<
    Object?
  >
  get props => [
    sessionId,
    attendees,
  ];
}

final class CartAddProductRequested
    extends
        CartEvent {
  const CartAddProductRequested({
    required this.productId,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
    required this.fulfillmentMethod,
  });
  final String productId;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final String fulfillmentMethod;
  @override
  List<
    Object?
  >
  get props => [
    productId,
    quantity,
    selectedColor,
    selectedSize,
    fulfillmentMethod,
  ];
}

final class CartUpdateProductRequested
    extends
        CartEvent {
  const CartUpdateProductRequested({
    required this.itemId,
    this.quantity,
    this.fulfillmentMethod,
  });
  final String itemId;
  final int? quantity;
  final String? fulfillmentMethod;
  @override
  List<
    Object?
  >
  get props => [
    itemId,
    quantity,
    fulfillmentMethod,
  ];
}

final class CartRemoveItemRequested
    extends
        CartEvent {
  const CartRemoveItemRequested(
    this.itemId,
  );
  final String itemId;
  @override
  List<
    Object?
  >
  get props => [
    itemId,
  ];
}

// States
enum CartStatus {
  initial,
  loading,
  actionInProgress,
  success,
  failure,
}

final class CartState
    extends
        Equatable {
  const CartState({
    this.status = CartStatus.initial,
    this.cart,
    this.errorMessage,
    this.errorStatusCode,
  });

  final CartStatus status;
  final CartModel? cart;
  final String? errorMessage;
  final int? errorStatusCode;

  bool get isLoading =>
      status ==
      CartStatus.loading;
  bool get isBusy =>
      status ==
          CartStatus.loading ||
      status ==
          CartStatus.actionInProgress;
  int get itemCount =>
      cart?.itemCount ??
      0;

  CartState copyWith({
    CartStatus? status,
    CartModel? cart,
    String? errorMessage,
    int? errorStatusCode,
  }) {
    return CartState(
      status:
          status ??
          this.status,
      cart:
          cart ??
          this.cart,
      errorMessage: errorMessage,
      errorStatusCode: errorStatusCode,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    status,
    cart,
    errorMessage,
    errorStatusCode,
  ];
}

class CartBloc
    extends
        Bloc<
          CartEvent,
          CartState
        > {
  CartBloc({
    required this._repository,
  }) : super(
         const CartState(),
       ) {
    on<
      CartLoadRequested
    >(
      _onLoad,
    );
    on<
      CartAddServiceRequested
    >(
      _onAddService,
    );
    on<
      CartAddProductRequested
    >(
      _onAddProduct,
    );
    on<
      CartUpdateProductRequested
    >(
      _onUpdateProduct,
    );
    on<
      CartRemoveItemRequested
    >(
      _onRemoveItem,
    );
  }

  final CartRepository _repository;

  Future<
    void
  >
  _onLoad(
    CartLoadRequested event,
    Emitter<
      CartState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: CartStatus.loading,
      ),
    );
    final result = await _repository.getCart();
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: failure.message,
          errorStatusCode: failure.statusCode,
        ),
      ),
      (
        cart,
      ) => emit(
        state.copyWith(
          status: CartStatus.success,
          cart: cart,
        ),
      ),
    );
  }

  Future<
    void
  >
  _runAction(
    Emitter<
      CartState
    >
    emit,
    Future<
      dynamic
    >
    Function()
    action,
  ) async {
    emit(
      state.copyWith(
        status: CartStatus.actionInProgress,
      ),
    );
    final result = await action();
    if (result.isSuccess) {
      emit(
        state.copyWith(
          status: CartStatus.success,
          cart: result.dataOrNull,
        ),
      );
    } else {
      final failure = result.failureOrNull;
      emit(
        state.copyWith(
          status: CartStatus.success,
          errorMessage: failure?.message,
          errorStatusCode: failure?.statusCode,
        ),
      );
    }
  }

  Future<
    void
  >
  _onAddService(
    CartAddServiceRequested event,
    Emitter<
      CartState
    >
    emit,
  ) => _runAction(
    emit,
    () => _repository.addServiceItem(
      sessionId: event.sessionId,
      attendeesCount: event.attendees,
    ),
  );

  Future<
    void
  >
  _onAddProduct(
    CartAddProductRequested event,
    Emitter<
      CartState
    >
    emit,
  ) => _runAction(
    emit,
    () => _repository.addProductItem(
      productId: event.productId,
      quantity: event.quantity,
      selectedColor: event.selectedColor,
      selectedSize: event.selectedSize,
      fulfillmentMethod: event.fulfillmentMethod,
    ),
  );

  Future<
    void
  >
  _onUpdateProduct(
    CartUpdateProductRequested event,
    Emitter<
      CartState
    >
    emit,
  ) => _runAction(
    emit,
    () => _repository.updateProductItem(
      itemId: event.itemId,
      quantity: event.quantity,
      fulfillmentMethod: event.fulfillmentMethod,
    ),
  );

  Future<
    void
  >
  _onRemoveItem(
    CartRemoveItemRequested event,
    Emitter<
      CartState
    >
    emit,
  ) => _runAction(
    emit,
    () => _repository.removeItem(
      event.itemId,
    ),
  );
}
