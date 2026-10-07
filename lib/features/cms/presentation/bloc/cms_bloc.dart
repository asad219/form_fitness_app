import 'package:app_boilerplate/features/cms/data/models/app_config_model.dart';
import 'package:app_boilerplate/features/cms/data/repositories/cms_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class CmsEvent
    extends
        Equatable {
  const CmsEvent();
  @override
  List<
    Object?
  >
  get props => [];
}

final class CmsLoadRequested
    extends
        CmsEvent {
  const CmsLoadRequested();
}

// States
enum CmsStatus {
  initial,
  loading,
  success,
  failure,
}

final class CmsState
    extends
        Equatable {
  const CmsState({
    this.status = CmsStatus.initial,
    this.config,
  });

  final CmsStatus status;
  final AppConfigModel? config;

  List<
    BannerModel
  >
  get heroBanners =>
      config?.heroBanners ??
      const [];
  List<
    AnnouncementModel
  >
  get announcements =>
      config?.announcements ??
      const [];
  PopupModel? get popup => config?.popup;

  List<
    BannerModel
  >
  promosFor(
    String placement,
  ) =>
      (config?.promoBanners ??
              const [])
          .where(
            (
              b,
            ) =>
                b.placement ==
                placement,
          )
          .toList();

  CmsState copyWith({
    CmsStatus? status,
    AppConfigModel? config,
  }) {
    return CmsState(
      status:
          status ??
          this.status,
      config:
          config ??
          this.config,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    status,
    config,
  ];
}

class CmsBloc
    extends
        Bloc<
          CmsEvent,
          CmsState
        > {
  CmsBloc({
    required this._repository,
  }) : super(
         const CmsState(),
       ) {
    on<
      CmsLoadRequested
    >(
      _onLoad,
    );
  }

  final CmsRepository _repository;

  Future<
    void
  >
  _onLoad(
    CmsLoadRequested event,
    Emitter<
      CmsState
    >
    emit,
  ) async {
    emit(
      state.copyWith(
        status: CmsStatus.loading,
      ),
    );
    final result = await _repository.getAppConfig();
    result.fold(
      (
        failure,
      ) => emit(
        state.copyWith(
          status: CmsStatus.failure,
        ),
      ),
      (
        config,
      ) => emit(
        state.copyWith(
          status: CmsStatus.success,
          config: config,
        ),
      ),
    );
  }
}
