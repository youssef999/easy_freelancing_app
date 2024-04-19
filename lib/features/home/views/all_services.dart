

 import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/home/controllers/all_services_controller.dart';
import 'package:get/get.dart';

import '../../freelancer/freelancer/views/show_service_details.dart';


class AllServicesView extends StatefulWidget {
  const AllServicesView({super.key});

  @override
  State<AllServicesView> createState() => _AllServicesViewState();
}

class _AllServicesViewState extends State<AllServicesView> {
  
  AllServicesController controller=Get.put(AllServicesController());
  
  @override
  void initState() {
   
    controller.getAllServices();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar:CustomAppBar('services'.tr, context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ServicesWidget()
        ],),
      ),
    );
  }

  Widget ServicesWidget(){
    return GetBuilder<AllServicesController>(
      builder: (_) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.89, crossAxisSpacing: 4),
        itemCount:controller.allServiceList.length,
        itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  child: Container(
                    decoration:BoxDecoration(
                      color:AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        SizedBox(
                          height: 120,
                          child:Image.network(controller.allServiceList[index]['image']),
                        ),
                        Custom_Text(text: controller.allServiceList[index]['name'],
                        color:AppColors.textColorDark,fontSize: 19,
                        ),
                        const SizedBox(height: 10,),
                        Custom_Text(text: "${controller.allServiceList
                        [index]['price']} $currency",
                        fontSize: 17,fontWeight:FontWeight.bold,
                          color:AppColors.primary,
                        ),
                      ],),
                    ) ,
                  ),
                  onTap:(){
                    Get.to(ShowServiceDetails(
                      data: controller.allServiceList[index],
                    ));


                  },
                ),
              );
            }
        );
      }
    );
  }
}
