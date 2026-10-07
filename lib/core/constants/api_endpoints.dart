/// API paths. The base URL comes from [EnvConfig].
class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/users/login';
  static const String register = '/users/register';
  static const String logout = '/users/logout';
  static const String refreshToken = '/auth/refresh';
  static const String firebaseLogin = '/auth/firebase-login';

  // Password reset (3 steps)
  static const String sendResetCode = '/users/send-reset-password-code';
  static const String verifyResetCode = '/users/verify-reset-password-code';
  static const String updatePassword = '/users/update-password';

  // User profile
  static String user(
    String userId,
  ) => '/users/$userId';
  static String updateUser(
    String userId,
  ) => '/users/update/$userId';

  // CMS (public)
  static const String appConfig = '/app-config';
  static const String banners = '/banners';
  static const String announcements = '/announcements';
  static const String activePopup = '/popups/active';

  // Shop (public)
  static const String products = '/shop/products';
  static String product(
    String id,
  ) => '/shop/products/$id';

  // Train (public)
  static const String classes = '/train/classes';
  static String classDetail(
    String id,
  ) => '/train/classes/$id';
  static const String sessions = '/train/sessions';

  // Cart (auth)
  static const String cart = '/cart';
  static const String cartServiceItems = '/cart/service-items';
  static const String cartProductItems = '/cart/product-items';
  static String cartItem(
    String itemId,
  ) => '/cart/items/$itemId';

  // Checkout (auth)
  static const String checkoutProcess = '/checkout/process';
  static String order(
    String id,
  ) => '/checkout/orders/$id';

  // Orders (auth)
  static const String orders = '/orders';
  static String orderById(
    String id,
  ) => '/orders/$id';
  static String cancelBooking(
    String orderId,
    String bookingId,
  ) => '/orders/$orderId/bookings/$bookingId/cancel';

  // Memberships
  static const String membershipPlans = '/memberships/plans';
  static const String myMembership = '/memberships/me';
  static const String subscribeMembership = '/memberships/subscribe';
  static const String cancelMembership = '/memberships/me/cancel';

  // Contact (public)
  static const String contact = '/contact';

  // Devices (FCM)
  static const String registerDevice = '/devices';
}
