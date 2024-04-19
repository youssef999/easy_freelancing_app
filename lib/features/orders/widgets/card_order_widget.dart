



import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/features/freelancer/orders/views/change_order_view.dart';
import 'package:freelancerApp/features/freelancer/service/views/service_details_view.dart';
import 'package:get/get.dart';

import '../../../../core/const/constant.dart';
import '../controllers/order_controller.dart';

// ignore: must_be_immutable
class UserCardCardWidget extends StatelessWidget {
  Map<String,dynamic> data;
 UserOrderController   controller;

UserCardCardWidget({super.key,required this.data,required this.controller});

  @override
  Widget build(BuildContext context) {
    String status='';
    if(data['order_status']=='pending'){
      status='pending'.tr;
    }
    if(data['order_status']=='accept'){
      status='approved'.tr;
    }
    if(data['order_status']=='refuse'){
      status='declined'.tr;
    }


    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:BoxDecoration(
             boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
            borderRadius: BorderRadius.circular(11),
            color: AppColors.cardColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child:Image.network(data['service_image'],
                    fit:BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 7,),
                Custom_Text(text: data['service_name'],
                  color:AppColors.textColorDark,fontSize: 15,
                fontWeight:FontWeight.w600,
                ),
                const SizedBox(height: 7,),
                sampleCardData('from'.tr,data['user_name']),
                const SizedBox(height: 7,),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Custom_Text(text: data['order_des'],
                color:AppColors.greyColor,fontSize:15,
                ),
              ),
                const SizedBox(height: 7,),
                sampleCardData('date'.tr,data['date']),
                const SizedBox(height: 7,),
                sampleCardData('taskTime'.tr,data['task_time']+ ' '+days),
                const SizedBox(height: 7,),
                sampleCardData('price'.tr,'${data['service_price']} $currency'),
                const SizedBox(height: 7,),
                sampleCardData('status'.tr,status),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [

                      (data['order_status']!='refuse'
                      || data['order_status']!='accept'
                      )?
                    CustomButton(text: 'refuse'.tr, onPressed:(){
                      // controller.changeOrderStatus(data['order_id'],
                      // 'refuse'
                      // );
                    }):const SizedBox(),


                  // (data['order_status']!='refuse')?
                    CustomButton(text: 'edit'.tr, onPressed:(){

                      Get.to(ChangeOrderView(data: data,
        
                       ));

                    }
                    ),
                    //:const SizedBox(),

                 (data['order_status']!='accept')?
                    CustomButton(text: 'accept'.tr, onPressed:(){

                      // controller.changeOrderStatus(data['order_id'],
                      //     'accept'
                      // );
                    }):const SizedBox(),
                  ],),
                ),
                const SizedBox(height: 20,),
              

              
              
                //sampleCardData('des'.tr,data['order_des']),
              
              ]),
            ),
          )
        ),
      ),
      onTap:(){
       //Get.to(ServiceDetailsView(service: data));
      },
    );
  }
}
Widget sampleCardData(String txt1,String txt2){
  return   Row(
    children: [
      const SizedBox(width: 14,),
      Text(txt1,style: TextStyle(
          color:AppColors.textColorGreyMode,fontSize:18
      ),),
      const SizedBox(width: 10,),

      Custom_Text(text: txt2,color:AppColors.primary,fontSize: 16,
      fontWeight:FontWeight.bold,
      ),
    ],
  );
}