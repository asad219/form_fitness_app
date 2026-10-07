import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/core/di/service_locator.dart';
import 'package:app_boilerplate/core/services/navigation/navigation_service.dart';

/// Maps CMS `targetRoute` deep links to in-app routes, ignoring unknown ones.
class CmsNavigator {
  CmsNavigator._();

  /// Opens [targetRoute]. [targetParams] may carry an id for detail routes.
  static void open(
    String? targetRoute,
    Map<
      String,
      dynamic
    >?
    targetParams,
  ) {
    if (targetRoute ==
            null ||
        targetRoute.isEmpty)
      return;
    final navigation =
        getIt<
          NavigationService
        >();
    final id = targetParams?['id']?.toString();

    switch (targetRoute) {
      case '/membership':
        navigation.pushNamed<
          void
        >(
          RoutesName.membership,
        );
      case '/orders':
        navigation.pushNamed<
          void
        >(
          RoutesName.orders,
        );
      case '/cart':
        navigation.pushNamed<
          void
        >(
          RoutesName.cart,
        );
      case '/shop/products':
        navigation.pushNamed<
          void
        >(
          RoutesName.home,
        ); // shop tab
      case '/train':
        navigation.pushNamed<
          void
        >(
          RoutesName.home,
        ); // train tab
      default:
        // Detail routes carry an id: /shop/products/<id>, /train/class/<id>.
        if (targetRoute.startsWith(
              '/shop/products/',
            ) &&
            id !=
                null) {
          navigation.pushNamed<
            void
          >(
            RoutesName.productDetails,
            arguments: id,
          );
        } else if (targetRoute.startsWith(
              '/train/class/',
            ) &&
            id !=
                null) {
          navigation.pushNamed<
            void
          >(
            RoutesName.classDetails,
            arguments: id,
          );
        }
      // Unknown routes are ignored safely.
    }
  }
}
