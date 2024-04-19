

// ignore_for_file: avoid_print, duplicate_ignore, unused_local_variable, avoid_function_literals_in_foreach_calls


import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/features/notifications/notification_controller.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
import 'package:location/location.dart';
import '../../../core/const/app_message.dart';

class CheckoutController extends GetxController{

TextEditingController desController=TextEditingController();

TextEditingController locationController=TextEditingController();

TextEditingController priceController=TextEditingController();
TextEditingController notesController=TextEditingController();
TextEditingController timeController=TextEditingController();
bool isLoading=false;

   Location location = Location();
  PermissionStatus ? _permissionGranted;
  // ignore: unused_field
  LocationData ? _locationData;
  
 Future<void> getLocationPermission() async {
    _permissionGranted = await location.requestPermission();
    print("PER===="+_permissionGranted.toString());
    if (_permissionGranted == PermissionStatus.granted) {
      await location.requestPermission();
      print("Done");
    }
  }

   List<Map<String,dynamic>>userList=[];

   String userName='';

   int freelancerTotalBalance=0;


    getUserName()async {
    print("NAMEEEEEEEE");

 userList=[];

 final box=GetStorage();

 String email=box.read('email');

 String roleId=box.read('roleId');
String type='users';
 if(roleId=='1'){
   type='users';
 }else{
   type='freelancers';
 }

 QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        (type).where('email',isEqualTo: email)
        .get();
        print("EMAIL==$email");

      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();
      userList=data;
      userName=userList[0]['name'];
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
      print("user===$userName");
      update();
}

    getFreelancerBalance(String email)async{

 freelancerTotalBalance=0;

 QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        ('wallet').where('email',isEqualTo: email)
        .get();

      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();
   
    freelancerTotalBalance=data[0]['balance'];
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
      print("total===$freelancerTotalBalance");
      update();
 }

   addBalanceToFreelancer(String email)async{

 print("totalBALANCE===$freelancerTotalBalance");

 int newBalance=int.parse(priceController.text)+freelancerTotalBalance;
 
  CollectionReference wallet =FirebaseFirestore.instance.collection('wallet');
      
      // Update data where a specific condition is met
      await wallet
          .where('email', isEqualTo: email) // Example where clause: age is less than 30
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

    getFreelancerToken(String freelancerEmail)async {
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection
    ('freelancers').where('email',isEqualTo: freelancerEmail).get();
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

    addOrderToFirebase(DocumentSnapshot data)async{

 NotificationController notificationController=Get.put(NotificationController());

 final box=GetStorage();

 String email=box.read('email')??'';

 const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
  Random random = Random();
  String result = '';
 DateTime now = DateTime.now();

 //String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());


  for (int i = 0; i < 12; i++) {
    result += chars[random.nextInt(chars.length)];
  }

 try{

 await FirebaseFirestore.instance.collection('orders').doc(result)
   .set({
  
  'service_name':data['name'].toString(),

  'date':formattedDate,
  //DateTime.now().toString()
  "freelancer_email":data['freelancer_email'],

  'freelancer_name': data['freelancer_name'],
  
  'service_image':data['image'],

  'order_des':desController.text,

  'client_name':userName,

  'client_email':email,

  'service_price':priceController.text,

  'notes':notesController.text,

  'notes2':'',

  'task_time':timeController.text,

  'id':result,

  'order_status':'pending',

    }).then((value) {
     isLoading=true;
      update();
      // ignore: avoid_print
      print("DONE");
      appMessage(text: 'dealSent'.tr,fail: false);

      Get.offAll(RootView());

    notificationController.sendNotificationNow
        (token: token, type: '', title: data['name'].toString(),
          body:data['freelancer_name']);
     // Get.toNamed('/bottomBar');
    });
}
  catch(e){
  isLoading=false;
  update();
  // ignore: avoid_print, prefer_interpolation_to_compose_strings
  print("EEE=="+e.toString());
  appMessage(text: "Can't Add Item Now",fail: true);
  }
}

    addOrderToFirebase2(Map<String,dynamic> data)async{

  final box=GetStorage();

 String locationName= box.read('location').toString();


    var lat = box.read('lat') ?? '';
    var lng = box.read('lng') ?? '';

NotificationController notificationController=Get.put(NotificationController());

  String email=box.read('email')??'';

  const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
  Random random = Random();
  String result = '';
  DateTime now = DateTime.now();

  //String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

   for (int i = 0; i < 12; i++) {
    result += chars[random.nextInt(chars.length)];
  }

  try{

    await FirebaseFirestore.instance.collection('orders').doc(result)
        .set({

      'service_name':data['name'].toString(),

      'date':formattedDate,
      //DateTime.now().toString()
      "freelancer_email":data['freelancer_email'],

      'freelancer_name': data['freelancer_name'],

      'service_image':data['image'],

      'location':locationName,

      'lat':lat,

      'lng':lng,

      'order_des':desController.text,

      'client_name':userName,

      'client_email':email,

      'service_price':priceController.text,

      'notes':notesController.text,

      'notes2':'',

      'task_time':timeController.text,

      'id':result,

      'order_status':'pending',

    }).then((value) {
      isLoading=true;
      update();
      // ignore: avoid_print
      print("DONE");
      appMessage(text: 'dealSent'.tr,fail: false);

      notificationController.sendNotificationNow
        (token: token, type: '', title: data['name'].toString(),
          body:data['freelancer_name']);

      Get.offAll(RootView());
      // Get.toNamed('/bottomBar');
    });
  } catch(e){
    isLoading=false;
    update();
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print("EEE=="+e.toString());
    appMessage(text: "Can't Add Item Now",fail: true);
  }
}

}