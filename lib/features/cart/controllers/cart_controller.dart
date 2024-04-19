import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final box = GetStorage();
  String typeFilter = '';
  RxList sliderImagesList = [].obs;
  CarouselSliderController sliderController = CarouselSliderController();
  String index = '';
  String clr = '';
  QueryDocumentSnapshot<Object?>? posts;
  List<DocumentSnapshot> searchResults = [];
  bool isSearching = false;
  final RxList<Color> colors = [
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
  ].obs;
  int? balance = 0; // Variable to store the   void addDataToFirestore() async {
 @override
  void onInit() async {
    posts = Get.arguments;
    super.onInit();
  }


  void addDataToFirestore() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      String userId = user!.uid;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('bag');
      Map<String, dynamic> data = {
        'userId': userId,
        'name': posts?['name'],
        'color': clr,
        'fees': posts?['fees'] ,
        'price': posts?['price'] ,
        'size': index,
        'image_url': posts?['image_url'],
      };
      await collectionReference.add(data);
    } catch (e) {
      print('Error adding data: $e');
    }
  }



 
}
