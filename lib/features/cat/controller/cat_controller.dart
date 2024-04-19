



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CatController extends GetxController{

List<Map<String,dynamic>>catList=[];

List<Map<String,dynamic>>serviceCatList=[];


getAllCat()async{


 catList=[];
QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        ('cat').get();
      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();
      catList=data;
     
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



getCatServices(String cat)async{

serviceCatList=[];
final box=GetStorage();
String lang=box.read("locale");

if(lang=='ar'){
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection
    ('freelancers')
      .where('cat',isEqualTo: cat)
      .get();
  try{
    List<Map<String, dynamic>> data
    = querySnapshot.docs.map((DocumentSnapshot doc) =>
    doc.data() as Map<String, dynamic>).toList();

    serviceCatList=data;
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

else{
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection
    ('freelancers')
      .where('catEn',isEqualTo: cat)
      .get();
  try{
    List<Map<String, dynamic>> data
    = querySnapshot.docs.map((DocumentSnapshot doc) =>
    doc.data() as Map<String, dynamic>).toList();

    serviceCatList=data;
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



}
}