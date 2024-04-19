import 'package:freelancerApp/features/users/controllers/users_controller.dart';
import 'package:get/get.dart';


class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersController>(
      () => UsersController(),
    );
 
  }
}