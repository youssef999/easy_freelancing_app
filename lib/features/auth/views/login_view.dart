// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/widgets/custom_loading.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield.dart';
import 'package:freelancerApp/features/auth/controllers/auth_controller.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/app_colors.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loginFormKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.mainly,
      appBar: null,
      body: Form(
        key: controller.loginFormKey,
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Column(children: [
                Container(
                  width: 350,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: Image.asset(
                    'assets/images/logo.jpeg',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),  Text('login'.tr,
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDarkColor,
                      )) ,const SizedBox(
                  height: 20,
                ), 
              ]),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: AppColors.primaryDarkColor,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Column(
                  children: [
                    CustomTextFormField(
                        hint: 'email'.tr,
                        obs: false,
                        color: AppColors.textColorDark,
                        validateMessage: 'wrongEmail'.tr,
                        controller: controller.emailController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        hint: 'password'.tr,
                        obs: true,
                        color: AppColors.textColorDark,
                        validateMessage: 'wrongPass'.tr,
                        obx: true,
                        controller: controller.passController),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 7,
                          fixedSize: const Size(300, 60),
                          shadowColor: AppColors.darkColor,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.1, color: AppColors.darkColor),
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColors.whiteColor),
                      child: Text(
                        "login".tr,
                        style: const TextStyle(
                          color: AppColors.primaryDarkColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {

                        CustomLoading.showLoading('Loading');
                        
                        controller.getRoleIdByUser().then((value) {
                          print("role id done");
                          Future.delayed(const Duration(seconds: 2))
                              .then((value) {
                          
                            {
                              controller.userLogin();
                            }
                            
                          });
                        });
                      },
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 200,
                        ),
                        // TextButton(
                        //     onPressed: () {
                        //       print("heeee");
                        //     },
                        //     child: Text(
                        //       'forgotPassword'.tr,
                        //       style: TextStyle(color: AppColors.darkColor),
                        //     )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      'or'.tr,
                      style:
                          const TextStyle(color: AppColors.redColor, fontSize: 20),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "dontHaveAccount".tr,
                          style: TextStyle(
                              fontSize: 15, color: AppColors.textColorLight),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: Text(
                            'register'.tr,
                            style:  const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
