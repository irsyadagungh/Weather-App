import 'package:get/get.dart';

import 'package:weather/app/modules/add_city/bindings/add_city_binding.dart';
import 'package:weather/app/modules/add_city/views/add_city_view.dart';
import 'package:weather/app/modules/home/bindings/home_binding.dart';
import 'package:weather/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CITY,
      page: () => AddCityView(),
      binding: AddCityBinding(),
    ),
  ];
}
