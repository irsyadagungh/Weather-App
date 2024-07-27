import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/app/controllers/weather_controller.dart';

class AddCityController extends GetxController {
  final weatherC = Get.find<WeatherController>();

  final TextEditingController cityName = TextEditingController();

  void addCity(String city) {
    weatherC.fetchWeatherData(city);
  }

  void searchCity(String city) {
    weatherC.fetchWeatherData(city);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
