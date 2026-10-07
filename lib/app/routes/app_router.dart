import 'package:app_boilerplate/app/main_shell.dart';
import 'package:app_boilerplate/app/routes/not_found_page.dart';
import 'package:app_boilerplate/app/routes/routes_name.dart';
import 'package:app_boilerplate/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:app_boilerplate/features/auth/presentation/pages/login_page.dart';
import 'package:app_boilerplate/features/auth/presentation/pages/onboarding_page.dart';
import 'package:app_boilerplate/features/auth/presentation/pages/register_page.dart';
import 'package:app_boilerplate/features/auth/presentation/pages/splash_page.dart';
import 'package:app_boilerplate/features/auth/presentation/pages/verify_email_page.dart';
import 'package:app_boilerplate/features/cart/presentation/pages/cart_page.dart';
import 'package:app_boilerplate/features/cart/presentation/pages/order_complete_page.dart';
import 'package:app_boilerplate/features/shop/presentation/pages/product_details_page.dart';
import 'package:app_boilerplate/features/train/presentation/pages/class_details_page.dart';
import 'package:app_boilerplate/features/train/presentation/pages/reservation_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static final Map<
    String,
    WidgetBuilder
  >
  _routes = {
    RoutesName.splash:
        (
          _,
        ) => const SplashPage(),
    RoutesName.onboarding:
        (
          _,
        ) => const OnboardingPage(),
    RoutesName.login:
        (
          _,
        ) => const LoginPage(),
    RoutesName.register:
        (
          _,
        ) => const RegisterPage(),
    RoutesName.forgotPassword:
        (
          _,
        ) => const ForgotPasswordPage(),
    RoutesName.verifyEmail:
        (
          _,
        ) => const VerifyEmailPage(),
    RoutesName.home:
        (
          _,
        ) => const MainShell(),
    RoutesName.classDetails:
        (
          _,
        ) => const ClassDetailsPage(),
    RoutesName.reservation:
        (
          _,
        ) => const ReservationPage(),
    RoutesName.productDetails:
        (
          _,
        ) => const ProductDetailsPage(),
    RoutesName.cart:
        (
          _,
        ) => const CartPage(),
    RoutesName.orderComplete:
        (
          _,
        ) => const OrderCompletePage(),
  };

  static bool
  isKnownRoute(
    String routeName,
  ) => _routes.containsKey(
    routeName,
  );

  static Route<
    dynamic
  >
  generateRoute(
    RouteSettings settings,
  ) {
    final builder =
        _routes[settings.name] ??
        (
          _,
        ) => const NotFoundPage();
    return MaterialPageRoute<
      void
    >(
      builder: builder,
      settings: settings,
    );
  }
}
