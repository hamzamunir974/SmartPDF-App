import 'package:get/get.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/conversion/views/conversion_page.dart';
import '../modules/conversion/bindings/conversion_binding.dart';

class AppPages {
  static const INITIAL = '/splash';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/forgot-password',
      page: () => const ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/convert',
      page: () => const ConversionPage(),
      binding: ConversionBinding(),
    ),
  ];
}
