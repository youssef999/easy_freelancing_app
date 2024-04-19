

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllFreelancerController extends GetxController{

  List<Map<String,dynamic>> allFreelancerList=[];

  List<Map<String,dynamic>> allEmpList=[];

  getAllFreelancers()async{
    allFreelancerList=[];
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection
      ('freelancers').get();
        //.orderBy('date',descending: true).get();
    try{
      List<Map<String, dynamic>> data
      = querySnapshot.docs.map((DocumentSnapshot doc) =>
      doc.data() as Map<String, dynamic>).toList();
      allFreelancerList=data;
    }catch(e){
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


  getAllEmployess()async{
    allEmpList=[];
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection
      ('employees').get();
    //.orderBy('date',descending: true).get();
    try{
      List<Map<String, dynamic>> data
      = querySnapshot.docs.map((DocumentSnapshot doc) =>
      doc.data() as Map<String, dynamic>).toList();

      allEmpList=data;

    }catch(e){
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }

    print("ALL EMP==$allEmpList");
    update();
  }

}