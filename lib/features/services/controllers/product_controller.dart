import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
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
    getServiceRate();

  }
  double finalRate=0;
  getServiceRate(){

   print(".............SERVICE RATES ........");
   List rateList=posts!['rate'];
   num rateValue=0;

   for(int i=0;i<rateList.length;i++){
     rateValue=num.parse(rateList[i].toString())+rateValue;
   }

   finalRate =rateValue/(rateList.length);
   print('RATES=======$rateValue');
   print("Final=====$finalRate");
   update();
  }






 
}
