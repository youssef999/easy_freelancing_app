import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/service/controllers/freelancer_services_controller.dart';
import 'package:freelancerApp/features/freelancer/service/views/add_service_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/service_card_widget.dart';

class FreelancerServicesView extends StatefulWidget {

  const FreelancerServicesView({super.key});

  @override
  State<FreelancerServicesView> createState() => _FreelancerServicesViewState();
}

class _FreelancerServicesViewState extends State<FreelancerServicesView> {
  final controller = Get.put(FreelancerServicesController());

  @override
  void initState() {
    controller.getAllServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100,right: 20),
        child: FloatingActionButton(
          
          backgroundColor: AppColors.primaryDarkColor,
          child: Text('+'.tr,

            style: GoogleFonts.cairo(color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,fontSize: 25),),
          onPressed: () {
          Get.to(const AddServicesView());
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: CustomAppBar('myServices'.tr, context, true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<FreelancerServicesController>(
          builder: (_) {
            return ListView(children: [


             ( controller.serviceList.isNotEmpty)?
              GetBuilder<FreelancerServicesController>(builder: (_) {
                return GridView.builder(
                    itemCount: controller.serviceList.length,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.89, crossAxisSpacing: 4,


                        //mainAxisExtent: 1
                        ),
                    itemBuilder: (context, index) {
                      return ServiceCardWidget(data: controller.serviceList[index]);
                    });
              }):Column(
               children: [
                 const SizedBox(height:16,),
                 SizedBox(
                   height: 150,
                   width: MediaQuery.of(context).size.width/2,
                   child:Image.asset('assets/images/noServ.jpeg',
                     fit: BoxFit.fill,
                   ),
                 ),
                 const SizedBox(height:16,),
                 Custom_Text(text: 'noService'.tr,
                 fontSize:26,alignment:Alignment.center,
                   fontWeight:FontWeight.w700,
                 )
               ],
             )
            ]);
          }
        ),
      ),
    );
  }
}
