import 'package:flutter/material.dart';
import 'package:freelancerApp/core/localization/localization_controller.dart';
import 'package:get/get.dart';
import '../widgets/Custom_button.dart';
import '../widgets/custom_app_bar.dart';

class LocalView extends GetWidget<LocaleController> {
  const LocalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('changeLang'.tr, context, true),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            CustomButton(
                text: 'English',
                onPressed: () {
                  controller.changeLang('en');
                  Get.toNamed('/bottomBar');
                },
                ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                text: 'العربية ',
                onPressed: () {
                  controller.changeLang('ar');
                  Get.toNamed('/bottomBar');
                },
                ),
          ],
        ),
      ),
    );
  }
}
