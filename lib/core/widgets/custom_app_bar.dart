// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/custom_image_widget.dart';
import 'package:freelancerApp/features/cat/views/cat_view.dart';
import 'package:freelancerApp/features/root/controller/root_controller.dart';
import 'package:freelancerApp/features/search/search_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget CustomAppBar(
    String text, BuildContext context, bool isHome) {
  final bottomNavBarController = Get.put(RootController(), permanent: false);

  return AppBar(
    backgroundColor: AppColors.whiteColor,
    elevation: bottomNavBarController.selectedIndex.value == 0 ? 0 : 0,
    centerTitle: true,
    leading: isHome
        ? GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Padding(
                padding: EdgeInsets.only(left:  24 * 0.6,right:24 * 0.6),
                child: CustomImageWidget(
                  path: 'assets/icon/drawer_menu.svg',
                  height: 17,
                  width: 17,
                  color: AppColors.primaryBGLightColor,
                )),
          )
        : IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
    title: Padding(
      padding: const EdgeInsets.all(24 * 1.2),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBGLightColor,
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(left: 24 * 0.6,right:24 * 0.6 ),
        child:isHome ? GestureDetector(
          onTap: () {

           // Get.to(const SearchView());
            Get.to(const CatView());
           // Get.toNamed(Routes.PROFILE);
          },
          child: const CustomImageWidget(
            path: 'assets/icon/cat.svg',
            height: 28,
            width: 28,
            color: AppColors.primaryBGLightColor,
          ),
        ):const SizedBox()
      )
    ],
  );
}
