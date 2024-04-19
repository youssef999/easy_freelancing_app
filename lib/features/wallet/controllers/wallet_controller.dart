



// ignore_for_file: avoid_print, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WalletController extends GetxController{


 List<Map<String,dynamic>> userBalanceList=[];

 int totalBalance=0;

 TextEditingController amountController=TextEditingController();
  TextEditingController emailController=TextEditingController();



  @override
  void onInit() {
    getUserBalance();
    super.onInit();
  }

  getUserBalance() async {

    print("BALANCE..............");
    
    final box=GetStorage();
    String email=box.read('email')??'';
    userBalanceList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('wallet')
        .where('email',isEqualTo:email)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

     userBalanceList = data;

     totalBalance=userBalanceList[0]['balance'];
     
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
  
    update();
  }


  sendRequestMoney()async {

   final box=GetStorage();
   String email=box.read('email');

 const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
  Random random = Random();
  String result = '';

  for (int i = 0; i < 12; i++) {
    result += chars[random.nextInt(chars.length)];
  }

try{
await FirebaseFirestore.instance.collection('requestMoney')
.doc(result)
.set({
     'email':email,
     'paypal':emailController.text,
     'money':amountController.text,
     'balance':totalBalance,
    }).then((value) {
       appMessage(text: 'requestSent'.tr, fail: false);
       Get.offAll(RootView());
    });
}
catch(e){
  update();
  // ignore: avoid_print
  print("ERROR===="+e.toString());
}


  }


}