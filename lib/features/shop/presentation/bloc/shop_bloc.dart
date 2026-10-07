import 'package:app_boilerplate/features/shop/data/models/product_model.dart';
import 'package:app_boilerplate/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class ShopEvent
    extends
        Equatable {
  const ShopEvent();
  @override
  List<
    Object?
  >
  get props => [];
}

final class ShopLoadRequested
    extends
        ShopEvent {
  const ShopLoadRequested({
    this.category,
    this.search,
  });
  final String? category;
  final String? search;
  @override
  List<
    Object?
  >
  get props => [
    category,
    search,
  ];
}

final class ShopLoadMoreRequested
    extends
        ShopEvent {
  const ShopLoadMoreRequested();
}

// States
enum ShopStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

final class ShopState
    extends
        Equatable {
  const ShopState({
    this.status = ShopStatus.initial,
    this.products = const [],
    this.page = 0,
    this.totalPages = 1,
    this.category,
    this.search,
    this.errorMessage,
  });

  final ShopStatus status;
  final List<
    ProductModel
  >
  products;
  final int page;
  final int totalPages;
  final String? category;
  final String? search;
  final String? errorMessage;

  bool get hasMore =>
      page <
      totalPages;
  bool get isLoading =>
      status ==
      ShopStatus.loading;
  bool get isLoadingMore =>
      status ==
      ShopStatus.loadingMore;

  ShopState copyWith({
    ShopStatus? status,
    List<
      ProductModel
    >?
    products,
    int? page,
    int? totalPages,
    String? category,
    String? search,
    String? errorMessage,
  }) {
    return ShopState(
      status:
          status ??
          this.status,
      products:
          products ??
          this.products,
      page:
          page ??
          this.page,
      totalPages:
          totalPages ??
          this.totalPages,
      category:
          category ??
          this.category,
      search:
          search ??
          this.search,
      errorMessage: errorMessage,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    status,
    products,
    page,
    totalPages,
    category,
    search,
    errorMessage,
  ];
}

class ShopBloc
    extends
        Bloc<
          ShopEvent,
          ShopState
        > {
  ShopBloc({
    required this._repository,
  }) : super(
         const ShopState(),
       ) {
    on<
      ShopLoadRequested
    >(
      _onLoad,
    );
    on<
      ShopLoadMoreRequested
    >(
      _onLoadMore,
    );
  }

  final ShopRepository _repository;

  Future<
    void
  >
  _onLoad(
    ShopLoadRequested event,
    Emitter<
      ShopState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: ShopStatus.loading,
        products: const [],
        page: 0,
        category: event.category,
        search: event.search,
      ),
    );
    final result = await _repository.getProducts(
      page: 1,
      category: event.category,
      search: event.search,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: ShopStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (
        page,
      ) => emit(
        state.copyWith(
          status: ShopStatus.success,
          products: page.products,
          page: page.page,
          totalPages: page.totalPages,
        ),
      ),
    );
  }

  Future<
    void
  >
  _onLoadMore(
    ShopLoadMoreRequested event,
    Emitter<
      ShopState
    >
    emit,
  ) async {
    if (!state.hasMore ||
        state.isLoading ||
        state.isLoadingMore) {
      return;
    }
    emit(
      state.copyWith(
        status: ShopStatus.loadingMore,
      ),
    );

    final result = await _repository.getProducts(
      page:
          state.page +
          1,
      category: state.category,
      search: state.search,
    );
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: ShopStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (
        page,
      ) => emit(
        state.copyWith(
          status: ShopStatus.success,
          products: [
            ...state.products,
            ...page.products,
          ],
          page: page.page,
          totalPages: page.totalPages,
        ),
      ),
    );
  }
}
