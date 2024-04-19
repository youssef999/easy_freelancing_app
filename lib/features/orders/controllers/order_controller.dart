

// ignore_for_file: unused_local_variable, avoid_print, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserOrderController extends GetxController {


List<Map<String,dynamic>> orderList=[];

getUserOrders()async{
  print("aaa");
  final box=GetStorage();
  String email=box.read('email')??''; 
 orderList=[];

QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        ('orders')
        .where('client_email',isEqualTo: email)
        //.orderBy('date',descending: true)
        .get();
      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();
      orderList=data;
     
      }catch(e){
        // ignore: avoid_print
        print("E.......");
        // ignore: avoid_print
        print(e);
       // orderState='error';
        // ignore: avoid_print
        print("E.......");
      }
      print("...");
      print(orderList);
      print('...');
      update();
}


}