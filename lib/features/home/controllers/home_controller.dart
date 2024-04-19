// ignore_for_file: avoid_print, duplicate_ignore, unnecessary_brace_in_string_interps

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {


  final box = GetStorage();
  String typeFilter = '';
  RxList sliderImagesList = [].obs;
  CarouselSliderController sliderController = CarouselSliderController();

  RxList<DocumentSnapshot> searchResults = <DocumentSnapshot>[].obs;
  Rx<bool> isSearching = false.obs;
  List<Map<String,dynamic>>empList=[];
  List<Map<String,dynamic>>empFilterList=[];
  
  final RxList<Color> colors = [
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
  ].obs;

  int? balance = 0; // Variable to store the balance
  Future<QuerySnapshot<Map<String, dynamic>>> getUserDataByEmail(
      String email) async {
    final userRef = FirebaseFirestore.instance.collection('users');
    return await userRef.where('email', isEqualTo: email).get();
  }


TextEditingController searchController=TextEditingController();
  Future<void> searchProducts(String keyword) async {
    if (keyword.isEmpty) {
      clearSearch();
      return;
    }
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('services')
        .where('name', isGreaterThanOrEqualTo: keyword)
        .get();
        
      searchResults.value = snapshot.docs;
      
print('qwe ${searchResults}');
      isSearching.value = true;
    update();
  }

  void clearSearch() {
      searchResults.clear();
      isSearching.value = false;
   update();
  }

  RxMap<String, dynamic>? userData = <String, dynamic>{}.obs;
  void data() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String? email = currentUser?.email;

    if (email != null) {
      final snapshot = await getUserDataByEmail(email);
      if (snapshot.docs.isNotEmpty) {
        if (kDebugMode) {
          print('BBBBBBBBBBBBBBBBBBBBB ${snapshot.docs.first.data()}');
        }
        userData?.value = snapshot.docs.first.data();
        box.write('roleId',userData?['roleId']);
        print('cccoccoooo');
        update();
      }
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late Stream<String> progressString;
  late String res;
  bool downloading = false;
  bool isDisable = true;

  Future<void> dowloadImage(BuildContext context, String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    progressString.listen((data) {
      res = data;
      downloading = true;
    }, onDone: () async {
      downloading = false;

      print("Task Done");

      downloading = false;

      isDisable = false;
      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text(
          'Image Set To Wallpaper Successfully',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFe91e63),
      ));
      print("Task Done");
      Get.back();
    }, onError: (error) {
      downloading = false;
      isDisable = true;
      print("Some Error");
    });
  }

  Future<void> fetchSliderImages() async {
    QuerySnapshot snapshot = await firestore.collection('advertise').get();
    sliderImagesList.value = snapshot.docs.map((doc) => doc['image']).toList();
    update();
  }

  void updateData(String docId) {
    DocumentReference docRef = firestore.collection('user').doc(docId);
    docRef.update({'price': 0, 'lock': false}).then((value) {
      if (kDebugMode) {
        print("Document updated successfully");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to update document: $error");
      }
    });
  }


  @override
  void onInit() async {
    getCurrentLocation();
    await fetchSliderImages();
    data();
    searchResults();

    super.onInit();
  }

Position? currentPosition;
double currentLat=0.0;
double currentLong=0.0;

getCurrentLocation()async{
  try {
      // Request permission to access the device's location
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle accordingly
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied, take users to settings
        return;
      }
      // Get the current position
      Position position = await Geolocator.getCurrentPosition();
        currentPosition = position;
        currentLat=currentPosition!.latitude;
        currentLong=currentPosition!.longitude;
        
      update();
    } catch (e) {
      print(e);
    }
    print("LAT===$currentLat");
    print("lng==$currentLong");
     getEmployess();

}

    getEmployess() async {
    
     empList= [];
     empFilterList=[];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('employees')
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

    empList= data;
    for(int i=0;i<empList.length;i++){
     
     calculateDistance(currentLat, currentLong, empList[i]['lat'],
       empList[i]['lng']);
       print('distance==$distance');
       if(distance<10){
        empFilterList.add(empList[i]);
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
    // ignore: prefer_interpolation_to_compose_strings
    print("EMPLIST==="+empList.toString());
    update();
  }


 double distance =0;
  static const double earthRadius = 6371.0; // Earth radius in kilometers

  static double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }
 calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {

        print("startLat=="+startLat.toString());
        print("startLng=="+startLng.toString());
        print("endLat=="+endLat.toString());
        print("endLng=="+endLng.toString());

    double dLat = degreesToRadians(endLat - startLat);
    double dLng = degreesToRadians(endLng - startLng);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRadians(startLat)) *
            cos(degreesToRadians(endLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
   distance = earthRadius * c;

   print("D=="+distance.toString());
   update(); // Distance in kilometers

   // return distance;
  }
}


