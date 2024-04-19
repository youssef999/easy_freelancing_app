// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield2.dart';
import 'package:freelancerApp/features/wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(WalletController());
    return Scaffold(
      appBar:CustomAppBar('wallet'.tr, context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<WalletController>(
          builder: (_) {
            return ListView(children: [
              const SizedBox(height: 10,),
              Custom_Text(text: 'wallet'.tr,
              fontSize:25,fontWeight: FontWeight.w600,
              ),
            
              const SizedBox(height: 10,),
            
              Custom_Text(text: controller.totalBalance.toString()+" "+currency,
              fontSize:25,fontWeight: FontWeight.w900,
              ),
            
              const SizedBox(height: 20,),
            
            
              Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(12),
                  color:AppColors.cardColor
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextFormField(hint: 'enterAmount'.tr, obs: false
                      , controller: controller.amountController,
                      validateMessage:'enterAmount'.tr,
                      icon:Icons.money,
                      ),
                      const SizedBox(height: 22,),
                  CustomTextFormField(hint: 'enterEmail'.tr, obs: false
                  , controller: controller.emailController,
                  icon:Icons.email,
                  validateMessage:'enterEmail'.tr,
                  ),
                    ],
                  ),
                ),
              ),
            
              
            
              const SizedBox(height: 12,),
            
            
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(text: 'requestMoney'.tr, onPressed: (){
               
                if(controller.totalBalance>10){
               controller.sendRequestMoney();
                }else{

                  appMessage(text: 'minRequest'.tr, fail: false);
               
                }
                
               
                }),
              )
            
            
            
            
            
            
            
            
                       
            ]);
          }
        ),
      ),
    );
  }
}