import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:freelancerApp/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../resources/app_colors.dart';

class AdvWidget extends StatelessWidget {
  const AdvWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return SizedBox(
      height: 222,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Obx((() {
            return Column(
              children: [
                SizedBox(
                  height: 210,
                  child: CarouselSlider.builder(
                    unlimitedMode: true,
                    controller: controller.sliderController,
                    slideBuilder: (index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: controller.colors[index],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  controller.sliderImagesList[index],
                                ),
                              )),
                        ),
                      );
                    },
                    slideTransform: const DepthTransform(),
                    slideIndicator: CircularSlideIndicator(
                      padding: const EdgeInsets.only(bottom: 15),
                      currentIndicatorColor: const Color.fromARGB(255, 207, 207, 207),
                      indicatorBackgroundColor: AppColors.whiteColor,
                    ),
                    itemCount: controller.sliderImagesList.length,
                    initialPage: 0,
                    enableAutoSlider: true,
                  ),
                ),
              ],
            );
          })),
        ],
      ),
    );
  }
}
