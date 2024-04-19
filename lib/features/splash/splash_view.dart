import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_assets.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final box = GetStorage();
  @override
  void initState() {
    String email = box.read('email') ?? 'x';
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (email == 'x') {
        Get.offNamed(Routes.LOGIN);
      } else {
        Get.offNamed(Routes.ROOT);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppAssets.logo,
              fit: BoxFit.cover,
            ),
          ),const CircularProgressIndicator.adaptive(backgroundColor: Color.fromARGB(255, 194, 194, 194),)
        ],
      ),

    );
  }
}
