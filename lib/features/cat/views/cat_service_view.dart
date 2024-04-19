
// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/cat/controller/cat_controller.dart';
import 'package:freelancerApp/features/freelancer/freelancer/views/freelancer_details2.dart';
import 'package:freelancerApp/features/freelancer/freelancer/views/freelancer_details_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CatServicesView extends StatefulWidget {

 Map<String,dynamic> data;

 CatServicesView({super.key,required this.data});

  @override
  State<CatServicesView> createState() => _CatServicesViewState();
}

class _CatServicesViewState extends State<CatServicesView> {

  CatController controller=Get.put(CatController());

  @override
  void initState() {

    final box=GetStorage();
    String locale=box.read('locale');
    if(locale=='ar'){
      controller.getCatServices( widget.data['nameAr']);
    }else{
      controller.getCatServices( widget.data['name']);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(widget.data['nameAr'], context, false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 13,),
            GetBuilder<CatController>(
              builder: (_) {
                return ServicesWidget();
              }
            )

          ],
        ),
      ),
    );
  }

  Widget ServicesWidget(){

    if(controller.serviceCatList.isEmpty){
return Center(
  child:Column(children: [
    const SizedBox(
      height: 11,
    ),
    SizedBox(
      height: 188,
      child:Image.asset('assets/images/noServ.jpeg',
      fit:BoxFit.fill,
      ),
    ),
    const SizedBox(height: 22,),
    Custom_Text(text: 'noServices'.tr,
    color:AppColors.textColorDark,fontSize: 19,
    ),

  ],),
);
    }else{
 return GetBuilder<CatController>(
      builder: (_) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.89, crossAxisSpacing: 4),
        itemCount:controller.serviceCatList.length,
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
                          child:Image.network(controller.serviceCatList[index]['image']),
                        ),
                        Custom_Text(text: controller.serviceCatList[index]['name'],
                        color:AppColors.textColorDark,fontSize: 19,
                        ),
                        const SizedBox(height: 10,),
                      
                      ],),
                    ) ,
                  ),
                  onTap:(){

                    Get.to(FreelancerDetailsView2(data: 
                    controller.serviceCatList[index]));
                   
                  },
                ),
              );
            }
        );
      }
    );
  }
    }
   

}