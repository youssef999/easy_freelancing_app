

 import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield2.dart';
import 'package:freelancerApp/features/freelancer/orders/controllers/change_order_controller.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class UserChangeOrderView extends StatelessWidget {
  
  Map<String,dynamic>data;
 
   UserChangeOrderView({super.key,required this.data,});

  @override
  Widget build(BuildContext context) {
    ChnageOrderController controller=Get.put(ChnageOrderController());
    return Scaffold(
      appBar:CustomAppBar('', context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const SizedBox(height: 12,),

          Custom_Text(text: 'editDataAndSendToFreelancer'.tr,
          fontSize:20,color:AppColors.textColorDark,fontWeight:FontWeight.w600,
            alignment:Alignment.center,
          ),
          const SizedBox(height: 12,),


          Container(
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(13),
              color:Colors.grey[100]
            ),

            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(children: [


                const SizedBox(height: 12,),

                Row(
                  children: [
                    Text('servicePrice'.tr,),
                  ],
                ),
                CustomTextFormField(hint: data['service_price'].toString(),
                    obs: false, color: AppColors.textColorDark
                    ,icon:Icons.price_check_sharp
                    , controller: controller.priceController),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Text('taskTime'.tr,),
                  ],
                ),
                CustomTextFormField(hint: data['task_time'].toString(),
                    icon:Icons.timelapse,
                    obs: false, color: AppColors.textColorDark
                    , controller: controller.timeController),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Text('notes'.tr,),
                  ],
                ),
                CustomTextFormField(hint: 'notes'.tr,
                    icon:Icons.notes,max: 7,
                    obs: false, color: AppColors.textColorDark
                    , controller: controller.noteController),
                const SizedBox(height: 15,),

                CustomButton(text: 'updateData'.tr, onPressed: (){

             controller.changeOrderData(data['id']);

                }),
                const SizedBox(height: 55,),

              ],),
            ),
          )

          
        ],),
      ),
    );
  }
}
