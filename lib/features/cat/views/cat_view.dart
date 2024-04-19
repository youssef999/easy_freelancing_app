


import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/cat/controller/cat_controller.dart';
import 'package:freelancerApp/features/cat/views/cat_service_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CatView extends StatefulWidget {
  const CatView({super.key});

  @override
  State<CatView> createState() => _CatViewState();
}

class _CatViewState extends State<CatView> {


  CatController controller=Get.put(CatController());
  @override
  void initState() {
    controller.getAllCat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('selectCat'.tr, context,false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ServicesWidget(),
          ],
        ),
      ),
    );
  }

  Widget ServicesWidget(){

    final box=GetStorage();
    String lang=box.read('locale');
    String name='name';
    if(lang=='ar'){
      name='nameAr';
    }else{
      name='name';
    }
    return GetBuilder<CatController>(
      builder: (_) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.89, crossAxisSpacing: 4),
        itemCount:controller.catList.length,
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
                          child:Image.network(controller.catList[index]['image']),
                        ),
                        Custom_Text(text: controller.catList[index][name],
                        color:AppColors.textColorDark,fontSize: 19,
                        ),
                        const SizedBox(height: 10,),
                      
                      ],),
                    ) ,
                  ),
                  onTap:(){

                    Get.to(CatServicesView(
                      data:controller.catList[index],
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