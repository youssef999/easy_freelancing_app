import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/app_colors.dart';



appMessage({required String text,required bool fail}){

 if(fail==true){
  Get.snackbar ("   $text ", '',colorText:AppColors.textColorLight,
      backgroundColor:Colors.red.withOpacity(0.5),
      duration: const Duration(seconds: 3),
      icon:const Icon(Icons.error_outline_outlined,
        color:Colors.cyanAccent,size:33,)
  );
 }else{
 Get.snackbar ("   $text ", '',colorText:AppColors.textColorLight,
      backgroundColor:AppColors.primary.withOpacity( 0.5),
      duration: const Duration(seconds: 3),
      icon:const Icon(Icons.app_shortcut,
        color:Colors.purple,size:33,)
  );
 }
}