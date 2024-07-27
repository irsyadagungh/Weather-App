import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:weather/app/controllers/weather_controller.dart';
import 'package:weather/app/modules/add_city/views/add_city_view.dart';
import 'package:weather/app/utils/constant/color.dart';
import 'package:weather/custom_icon.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final weatherC = Get.find<WeatherController>();

    final drawerC = AdvancedDrawerController();

    return AdvancedDrawer(
      disabledGestures: true,
      controller: drawerC,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),

      /** DRAWER */
      drawer: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50,
            left: 16,
          ),
          child: Column(
            children: [
              /** ADD CITY */
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "Manage City",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'addCity',
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.black.withOpacity(0.1)),
                      ),
                      onPressed: () {
                        Get.to(() => AddCityView());
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              ),

              /** LIST CITY */
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        tileColor: primaryColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Bandung",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.pin_drop_rounded,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Sunny",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              "30°",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        /** EDIT CITY */
                        trailing: Obx(
                          () => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: controller.isEdit.value == true ? 50 : 0,
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: controller.isEdit.value == true ? 1 : 0,

                              /** CHECKBOX */
                              child: Checkbox(
                                value: controller.isSelected!.value,
                                onChanged: (value) {
                                  controller.isSelected!.value = value!;
                                },
                              ),
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                        /** ON TAP */
                        onLongPress: () {
                          controller.changeEdit();
                        },
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),

              /** DELETE CITY */
              SlideTransition(
                position: controller.slideAnimation,
                child: IconButton(
                  iconSize: 40,
                  onPressed: () {},
                  icon: Icon(CustomIcon.delete),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Obx(
        /** WEATHER */
        () => Scaffold(
          backgroundColor: controller.getColorWeather(
              "${weatherC.weatherData.value?.current!.condition!.text!}"),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.fetchWeatherData();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  collapsedHeight: 100,
                  expandedHeight: 700,
                  toolbarHeight: 100,
                  backgroundColor: Colors.transparent,
                  leading: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 25,
                      bottom: 25,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          drawerC.toggleDrawer();
                        },
                        icon: Icon(CustomIcon.menu),
                      ),
                    ),
                  ),
                  title: Text('${weatherC.weatherData.value?.location!.name}'),
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: controller
                                        .weatherController.weatherData.value !=
                                    null
                                ? controller.getWeatherIcon(controller
                                    .weatherController
                                    .weatherData
                                    .value!
                                    .current!
                                    .condition!
                                    .text!)
                                : Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "${weatherC.weatherData.value?.current!.tempC}°",
                                  style: TextStyle(
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      "${weatherC.weatherData.value?.current!.condition!.text}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        "Feels like ${weatherC.weatherData.value?.current!.feelslikeC}°"),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
