

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Core/const/app_message.dart';

class SettingsController extends GetxController{


  TextEditingController passController = TextEditingController();
  TextEditingController checkPassController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  void changeLang(String codeLang){
    final box=GetStorage();
    Locale currentLocal=Locale(codeLang);
    Get.updateLocale(currentLocal);
    box.write('locale', codeLang);
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
      appMessage(text: 'كلمة المرور غير متطابقة او عددها اقل من 6 ', fail: true);
    }
  }

}