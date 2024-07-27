import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_city_controller.dart';

class AddCityView extends GetView<AddCityController> {
  final controller = Get.put(AddCityController());

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'addCity',
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text('Add City'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  controller.searchCity(value);
                },
                controller: controller.cityName,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                ),
              ),
            ),
          ),
          Obx(() => SliverList.builder(
              itemCount: controller.weatherC.weatherDataList.value?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      "${controller.weatherC.weatherDataList.value?[index]['name']}"),
                  onTap: () {
                    controller.addCity(
                        "${controller.weatherC.weatherDataList.value?[index]['name']}");
                    Get.back();
                  },
                );
              })),
        ],
      )),
    );
  }
}
