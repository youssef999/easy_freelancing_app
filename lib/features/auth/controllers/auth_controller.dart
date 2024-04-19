// ignore_for_file: unused_local_variable, avoid_print, duplicate_ignore, unused_field, unused_element

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_loading.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../../../../Core/const/app_message.dart';
import '../views/verfied_email.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController checkPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController roleId = TextEditingController();
  TextEditingController empCatController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<int> isSelected = 1.obs;
  int regRoleId = 1;
  GlobalKey<FormState>? loginFormKey;
  changeRoleId(int val) {
    regRoleId = val;
    update();
  }

   Location location = Location();
  PermissionStatus ? _permissionGranted;
  LocationData ? _locationData;


 Future<void> getLocationPermission() async {
    _permissionGranted = await location.requestPermission();
    print("PER===="+_permissionGranted.toString());
    if (_permissionGranted == PermissionStatus.granted) {
      await location.requestPermission();
      print("Done");
    }
  }

  @override
  void onInit() async {
    getDeviceToken();
    getAllCategories();
    getAllCountries();
    getAllCities();

    super.onInit();
  }

  User? user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> categoryList = [];
  List<Map<String, dynamic>> countryList = [];
  List<Map<String, dynamic>> cityList = [];
  final List<String> catNames = [];
  final List<String> countryNames = [];

  final List<String> cityNames = [];

  List<String> empTypeList = ['online'.tr, 'offline'.tr];

  String empType = 'online'.tr;

  changeEmpType(String val) {
    empType = val;
    update();
  }

  String selectedItem = 'ترجمة';
  String selectedCountry = 'الجزائر';
  String selectedCity = 'وهران';
  String phoneNumber = '';
  List<Map<String, dynamic>> userDataList = [];

  List<Map<String, dynamic>> freelancerDataList = [];

  XFile? pickedImageXFile;

  final ImagePicker _picker = ImagePicker();

  var imageLink = '';

  String downloadUrl = '';

  String profileUrl = '';

  String idUrl = '';

  String downloadUrl2 = '';

  List<String> downloadUrls = [];

  List<String> profileDownloadUrl = [];

  List<XFile> ?idUrlList ;

  List<XFile>? pickedImageXFiles;

  List<XFile>? profilePickedFiles;

  bool isImage = false;

  bool isLoading = false;

  final box = GetStorage();

  changeCityValue(String val) {
    selectedCity = val;
    update();
  }


   showIdDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Custom_Text(
              text: 'camera'.tr,
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: Custom_Text(
                  text: 'gallery'.tr,
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'selectImage'.tr,
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'cancel'.tr,
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

  showProfileDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Custom_Text(
              text: 'camera'.tr,
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: Custom_Text(
                  text: 'gallery'.tr,
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'selectImage'.tr,
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'cancel'.tr,
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

  pickProfileImage() async {
    profilePickedFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
    update();
  }


   pickIdImage() async {
    idUrlList = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
    update();
  }

  getRoleIdByUser() async {
    print(".....GET ROLE ID USERSSS.......");

    userDataList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: emailController.text)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
      userDataList = data;
      if (userDataList.isNotEmpty) {
        roleId.text = '1';
        box.write('roleId', roleId.text);
      } else {
        getRoleIdByFreelancer();
      }
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);

      print("E.......");
    }

    update();
  }

  getRoleIdByFreelancer() async {
    print("GET ROLE ID FREELANCERSSS....");
    freelancerDataList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('freelancers')
        .where('email', isEqualTo: emailController.text)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      freelancerDataList = data;

      if (freelancerDataList.isNotEmpty) {
        roleId.text = '2';
        box.write('roleId', roleId.text);
      } else {
        print("ELSE");
      }
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);

      print("E.......");
    }
    update();
  }

  changeCatValue(String value) {
    catValue=value;
   // selectedItem = value;
    update();
  }

  changeCountryValue(String value) {
    selectedCountry = value;
    update();
  }

  getAllCities() async {
    print("ccc");

    cityList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('city').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      cityList = data;

      for (int i = 0; i < cityList.length; i++) {
        cityNames.add(cityList[i]['name']);
      }

      print("city===$cityList");
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

   String catValue='Graphic Design';

  getAllCategories() async {
    final box=GetStorage();
    String lang=box.read('locale');

    categoryList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cat').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      categoryList = data;
      if(lang=='ar'){

        for (int i = 0; i < categoryList.length; i++) {

          catNames.add(categoryList[i]['nameAr']);


          catValue=catNames[0];

          print("CATLENGTH======"+catNames.length.toString());

        }
      }

      else{
        for (int i = 0; i < categoryList.length; i++) {

          catNames.add(categoryList[i]['name']);

          catValue=catNames[0];

          print("CATLENGTH======"+catNames.length.toString());
        }

      }

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

  getAllCountries() async {
    print("ccc");
    countryList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('countries').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      countryList = data;

      for (int i = 0; i < countryList.length; i++) {
        countryNames.add(countryList[i]['name']);
      }
      print(countryNames);
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

  String token = '';

  getDeviceToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();
    // Get the device token
    token = (await _firebaseMessaging.getToken())!;
  }

  addTokenToFirebase() async {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
    Random random = Random();
    String result = '';

    for (int i = 0; i < 12; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    await FirebaseFirestore.instance.collection('tokens').doc(result).set({
      'token': token!,
    }).then((value) {
      print("DONE ADD TOKEN");
    });
  }


 String enCat='';

  getCatInEnglish(String cat) async {

    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection
      ('cat').where('nameAr',isEqualTo: cat).get();
    try{
      List<Map<String, dynamic>> data
      = querySnapshot.docs.map((DocumentSnapshot doc) =>
      doc.data() as Map<String, dynamic>).toList();

      enCat=data[0]['name'];

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

  changePassword() async {
    if (passController.text == checkPassController.text &&
        passController.text.length > 5) {
      try {
        await user!.updatePassword(passController.text.toString());
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else {
      appMessage(
          text: 'كلمة المرور غير متطابقة او عددها اقل من 6 ', fail: true);
    }
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .then((value) {
        appMessage(text: "checkMail".tr, fail: true);

        Get.toNamed(Routes.LOGIN)!
            .then((value) => appMessage(text: "checkMail".tr, fail: false));
      });
      // Password reset email sent successfully
    } catch (e) {
      appMessage(text: 'ادخل بريد سليم ', fail: false);
      // Handle any errors that occur during the password reset process
      // ignore: avoid_print
      print('Error sending password reset email: $e');
    }
  }

  userLogin() async {
    final box = GetStorage();
    String roleId = box.read('roleId') ?? 'x';
    print("ROLENEWID===$roleId");
    print("LOGINNN");

    loading = true;
    update();
    // final box = GetStorage();
    if (emailController.text.length > 2 && passController.text.length > 5) {
      try {
       final cred = await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passController.text);

       Future.delayed(const Duration(seconds: 1)).then((value) {

         if(cred.user!.emailVerified){
           print("DONE");
           box.write('email', emailController.text);
           box.write('roleId', roleId);
           Get.offAllNamed(Routes.ROOT);
           loading = false;
           CustomLoading.cancelLoading();
           update();
         }else{
           CustomLoading.cancelLoading();
           appMessage(text: 'emailNotVerfied'.tr, fail: true);
         }
         print('Received data: $value');
       }).catchError((error) {
         print('Error occurred: $error');
       });


           // .then((value) async {


       // });
      } catch (e) {
        CustomLoading.cancelLoading();
        loading = false;
        update();
        String error = '';
        print("E====$e");
        if (e.toString().contains('The password is invalid')) {
          error = 'wrongPass'.tr;
        } else if (e.toString().contains('There is no user record')) {
          error = 'wrongMail'.tr;
        } else {
          error = 'Something Went Wrong Try Agian ';
        }
      }
    } else {
      CustomLoading.cancelLoading();
      if (emailController.text.contains('@') == false) {
        appMessage(text: 'wrongMail'.tr, fail: false);
      }
      if (passController.text.length < 5) {
        appMessage(text: 'wrongPass'.tr, fail: false);
      }
    }
  }

  userSignUp() async {
    final userId = FirebaseAuth.instance.currentUser;
    // loading = true;
    update();
    final box = GetStorage();
    var lat = box.read('lat') ?? '';
    var lng = box.read('lng') ?? '';
  //  Ui.logSuccess(phoneNumber);
    String role = box.read('roleId') ?? 'x';
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      )
          .then((user) async {
        CustomLoading.cancelLoading();
        try {
          if (regRoleId == 1) {

            await firestore.collection('users').add({
              'name': nameController.text,
              'password': passController.text,
              'email': emailController.text,
              'token': token,
              'country': selectedCountry,
              //  'roleId': roleId.text,
              'type': 'normal',
              'uid': userId?.uid,
              'city': selectedCity,
               'lat': lat,
               'lng': lng,
            });
          } else {
            if (empType == 'online'.tr) {

              await firestore.collection('freelancers').add({

                'name': nameController.text,
                'password': passController.text,
                'email': emailController.text,
                'token': token,
                'country': selectedCountry,
                'price':priceController.text,
                "cat":catValue,
                'catEn':enCat,
                //  'roleId': roleId.text,
                'type': 'top',
                'uid': userId?.uid,
                'city': selectedCity,
                'accountType': empType,
                'images': downloadUrls,
                'phone': phoneNumber,
                'image': profileDownloadUrl[0]
              });
            } else {


              CustomLoading.cancelLoading();

              await firestore.collection('employees').add({

                'name': nameController.text,
                'password': passController.text,
                'price':priceController.text,
                'email': emailController.text,
                'image': profileDownloadUrl[0],
                'token': token,
                'country': selectedCountry,
                'catEn':enCat,
                'emp': empCatController.text,
                'lat': lat,
                'lng': lng,
                'phone': phoneNumber,
                //  'roleId': roleId.text,
                'type': 'top',
                'uid': userId?.uid,
                'city': selectedCity,
                'accountType': empType,
                'images': downloadUrls,

              });
            }
          }
          sendEmailVerfication();
          Get.offAll(const VerfiedEmailView());
        //  Get.offAllNamed(Routes.LOGIN);
        } catch (e) {
          CustomLoading.cancelLoading();
          print(e.toString());
          print("ERRORS");
        }
        loading = false;
         box.write('roleId', role);
        // box.write('email', emailController.text);
        box.write('name', nameController.text);
        update();
      });
    } catch (e) {
      print(e);
    }
    loading = false;
    CustomLoading.cancelLoading();
    update();
  }

   sendEmailVerfication()async{
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    print("SENT....");
  }


  addNewUser() async {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
    Random random = Random();
    String result = '';
    final box = GetStorage();
    for (int i = 0; i < 12; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(result).set({
        'name': nameController.text,
        'email': emailController.text,
        'id': result,
        'country': selectedCountry,
        'city': selectedCity,
        // ignore: duplicate_ignore
      }).then((value) {
        update();
        // ignore: avoid_print
        print("DONE");
        appMessage(text: 'welcome'.tr, fail: false);
        box.write('user_email', emailController.text);
        box.write('user_name', nameController.text);
        // Get.toNamed('/bottomBar');
      });
    } catch (e) {
      update();
      print(e);
      appMessage(text: "error".tr, fail: true);
    }
  }

  startAddNewFreelancer() async {

    print("ROLEID=====$regRoleId");

    // final box=GetStorage();
    // String roleId=box.read('roleId');
    if (regRoleId == 1) {
      userSignUp();
    } else {
      getCatInEnglish(catValue);
      uploadMultiImageToFirebaseStorage(pickedImageXFiles ?? []).then((value) {
        uploadProfileImageToFirebaseStorage(profilePickedFiles ?? []).then((value) {
        Future.delayed(const Duration(seconds: 2)).then((value) {
          userSignUp();
          //addNewFreelancer();
        });
        });
       
      });
    }
  }

  // addNewFreelancer() async {
  //   final box=GetStorage();
  //   const String chars =
  //       'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)*&1!';
  //   Random random = Random();
  //   String result = '';

  //   for (int i = 0; i < 12; i++) {
  //     result += chars[random.nextInt(chars.length)];
  //   }

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('freelancers')
  //         .doc(result)
  //         .set({
  //       'name': nameController.text,
  //       'email': emailController.text,
  //       'id': result,
  //       'cat': selectedItem,
  //       'city':selectedCity,
  //       'country': selectedCountry,
  //       'images': downloadUrls
  //     }).then((value) {
  //       update();
  //       // ignore: avoid_print
  //       print("DONE");
  //       appMessage(text: 'welcome'.tr, fail: false);
  //        box.write('freelancer_email', emailController.text);
  //       box.write('freelancer_name', nameController.text);
  //       // Get.toNamed('/bottomBar');
  //     });
  //   } catch (e) {
  //     update();
  //     print(e);
  //     appMessage(text: "error".tr, fail: true);
  //   }
  // }

  Future uploadProfileImageToFirebaseStorage(List<XFile> images) async {
    for (int i = 0; i < images.length; i++) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference =
            FirebaseStorage.instance.ref().child('profile/$fileName');
        UploadTask uploadTask = reference.putFile(File(images[i].path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        profileUrl = await taskSnapshot.ref.getDownloadURL();
        profileDownloadUrl.add(profileUrl);
      } catch (e) {
        // Handle any errors that occur during the upload process
        // ignore: avoid_print
        print('Error uploading image to Firebase Storage: $e');
      }
    }
    return profileDownloadUrl;
  }

  Future uploadMultiImageToFirebaseStorage(List<XFile> images) async {
    for (int i = 0; i < images.length; i++) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference =
            FirebaseStorage.instance.ref().child('images2024/$fileName');
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
