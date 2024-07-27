import 'package:get/get.dart';

import '../weather_model_model.dart';

class WeatherModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return WeatherModel.fromJson(map);
      if (map is List)
        return map.map((item) => WeatherModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<WeatherModel?> getWeatherModel(int id) async {
    final response = await get('weathermodel/$id');
    return response.body;
  }

  Future<Response<WeatherModel>> postWeatherModel(
          WeatherModel weathermodel) async =>
      await post('weathermodel', weathermodel);
  Future<Response> deleteWeatherModel(int id) async =>
      await delete('weathermodel/$id');
}
