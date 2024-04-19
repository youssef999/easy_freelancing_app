




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FreelancerServicesController extends GetxController{


List<Map<String,dynamic>>serviceList=[];

 @override
  void onInit() async {

   await getAllServices();

    super.onInit();
  }
 getAllServices() async {
  final box=GetStorage();
  String email=box.read('email')??'test2@gmail.com';
    serviceList= [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('services')
        .where('freelancer_email',isEqualTo: email)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
      serviceList = data;
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    update();
  }

}