

// ignore_for_file: non_constant_identifier_names, avoid_print, duplicate_ignore

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddServiceController extends GetxController {

TextEditingController serviceNameController=TextEditingController();
TextEditingController serviceDescriptionController=TextEditingController();
TextEditingController servicePriceController=TextEditingController();
List<String>catList=[];


 XFile? pickedImageXFile;
  final ImagePicker _picker = ImagePicker();


  var imageLink = '';
  String downloadUrl = '';
  String downloadUrl2= '';
  
  List<String> downloadUrls = [];

  List<String> downloadUrls2 = [];

 List<XFile>? pickedImageXFiles;
  List<XFile>? pickedImageXFiles2;
  bool isImage=false;

  bool isLoading=false;

  List<Map<String,dynamic>>categoryList=[];

  List<String>catNames=[];


    String selectedCategory = 'ترجمة';

  changeCatValue(String value) {
    selectedCategory = value;
    update();
  }
  
  deleteService(String itemId)async{

  try{
      await FirebaseFirestore.instance
      .collection('services').doc(itemId).delete();
        
  }catch(e){
  // ignore: avoid_print
  print(e);
  appMessage(text: e.toString(), fail: true);
 }

 Future.delayed(const Duration(seconds: 2)).then((value) {
  appMessage(text: 'itemDelet'.tr, fail: false);
  Get.offAllNamed('/bottomBar');
 });

  }

List<Map<String,dynamic>>freelancerData=[];

getFreelancerData() async{
    final box=GetStorage();

  print("FREELANCER........XXX......");

  String email=box.read('email')??'';

  freelancerData = [];

  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection('freelancers')
      .where('email',isEqualTo:email)
      .get();
  try {
    List<Map<String, dynamic>> data = querySnapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();

    freelancerData = data;

  } catch (e) {
    // ignore: avoid_print
    print("E.......");
    // ignore: avoid_print
    print(e);
    // orderState='error';
    // ignore: avoid_print
    print("E.......");
  }

  print("FFFDATAAAAAAAA==$freelancerData");
  update();
}




 getAllCategories() async {
  // ignore: avoid_print
  print("CATTT");
  final box=GetStorage();
  String lang=box.read('locale');

    categoryList = [];
  selectedCategory = 'ترجمة';

  if(lang=='ar'){
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('cat').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
      categoryList = data;
      for (int i = 0; i < categoryList.length; i++) {
        catNames.add(categoryList[i]['nameAr']);
      }
      selectedCategory=catNames[0];
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
  }else{
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('cat').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
      categoryList = data;
      for (int i = 0; i < categoryList.length; i++) {
        catNames.add(categoryList[i]['name']);
      }
      selectedCategory=catNames[0];
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
  

  showDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: const Custom_Text(
              text: 'الصورة ',
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: const Custom_Text(
                  text: 'كاميرا ',
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: ' اختر صورة  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: 'الغاء  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })
            ],
          );
        });
  }

  captureImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);
    Get.back();
    //pickedImageXFile;  
        update();
  }

  pickImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    Get.back();
    update();
    //   uploadImageToFirebaseStorage(pickedImageXFile!);
  }

    pickMultiImage() async {
    pickedImageXFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
        update();
  }








  addServiceToFireStore()async {
    print("IMAGEEE=========${downloadUrls[0]}");

    final box=GetStorage();
    
    String freelancer_email=box.read('email')??'x';

const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
  Random random = Random();
  String result = '';

  for (int i = 0; i < 12; i++) {
    result += chars[random.nextInt(chars.length)];
  }
try{
await FirebaseFirestore.instance.collection('services')
.doc(result)
.set({
  'serviceId':result,
   'name':serviceNameController.text.capitalize,
   'description':serviceDescriptionController.text,
    'price':servicePriceController.text,
    'cat':selectedCategory,
    'freelancer_email':freelancer_email,
     'freelancer_image':freelancerData[0]['image'],
     //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4i_rii7NjuzWcPQgmVtyAsckGk-YPxgrDgwGQlC772A&s',
     'freelancer_name':freelancerData[0]['name'],
     'type':'top',
    'comment':[],
    'rate':[],
    'image':downloadUrls[0],
    //'service_image':downloadUrls
   // 'service_image':downloadUrls[0],
    }).then((value) {
      isLoading=false;
      update();
      // ignore: avoid_print
      print("DONE");
      appMessage(text: 'serviceDone'.tr,fail: false);
    });
}catch(e){
  isLoading=false;
  update();
  // ignore: avoid_print
  print(e);
  appMessage(text: "serviceFail".tr,fail: true);
}

  Get.offAll(RootView());
  
}


updatService(String itemId) async {
 
 isLoading=true;
 
 update();

try{
 if(serviceNameController.text.isNotEmpty){
    await FirebaseFirestore.instance.
    collection('services').doc(itemId)
        .update({
         'name':serviceNameController.text
        });
 }

  if(serviceDescriptionController.text.isNotEmpty){
    await FirebaseFirestore.instance.
    collection('services').doc(itemId)
        .update({
         'details':serviceDescriptionController.text
        });
 }

 if(servicePriceController.text.isNotEmpty){
    await FirebaseFirestore.instance.
    collection('services').doc(itemId)
        .update({
         'price':servicePriceController.text
        });
   }
        isLoading=false;
        update();
        Get.offAll(RootView());

      }catch(e){
    isLoading=false;
    update();
  // ignore: avoid_print
  print(e);

//  appMessage(text: e.toString(), fail: true);

  }
 

 Future.delayed(const Duration(seconds: 2)).then((value) {
  appMessage(text: 'serviceUpdate'.tr, fail: false);
 });  
}

startAddingService(){
  //uploadMultiImageToFirebaseStorage(pickedImageXFiles!).then((value) {
    addServiceToFireStore();
 // });
}

Future uploadMultiImageToFirebaseStorage(List<XFile> images) async {

    for(int i=0;i<images.length;i++){
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference =
        FirebaseStorage.instance.ref().child('images/$fileName');
        UploadTask uploadTask = reference.putFile(File(images[i].path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } catch (e) {
        // Handle any errors that occur during the upload process
        // ignore: avoid_print
        print('Error uploading image to Firebase Storage: $e');
      }
    }
    return downloadUrls;
  }


}