import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/bottom_navber.dart';
import 'package:freelancerApp/core/widgets/drawer_widget.dart';
import 'package:freelancerApp/features/root/controller/root_controller.dart';
import 'package:get/get.dart';

class RootView extends GetView<RootController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  RootView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        extendBody: true,
        backgroundColor: AppColors.primaryLightColor,
        bottomNavigationBar:
            buildBottomNavigationMenu(context, controller),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: controller
            .page[controller.selectedIndex.value],
      ),
    );
  }
}
