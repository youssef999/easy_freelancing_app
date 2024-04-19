

// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield.dart';
import 'package:freelancerApp/features/checkout/controllers/checkout_controller.dart';
import 'package:freelancerApp/features/payment/views/pay.dart';
import 'package:get/get.dart';

class CheckOutView2 extends StatefulWidget {

 Map<String,dynamic> data;


  CheckOutView2({super.key,required this.data});

  @override
  State<CheckOutView2> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView2> {

 CheckoutController controller=Get.put(CheckoutController());

  @override
  void initState() {
   controller.getUserName();
   controller.getFreelancerBalance(widget.data['freelancer_email']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      appBar:CustomAppBar(widget.data['name'], context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Column(children: [
           
            Custom_Text(text: widget.data['name'],
            
            color:AppColors.textColorDark,fontSize: 25,
            fontWeight:FontWeight.bold,
            ),

            const SizedBox(height: 3,),
          

             Custom_Text(text: 'mustDealSellerBeforeBuy'.tr,
          
            color:AppColors.textColorGreyMode,fontSize: 16,
            fontWeight:FontWeight.w500,
            ),



            const SizedBox(height: 30,),
          
          Row(
           
            children: [
               const SizedBox(width: 20,),
              Custom_Text(text: 'startFrom'.tr,fontWeight:FontWeight.w700,),
              const SizedBox(width: 20,),
                Custom_Text(text: '${widget.data['price']} $currency',
                color:AppColors.primary,fontSize: 25,fontWeight:FontWeight.bold,
                
                ),
          
            ],
          ),
          
           
           
          ],),
          const SizedBox(height: 13,),
          CustomTextFormField(hint: 'des'.tr, 
          max: 3,
          obs: false,icon:Icons.description
          , controller: controller.desController),
          
          const SizedBox(height: 20,),
          CustomTextFormField(hint: 'price'.tr,icon:Icons.price_change, 
          obs: false,type:TextInputType.number
          , controller: controller.priceController),

          const SizedBox(height: 20,),
          CustomTextFormField(hint: 'avgTime'.tr, 
          icon: Icons.timelapse,type:TextInputType.number,
          obs: false, 
           controller: controller.timeController),

          const SizedBox(height: 20,),
          CustomTextFormField(hint: 'notes'.tr, 
          icon: Icons.notes,
          max: 3,
          obs: false, 
           controller: controller.notesController),


          const SizedBox(height: 11,),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(text: 'sendOffer'.tr, onPressed:(){
  
  Get.to(PayView(data: widget.data,price:
   num.parse(controller.priceController.text),));
           
           
             
            
            
            }),
          )
          


          
          
        ]),
      ),
    );

  }
}