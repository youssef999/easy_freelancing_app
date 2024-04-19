



// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllServicesController extends GetxController{

  List<Map<String,dynamic>> allServiceList=[];


  getAllServices()async{
    allServiceList==[];
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection
      ('services').get();
    //.orderBy('date',descending: true).get();
    try{
      List<Map<String, dynamic>> data
      = querySnapshot.docs.map((DocumentSnapshot doc) =>
      doc.data() as Map<String, dynamic>).toList();

      allServiceList=data;

      print("data=="+data.toString());

    }catch(e){
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print("E.......");
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print("E.......");
    }
    print("ALL SERVICESSS===");
    print(allServiceList);
    update();
  }

}