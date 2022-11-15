import 'package:get/get.dart';

import '../modules/edit_event/bindings/edit_event_binding.dart';
import '../modules/edit_event/views/edit_event_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/event/bindings/event_binding.dart';
import '../modules/event/views/event_view.dart';
import '../modules/form_daftar_donor/bindings/form_daftar_donor_binding.dart';
import '../modules/form_daftar_donor/views/form_daftar_donor_view.dart';
import '../modules/form_event/bindings/form_event_binding.dart';
import '../modules/form_event/views/form_event_view.dart';
import '../modules/form_register/bindings/form_register_binding.dart';
import '../modules/form_register/views/form_register_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_admin/bindings/home_admin_binding.dart';
import '../modules/home_admin/views/home_admin_view.dart';
import '../modules/location/bindings/location_binding.dart';
import '../modules/location/views/location_view.dart';
import '../modules/main_home_admin/bindings/main_home_admin_binding.dart';
import '../modules/main_home_admin/views/main_home_admin_view.dart';
import '../modules/main_home_user/bindings/main_home_user_binding.dart';
import '../modules/main_home_user/views/main_home_user_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORM_REGISTER,
      page: () => const FormRegisterView(),
      binding: FormRegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME_ADMIN,
      page: () => HomeAdminView(),
      binding: HomeAdminBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION,
      page: () => LocationView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_HOME_USER,
      page: () => MainHomeUserView(),
      binding: MainHomeUserBinding(),
    ),
    GetPage(
      name: _Paths.FORM_DAFTAR_DONOR,
      page: () => const FormDaftarDonorView(),
      binding: FormDaftarDonorBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_HOME_ADMIN,
      page: () => MainHomeAdminView(),
      binding: MainHomeAdminBinding(),
    ),
    GetPage(
      name: _Paths.FORM_EVENT,
      page: () => FormEventView(),
      binding: FormEventBinding(),
    ),
    GetPage(
      name: _Paths.EVENT,
      page: () => EventView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EVENT,
      page: () => const EditEventView(),
      binding: EditEventBinding(),
    ),
  ];
}
