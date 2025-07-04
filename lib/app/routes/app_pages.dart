import 'package:get/get.dart';

import '../modules/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/botnavbar/bindings/botnavbar_binding.dart';
import '../modules/botnavbar/views/botnavbar_view.dart';
import '../modules/contact/bindings/contact_binding.dart';
import '../modules/contact/views/contact_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menu/bindings/menu_binding.dart';
import '../modules/menu/views/menu_view.dart';
import '../modules/menu_available/bindings/menu_available_binding.dart';
import '../modules/menu_available/views/menu_available_view.dart';
import '../modules/menu_available_detail/bindings/menu_available_detail_binding.dart';
import '../modules/menu_available_detail/views/menu_available_detail_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reactivate_confirm/bindings/reactivate_confirm_binding.dart';
import '../modules/reactivate_confirm/views/reactivate_confirm_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/subscription_confirm/bindings/subscription_confirm_binding.dart';
import '../modules/subscription_confirm/views/subscription_confirm_view.dart';
import '../modules/subscription_form/bindings/subscription_form_binding.dart';
import '../modules/subscription_form/views/subscription_form_view.dart';
import '../modules/testimony/bindings/testimony_binding.dart';
import '../modules/testimony/views/testimony_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.BOTNAVBAR,
      page: () => const BotnavbarView(),
      binding: BotnavbarBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => const MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => const ContactView(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION_FORM,
      page: () => const SubscriptionFormView(),
      binding: SubscriptionFormBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION_CONFIRM,
      page: () => const SubscriptionConfirmView(),
      binding: SubscriptionConfirmBinding(),
    ),
    GetPage(
      name: _Paths.MENU_AVAILABLE,
      page: () => const MenuAvailableView(),
      binding: MenuAvailableBinding(),
    ),
    GetPage(
      name: _Paths.MENU_AVAILABLE_DETAIL,
      page: () => const MenuAvailableDetailView(),
      binding: MenuAvailableDetailBinding(),
    ),
    GetPage(
      name: _Paths.TESTIMONY,
      page: () => const TestimonyView(),
      binding: TestimonyBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.REACTIVATE_CONFIRM,
      page: () => const ReactivateConfirmView(),
      binding: ReactivateConfirmBinding(),
    ),
  ];
}
