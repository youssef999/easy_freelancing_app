

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/freelancer/controllers/freelancer_controller.dart';
import 'package:freelancerApp/features/freelancer/freelancer/views/show_service_details.dart';
import 'package:freelancerApp/features/freelancer/service/views/add_service_view.dart';
import 'package:freelancerApp/features/settings/views/change_lang_view.dart';
import 'package:freelancerApp/features/settings/views/change_pass_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../service/views/freelancer_services.dart';

class FreelancerView extends StatefulWidget {
  const FreelancerView({super.key});

  @override
  State<FreelancerView> createState() => _FreelancerViewState();
}

class _FreelancerViewState extends State<FreelancerView> {


FreelancerController controller=Get.put( FreelancerController());
  @override
  void initState() {
    controller.getFreelancerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('', context, true),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 100,right: 20),
      //   child: FloatingActionButton(
      //
      //     backgroundColor: AppColors.primaryDarkColor,
      //     child: Text('+'.tr,
      //
      //       style: GoogleFonts.cairo(color: AppColors.whiteColor,
      //           fontWeight: FontWeight.bold,fontSize: 25),),
      //     onPressed: () {
      //     Get.to(const AddServicesView());
      //   }),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<FreelancerController>(
          builder: (_) {
            return ListView(children:  [
              const SizedBox(height: 12,),
              freelancerDataWidget(),
              const SizedBox(height: 12,),
              freelancerServiceWidget(),
              
            ],);
          }
        ),
      ),
    );
  }

 Widget freelancerDataWidget(){
    FreelancerController controller=Get.put(FreelancerController());
    return SizedBox(
     // height:500,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:controller.freelancerData.length,
          itemBuilder: ((context, index) {
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child:  Column(
                  children: [
                    Container(
                      height: 210,
                      clipBehavior: Clip.antiAlias,
                      decoration:  BoxDecoration(
                          color: const Color.fromARGB(255, 228, 228, 228),
                          borderRadius: BorderRadius.circular(
      
                              25)),
                      child: Image.network(controller.freelancerData
                      [index]['image'],
                        height: 250,
                        width: 300,
                        fit:BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12,),
      
                    Container(
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(12),
                        color:Colors.grey[300]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Custom_Text(text:
                            controller.freelancerData[index]['name'],
                              fontSize: 18,
                              color:AppColors.textColorDark,
                              fontWeight:FontWeight.w600,
                            ),
                            const SizedBox(width: 10,),
                            Custom_Text(text:
                            controller.freelancerData[index]['cat'],
                              fontSize: 18,
                              color:AppColors.primary,
                              fontWeight:FontWeight.w800,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Container(
                      decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(12),
                          color:Colors.grey[300]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Custom_Text(text:
                            'city'.tr,
                              fontSize: 18,
                              color:AppColors.textColorDark,
                              fontWeight:FontWeight.w600,
                            ),
                            const SizedBox(width: 10,),
                            Custom_Text(text:
                            controller.freelancerData[index]['city'],
                              fontSize: 18,
                              color:AppColors.primary,
                              fontWeight:FontWeight.w800,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    InkWell(
                      child: Container(
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(12),
                            color:Colors.grey[300]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Custom_Text(text:
                              'allServices'.tr,
                                fontSize: 18,
                                color:AppColors.textColorDark,
                                fontWeight:FontWeight.w600,
                              ),
                              const SizedBox(width: 10,),
                              IconButton(onPressed: (){
                                Get.to(const FreelancerServicesView());
                              }, icon: Icon(Icons.navigate_next_sharp,
                              color:AppColors.primary,size: 31,
                              ))
                              // Custom_Text(text:
                              // controller.freelancerData[index]['city'],
                              //   fontSize: 18,
                              //   color:AppColors.primary,
                              //   fontWeight:FontWeight.w800,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      onTap:(){
                        Get.to(const FreelancerServicesView());
                      },
                    ),
                    const SizedBox(height: 12,),
                    InkWell(
                      child: Container(
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(12),
                            color:Colors.grey[300]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Custom_Text(text:
                              'changeLang'.tr,
                                fontSize: 18,
                                color:AppColors.textColorDark,
                                fontWeight:FontWeight.w600,
                              ),
                              const SizedBox(width: 10,),
                              IconButton(onPressed: (){
                                Get.to(const ChangeLangView());
                              }, icon: Icon(Icons.navigate_next_sharp,
                                color:AppColors.primary,size: 31,
                              ))
                              // Custom_Text(text:
                              // controller.freelancerData[index]['city'],
                              //   fontSize: 18,
                              //   color:AppColors.primary,
                              //   fontWeight:FontWeight.w800,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      onTap:(){
                        Get.to(const ChangeLangView());
                      },
                    ),
                    const SizedBox(height: 12,),
                    InkWell(
                      child: Container(
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(12),
                            color:Colors.grey[300]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Custom_Text(text:
                              'changePass'.tr,
                                fontSize: 18,
                                color:AppColors.textColorDark,
                                fontWeight:FontWeight.w600,
                              ),
                              const SizedBox(width: 10,),
                              IconButton(onPressed: (){
                                Get.to(const ChangePasswordView());
                              }, icon: Icon(Icons.navigate_next_sharp,
                                color:AppColors.primary,size: 31,
                              ))
                              // Custom_Text(text:
                              // controller.freelancerData[index]['city'],
                              //   fontSize: 18,
                              //   color:AppColors.primary,
                              //   fontWeight:FontWeight.w800,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      onTap:(){
                        Get.to(const ChangePasswordView());
                      },
                    ),
                  ],
                ),
      
      
      
              ),
              onTap:(){

                // Get.toNamed(Routes.SERVICEDETAILS,arguments:controller.freelancerServicesList );
      
                Get.to(ShowServiceDetails(data:
                controller.freelancerServicesList[index],));
      
      
                // Get.to(ShowServiceDetails(post:
                // controller.freelancerServicesList[index], data: {},));
                //
              },
            );
          })),
    );
  }



  Widget freelancerServiceWidget(){
    FreelancerController controller=Get.put(FreelancerController());
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:controller.freelancerServicesList.length,
        itemBuilder: ((context, index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child:  Column(
                children: [
                  Container(
                    height: 250,
                    clipBehavior: Clip.antiAlias,
                    decoration:  BoxDecoration(
                        color: const Color.fromARGB(255, 228, 228, 228),
                        borderRadius: BorderRadius.circular(

                            25)),
                    child: Image.network(controller.freelancerServicesList
                    [index]['image'],
                      height: 250,
                      width: 300,
                      fit:BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5,),

                  Custom_Text(text:
                  controller.freelancerServicesList[index]['name'],
                    fontSize: 18,
                    color:AppColors.textColorDark,
                    fontWeight:FontWeight.w600,
                  ),
                  const SizedBox(height: 5,),
                ],
              ),



            ),
            onTap:(){


              // Get.toNamed(Routes.SERVICEDETAILS,arguments:controller.freelancerServicesList );

              Get.to(ShowServiceDetails(data:
              controller.freelancerServicesList[index],));


              // Get.to(ShowServiceDetails(post:
              // controller.freelancerServicesList[index], data: {},));
              //
            },
          );
        }));
  }
}

