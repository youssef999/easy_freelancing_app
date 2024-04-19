import 'package:freelancerApp/features/emp/controllers/emp_controller.dart';
import 'package:get/get.dart';


class EmpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmpController>(
      () => EmpController(),
    );
  }
}