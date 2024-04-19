import 'package:freelancerApp/features/home/controllers/home_controller.dart';
import 'package:freelancerApp/features/root/controller/root_controller.dart';
import 'package:get/get.dart';


class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
 
  }
}