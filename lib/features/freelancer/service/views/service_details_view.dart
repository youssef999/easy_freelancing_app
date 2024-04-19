
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/service/controllers/add_services_controller.dart';
import 'package:freelancerApp/features/freelancer/service/views/edit_service.dart';
import 'package:get/get.dart';

import '../../../../core/resources/app_colors.dart';

// ignore: must_be_immutable
class ServiceDetailsView extends StatelessWidget {
  Map<String,dynamic>service;

 ServiceDetailsView({super.key,required this.service});

  @override
  Widget build(BuildContext context) {
    AddServiceController controller=Get.put(AddServiceController());
    return Scaffold(
      appBar:CustomAppBar('', context, false),
      body:Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView(children: [
          Image.network(service['image'],
            fit:BoxFit.cover,
          ),
          const SizedBox(height: 7,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Custom_Text(text: service['name'],color:AppColors.textColorDark,fontSize: 15,),
              const SizedBox(height: 7,),
          Custom_Text(text: service['description'],color:AppColors.textColorGreyMode,fontSize: 15,),
           const SizedBox(height: 7,),
           Row(
            mainAxisAlignment:MainAxisAlignment.center,
             children: [
               Custom_Text(text: service['price'].toString(),
               color:AppColors.textColorDark,fontSize: 20,),


                 Custom_Text(text: currency,
               color:AppColors.primary,fontSize: 17,),
             ],
           ),
            const SizedBox(height: 7,),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [

                CustomButton(text: 'edit'.tr, onPressed: (){

        Get.to( EditServicesView(data: service

        ));


                }),
                const SizedBox(width: 10,),

                 CustomButton(text: 'delete'.tr, onPressed: (){

controller.deleteService(service['service_id']);
                  
                  
                })

            ],)
             
              ],
            ),
          ),
         
        ]),
      ),
    );
  }
}