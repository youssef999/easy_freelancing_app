
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:get/get.dart';

class ChnageOrderController extends GetxController{

TextEditingController priceController = TextEditingController();
TextEditingController noteController = TextEditingController();
TextEditingController timeController=TextEditingController();





changeOrderData(String orderId)async{

  if(priceController.text.isNotEmpty){

     FirebaseFirestore.instance.collection('orders').doc(orderId)
        .update({
      'service_price':priceController.text,
      'order_status':'pending'
    }).then((value) {
    //  appMessage(text: 'orderChnagedSentToClient'.tr, fail: false);
   //   Get.offAll(RootView());
    });
  }

   if(timeController.text.isNotEmpty){

     FirebaseFirestore.instance.collection('orders').doc(orderId)
        .update({
          'task_time':timeController.text
      
    }).then((value) {
     // appMessage(text: 'orderChnagedSentToClient'.tr, fail: false);
   //   Get.offAll(RootView());
    });
  }

   if(noteController.text.isNotEmpty){

     FirebaseFirestore.instance.collection('orders').doc(orderId)
        .update({
      'notes2':noteController.text
    }).then((value) {
      //
   //   
    });
  }
  appMessage(text: 'orderChangedSentToClient'.tr, fail: false);
Get.offAll(RootView());
}




userChangeDeal(String orderId)async{

  if(priceController.text.isNotEmpty){

     FirebaseFirestore.instance.collection('orders').doc(orderId)
        .update({
      'service_price':priceController.text,
      'order_status':'pending'
    }).then((value) {
    //  appMessage(text: 'orderChnagedSentToClient'.tr, fail: false);
   //   Get.offAll(RootView());
    });
  }

   if(timeController.text.isNotEmpty){

     FirebaseFirestore.instance.collection('orders').doc(orderId)
        .update({
          'task_time':timeController.text
      
    }).then((value) {
     // appMessage(text: 'orderChnagedSentToClient'.tr, fail: false);
   //   Get.offAll(RootView());
    });
  }

   if(noteController.text.isNotEmpty){

     FirebaseFirestore.instance.collection('orders').doc(orderId)
        .update({
      'notes':noteController.text
    }).then((value) {
      //
   //   
    });
  }
  appMessage(text: 'dealChanged'.tr, fail: false);
   Get.offAll(RootView());
}
}