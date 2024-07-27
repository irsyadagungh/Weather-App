import 'dart:convert';
import 'package:get/get.dart';
import 'package:weather/app/model/weather_model_model.dart';
import 'package:weather/config.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  final weatherData = Rxn<WeatherModel>();
  final weatherDataList = Rxn<List>();

  Future<WeatherModel> getWeather(String location) async {
    const apiKey = Config.API_KEY;
    final url = Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("Weather data loaded");
      print("URL: $url");
      var data = jsonDecode(response.body);
      print(data);
      weatherData.value =
          WeatherModel.fromJson(data); // Set the correct value here
      print("DATA: ${weatherData.value.toString()}");
      return weatherData.value!;
    } else {
      print('Failed to load weather data: ${response.statusCode}');
      throw Exception('Failed to load weather data');
    }
  }

  Future<List> fetchWeatherData(String city) async {
    const apiKey = Config.API_KEY;
    final url = Uri.parse(
        'http://api.weatherapi.com/v1/search.json?key=$apiKey&q=%$city%');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("URL: $url");
      var data = jsonDecode(response.body);
      weatherDataList.value = data;
      print("DATA: ${weatherDataList.value.toString()}");
      return weatherDataList.value!;
    } else {
      print('Failed to load weather data: ${response.statusCode}');
      throw Exception('Failed to load weather data');
    }
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
