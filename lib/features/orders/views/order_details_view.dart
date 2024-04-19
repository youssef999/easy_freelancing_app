
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/orders/controllers/order_controller.dart';
import 'package:freelancerApp/features/orders/views/user_change_order.dart';
import 'package:get/get.dart';

class OrderDetailsView extends StatelessWidget {
  Map<String,dynamic>data;

OrderDetailsView({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar:CustomAppBar('orderDetails'.tr, context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children:  [
          const SizedBox(height: 10,),
          orderDataWidget() 
        ]),
      ),
    );
  }
  Widget orderDataWidget(){


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



    OrderController controller=Get.put(OrderController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:BoxDecoration(borderRadius:
        BorderRadius.circular(12),
        color:AppColors.cardColor,
        
        ),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SizedBox(height: 6,),
      
            Custom_Text(text: data['service_name'].toString(),
            fontSize:19,color:AppColors.textColorDark,
            ),
            const SizedBox(height: 6,),
           
            Custom_Text(text: 'notes'.tr,
            color:AppColors.textColorGreyMode,
            ),
            Custom_Text(text: data['notes'].toString(),
            fontSize:19,color:AppColors.textColorDark,
            ),
             const SizedBox(height: 6,),
               Custom_Text(text: 'price'.tr,
            color:AppColors.textColorGreyMode,
            ),
            Custom_Text(text: data['service_price'].toString(),
            fontSize:19,color:AppColors.textColorDark,
            ),
             const SizedBox(height: 6,),
               Custom_Text(text: 'avgTime'.tr,
            color:AppColors.textColorGreyMode,
            ),
              Custom_Text(text: data['task_time'].toString(),
            fontSize:19,color:AppColors.textColorDark,
            ),
             const SizedBox(height: 6,),
               Custom_Text(text: 'status'.tr,
            color:AppColors.textColorGreyMode,
            ),
              Custom_Text(text: status,
            color:AppColors.greenColor,fontWeight:FontWeight.bold,
            ),
             
             const SizedBox(height: 6,),
             Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
          
                 CustomButton(text: 'accept'.tr, onPressed:(){
          
           controller.changeOrderStatus(data['id'], 'accept',
           int.parse( data['service_price'].toString()),
         data['client_email']
           );
          
                 }),
                  CustomButton(text: 'edit'.tr, onPressed:(){
          
          // ignore: avoid_print
          print('edit');
                    Get.to(UserChangeOrderView(
                      data: data,
                    ));
          
                 }),
                  CustomButton(text: 'refuse'.tr, onPressed:(){

                    
          controller.changeOrderStatus(data['id'], 'refuse',
         int.parse( data['service_price'].toString()),
         data['client_email']
          );
                 }),
          
          
             ],)
          
          ]),
        ),
      ),
    );
  }
}