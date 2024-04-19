
import 'package:freelancerApp/core/resources/app_assets.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield2.dart';
import 'package:freelancerApp/features/auth/views/register_view2.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/Custom_Text.dart';
import '../controllers/users_controller.dart';


class UsersView extends GetView<UsersController> {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
     appBar: CustomAppBar('Users',context,true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(21),
                      color:AppColors.lightColor
                  ),
                  height: 210,
                  width:MediaQuery.of(context).size.width,
                  child:Image.asset(AppAssets.logo,
                    //    fit:BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Custom_Text(text: 'sign'.tr,
                  color:AppColors.greyColor,
                  fontSize: 15,fontWeight:FontWeight.w500,
                ),
              ),
              const SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.only(top:3.0,left:22,right:22),
                child: SizedBox(
                  height:82,
                  child: CustomTextFormField(
                    hint: 'email'.tr,
                    obx: false,
                    type: TextInputType.emailAddress,
                    icon:Icons.email,
                    obs: false,
                    color: AppColors.textColorDark,
                    controller: controller.emailController,),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top:18.0,left:22,right:22),
                child: CustomTextFormField(
                    hint: 'password'.tr,
                    obx: true,
                    type: TextInputType.visiblePassword,
                    obs: true,
                    color: AppColors.textColorDark,
                    controller: controller.passController),
              ),
              GetBuilder<UsersController>(
                  builder: (_) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 11,
                        ),
                        (controller.loading=true)?
                        CustomButton(
                            text: 'login'.tr,
                            onPressed: () {
                              controller.userLogin();
                            },
                          ):const Center(
                          child:CircularProgressIndicator(),
                        )
                      ],
                    );
                  }
              ),


              const SizedBox(
                height: 16,
              ),

              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Custom_Text(
                        text: 'forgotPassword'.tr,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center,
                        color: Colors.black
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Custom_Text(
                      text: 'reset'.tr,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      color: Colors.grey,
                    ),
                  ],
                ),
                onTap: () {
                 // Get.to(const ForgotPassView());
                },
              ),
              const SizedBox(
                height: 17,
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Custom_Text(
                      text: 'dontHaveAccount'.tr,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Custom_Text(
                      text: 'signup'.tr,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      color: Colors.black,
                    ),
                  ],
                ),
                onTap: () {
                Get.to( const SignUpView());
                },
              ),
              const SizedBox(
                height: 19,
              ),

              const SizedBox(
                height: 19,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
