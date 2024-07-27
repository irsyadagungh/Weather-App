import 'package:get/get.dart';

import '../controllers/add_city_controller.dart';

class AddCityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCityController>(
      () => AddCityController(),
    );
  }
}
