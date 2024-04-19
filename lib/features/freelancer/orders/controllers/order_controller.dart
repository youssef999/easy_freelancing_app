

// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, duplicate_ignore, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:freelancerApp/Core/const/app_message.dart';
import 'package:freelancerApp/features/notifications/notification_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../root/view/root_view.dart';

class OrderController extends GetxController{

List<Map<String,dynamic>> orderList=[];
TextEditingController priceController=TextEditingController();
TextEditingController avgTimeController =TextEditingController();
TextEditingController noteController =TextEditingController();


  @override
  void onInit() {
    getFreelancerOrders();
    super.onInit();
  }


 
 




getFreelancerOrders() async{

  final box=GetStorage();

  String email=box.read('email')??'';

    orderList= [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('orders')
        .where('freelancer_email',isEqualTo: email).
        orderBy('date',descending: true)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
      orderList = data;
    // ignore: duplicate_ignore
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    print("EMAIL=="+email);
    print("ORDER==="+orderList.toString());
    update();
  }


  openLocation(double lat,double lng)async{

    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
       await launch(url);
      throw 'Could not launch $url';
    }
  }

  int userBalance=0;
  


  getUserBalance(String email)async{

 
 userBalance=0;

 QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        ('wallet').where('email',isEqualTo: email)
        .get();
 
      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();
   
        userBalance=data[0]['balance'];
      // ignore: duplicate_ignore, duplicate_ignore
      }catch(e){
        // ignore: avoid_print
        print("E.......");
        // ignore: avoid_print
        print(e);
       // orderState='error';
        // ignore: avoid_print
        print("E.......");
      }
      print("total===$userBalance");
    
      update();
 }
  

  updateUserBalance(int orderPrice,String userEmail)async{
    
    int newBalance=userBalance-orderPrice;
 
    CollectionReference wallet =FirebaseFirestore.instance.collection('wallet');
      
      // Update data where a specific condition is met
      await wallet
          .where('email', isEqualTo: userEmail) // Example where clause: age is less than 30
          .get()
          .then((QuerySnapshot querySnapshot) {

        querySnapshot.docs.forEach((doc) {
          // Update each document found
          wallet.doc(doc.id).update({
            'balance': newBalance
            });
        });
      });
      
      print('Data updated successfully');

  }

  String token='';

getUserToken(String userEmail)async {
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection
    ('users').where('email',isEqualTo: userEmail).get();
  try{
    List<Map<String, dynamic>> data
    = querySnapshot.docs.map((DocumentSnapshot doc) =>
    doc.data() as Map<String, dynamic>).toList();
    token=data[0]['token'];
  }
  catch(e){
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

 changeOrderStatus(String orderId,String status,

 int orderPrice,String userEmail)async{
    NotificationController notificationController=Get.put(NotificationController());

  print(status);
    FirebaseFirestore.instance.collection('orders').doc(orderId)
        .update({
      'order_status':status
    }).then(
      (value) {
    if(status=='refuse'){
  // change user balance
 updateUserBalance(orderPrice,userEmail);
  }
      appMessage(text: 'changeStatusDone'.tr, fail: false);

      Get.offAll(RootView());

    notificationController.sendNotificationNow
      (token: token, type: '', title:'تم تغيير حالة الطلب', body:status);

    });
  }
}





