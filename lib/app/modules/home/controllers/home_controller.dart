import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:weather/app/controllers/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:weather/app/model/weather_model_model.dart';
import 'package:weather/app/utils/constant/color.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final weatherController = Get.find<WeatherController>();

  RxBool isEdit = false.obs;
  RxBool? isSelected = false.obs;

  void changeEdit() {
    isEdit.value = !isEdit.value;
  }

  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  Widget getWeatherIcon(String condition) {
    switch (condition) {
      case 'Sunny':
        return Image.asset('assets/images/sunny.png');
      case 'Rain' || 'Patchy rain nearby':
        return Image.asset('assets/images/rainy.png');
      case 'Snow':
        return Image.asset('assets/images/snowy.png');
      case 'Cloudy' || 'Partly Cloudy':
        return Image.asset('assets/images/cloudy.png');
      default:
        return Image.asset('assets/images/sunny.png');
    }
  }

  Color getColorWeather(String condition) {
    switch (condition) {
      case 'Sunny':
        return sunnyColor;
      case 'Rain' || 'Patchy rain nearby':
        return rainyColor;
      case 'Snow':
        return snowColor;
      case 'Cloudy' || 'Partly Cloudy':
        return cloudyColor;
      default:
        return Color(0xFF74aede);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchWeatherData();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(0, 4), // Posisi awal di bawah
      end: Offset(0, 0), // Posisi akhir (visible)
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    isEdit.listen((isEditing) {
      if (isEditing) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

  Future<void> fetchWeatherData() async {
    try {
      await weatherController.getWeather("Bandung");
    } catch (e) {
      print(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
