

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/home/controllers/all_services_controller.dart';
import 'package:freelancerApp/features/home/controllers/freelancers_controller.dart';
import 'package:get/get.dart';
import '../../freelancer/freelancer/views/freelancer_details2.dart';
import '../../freelancer/freelancer/views/freelancer_details_view.dart';
import '../../freelancer/freelancer/views/show_service_details.dart';


class AllFreelancersView extends StatefulWidget {

  const AllFreelancersView({super.key});

  @override
  State<AllFreelancersView> createState() => _AllServicesViewState();
}

class _AllServicesViewState extends State<AllFreelancersView> {

  AllFreelancerController controller=Get.put(AllFreelancerController());

  @override
  void initState() {

    controller.getAllFreelancers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar:CustomAppBar('freelancers'.tr, context, false),
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
    return GetBuilder<AllFreelancerController>(
        builder: (_) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.89, crossAxisSpacing: 4),
              itemCount:controller.allFreelancerList.length,
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
                            child:Image.network(controller.allFreelancerList[index]['image']),
                          ),
                          Custom_Text(text: controller.allFreelancerList[index]['name'],
                            color:AppColors.textColorDark,fontSize: 19,
                          ),
                          const SizedBox(height: 10,),
                          Custom_Text(text: "${controller.allFreelancerList
                          [index]['cat']}",
                            fontSize: 17,fontWeight:FontWeight.bold,
                            color:AppColors.primary,
                          ),
                        ],),
                      ) ,
                    ),
                    onTap:(){
                      Get.to(FreelancerDetailsView2(
                        data: controller.allFreelancerList[index],
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
