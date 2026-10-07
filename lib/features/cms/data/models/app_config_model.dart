import 'package:equatable/equatable.dart';

/// A promotional banner from the CMS.
class BannerModel
    extends
        Equatable {
  const BannerModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    required this.placement,
    this.ctaText,
    this.targetRoute,
    this.targetParams,
    required this.sortOrder,
  });

  final String id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String placement;
  final String? ctaText;
  final String? targetRoute;
  final Map<
    String,
    dynamic
  >?
  targetParams;
  final int sortOrder;

  factory BannerModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    return BannerModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      title:
          json['title']
              as String? ??
          '',
      subtitle:
          json['subtitle']
              as String?,
      imageUrl:
          json['imageUrl']
              as String?,
      placement:
          json['placement']
              as String? ??
          'HOME_HERO',
      ctaText:
          json['ctaText']
              as String?,
      targetRoute:
          json['targetRoute']
              as String?,
      targetParams:
          json['targetParams']
              is Map<
                String,
                dynamic
              >
          ? json['targetParams']
                as Map<
                  String,
                  dynamic
                >
          : null,
      sortOrder:
          (json['sortOrder']
                  as num?)
              ?.toInt() ??
          0,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    id,
  ];
}

/// A dismissible announcement bar.
class AnnouncementModel
    extends
        Equatable {
  const AnnouncementModel({
    required this.id,
    required this.message,
    required this.level,
    this.targetRoute,
    this.targetParams,
  });

  final String id;
  final String message;
  final String level;
  final String? targetRoute;
  final Map<
    String,
    dynamic
  >?
  targetParams;

  factory AnnouncementModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    return AnnouncementModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      message:
          json['message']
              as String? ??
          '',
      level:
          json['level']
              as String? ??
          'INFO',
      targetRoute:
          json['targetRoute']
              as String?,
      targetParams:
          json['targetParams']
              is Map<
                String,
                dynamic
              >
          ? json['targetParams']
                as Map<
                  String,
                  dynamic
                >
          : null,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    id,
  ];
}

/// A popup shown over the home screen.
class PopupModel
    extends
        Equatable {
  const PopupModel({
    required this.id,
    required this.title,
    required this.contentHtml,
    this.imageUrl,
    this.actionLabel,
    this.actionRoute,
    this.actionParams,
    required this.dismissible,
    required this.maxDisplayCount,
  });

  final String id;
  final String title;
  final String contentHtml;
  final String? imageUrl;
  final String? actionLabel;
  final String? actionRoute;
  final Map<
    String,
    dynamic
  >?
  actionParams;
  final bool dismissible;
  final int maxDisplayCount;

  factory PopupModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final action = json['actionButton'];
    return PopupModel(
      id:
          (json['_id'] ??
                  json['id'] ??
                  '')
              .toString(),
      title:
          json['title']
              as String? ??
          '',
      contentHtml:
          json['contentHtml']
              as String? ??
          '',
      imageUrl:
          json['imageUrl']
              as String?,
      actionLabel:
          action
              is Map<
                String,
                dynamic
              >
          ? action['label']
                as String?
          : null,
      actionRoute:
          action
              is Map<
                String,
                dynamic
              >
          ? action['targetRoute']
                as String?
          : null,
      actionParams:
          action
              is Map<
                String,
                dynamic
              >
          ? action['targetParams']
                as Map<
                  String,
                  dynamic
                >?
          : null,
      dismissible:
          json['dismissible']
              as bool? ??
          true,
      maxDisplayCount:
          (json['maxDisplayCount']
                  as num?)
              ?.toInt() ??
          1,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    id,
  ];
}

/// The full app-config response.
class AppConfigModel
    extends
        Equatable {
  const AppConfigModel({
    required this.heroBanners,
    required this.promoBanners,
    required this.announcements,
    this.popup,
  });

  final List<
    BannerModel
  >
  heroBanners;
  final List<
    BannerModel
  >
  promoBanners;
  final List<
    AnnouncementModel
  >
  announcements;
  final PopupModel? popup;

  factory AppConfigModel.fromJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    List<
      T
    >
    parseList<
      T
    >(
      Object? value,
      T Function(
        Map<
          String,
          dynamic
        >,
      )
      fromJson,
    ) =>
        value
            is List
        ? value
              .whereType<
                Map<
                  String,
                  dynamic
                >
              >()
              .map(
                fromJson,
              )
              .toList()
        : const [];

    final popup = json['popup'];
    return AppConfigModel(
      heroBanners: parseList(
        json['heroBanners'],
        BannerModel.fromJson,
      ),
      promoBanners: parseList(
        json['promoBanners'],
        BannerModel.fromJson,
      ),
      announcements: parseList(
        json['announcements'],
        AnnouncementModel.fromJson,
      ),
      popup:
          popup
              is Map<
                String,
                dynamic
              >
          ? PopupModel.fromJson(
              popup,
            )
          : null,
    );
  }

  @override
  List<
    Object?
  >
  get props => [
    heroBanners,
    promoBanners,
    announcements,
    popup,
  ];
}
