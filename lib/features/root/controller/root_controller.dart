// ignore_for_file: unused_local_variable, unused_import, avoid_print

import 'package:freelancerApp/features/chat/views/all_chats_view.dart';
import 'package:freelancerApp/features/freelancer/freelancer/views/freelancer_view.dart';
import 'package:freelancerApp/features/freelancer/orders/views/order_request_view2.dart';
import 'package:freelancerApp/features/freelancer/service/views/add_service_view.dart';
import 'package:freelancerApp/features/freelancer/service/views/freelancer_services.dart';
import 'package:freelancerApp/features/home/views/home_view.dart';
import 'package:freelancerApp/features/profile/view/profile_view.dart';
import 'package:freelancerApp/features/root/view/third.dart';
import 'package:freelancerApp/features/settings/views/settings_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../orders/views/myorder_view.dart';

class RootController extends GetxController {

  RxInt selectedIndex = 0.obs;

String roleId='';


  List page = [
     HomeView(),
     const AllChatsView(),
     const MyOrderView(),
     const ProfileView(),

  ];

  @override
  void onInit() {
    super.onInit();
     final box=GetStorage();
  String roleId =  box.read('roleId')??'1';

 print("ROLEID==========$roleId");


  if(roleId=='1'){
    page=[
     HomeView(),
     const AllChatsView(),
     const MyOrderView(),
      const SettingsView(),
    // const ProfileView(),
    ];
  }
  else{
    page=[
     HomeView(),
     const AllChatsView(),
      const FreelancerServicesView(),
    //  const AddServicesView(),
     const OrderRequestView(),
     const FreelancerView(),
    //  const SettingsView(),
    ];
  }

  print('ROLEIDD=====$roleId');

  }


  void selectedPage(int index) {
    selectedIndex.value = index;
  }
}
