
import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import '../../emp/views/emp_details_view.dart';



class NearEmpView extends StatefulWidget {

  const NearEmpView({super.key});

  @override
  State<NearEmpView> createState() => _AllServicesViewState();
}

class _AllServicesViewState extends State<NearEmpView> {

HomeController controller=Get.put(HomeController());

  @override
  void initState() {
    controller.getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar:CustomAppBar( 'near'.tr, context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            EmpWidget()
          ],),
      ),
    );
  }

  Widget EmpWidget(){

    return GetBuilder<HomeController>(
        builder: (_) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.89, 
                  crossAxisSpacing: 4
                  ),
              itemCount:controller.empFilterList.length,
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
                            child:Image.network(controller.empFilterList[index]['image']),
                          ),
                          Custom_Text(text: controller.empFilterList[index]['name'],
                            color:AppColors.textColorDark,fontSize: 19,
                          ),
                          const SizedBox(height: 10,),
                          Custom_Text(text: "${controller.empFilterList
                          [index]['emp']}",
                            fontSize: 17,fontWeight:FontWeight.bold,
                            color:AppColors.primary,
                          ),
                        ],),
                      ) ,
                    ),
                    onTap:(){

                      Get.to(EmpDetailsView(
                        emp: controller.empFilterList[index]
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
