// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, duplicate_ignore, unused_local_variable
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/orders/controllers/order_controller.dart';
import 'package:freelancerApp/features/orders/views/task_done_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyOrderView extends StatefulWidget {

  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {

//
UserOrderController controller=Get.put(UserOrderController());

  @override
  void initState() {
    // ignore: avoid_print
    print("HERE");
    controller.getUserOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar('myOrders'.tr, context, true),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListView(children: [
          const SizedBox(height: 11),
          GetBuilder<UserOrderController>(
              init: UserOrderController(),
              builder: (_) {
                return UserOrderWidget();
              })
        ]),
      ),
    );
  }
}

Widget UserOrderWidget(){
  
  UserOrderController controller=Get.put(UserOrderController());

 String status='';

 Color statusColor=AppColors.primary;

  if(controller.orderList.isNotEmpty) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.orderList.length,
        itemBuilder: (context, index) {
          if( controller.orderList[index]['order_status']=='pending'){
            status='pending'.tr;
          }
          else if( controller.orderList[index]['order_status']=='accept'){
            status='accept'.tr;
            statusColor=AppColors.success;
          }
          else if( controller.orderList[index]['order_status']=='refuse'){
            status='refused'.tr;
            statusColor=AppColors.failed;
          }

          else if( controller.orderList[index]['order_status']=='Done'){

            status='taskFinish'.tr;
            statusColor=AppColors.success;
          }

          else{
            status=controller.orderList[index]['order_status'];
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 6.0, right: 6),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.mainly),
              child: Column(children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    controller.orderList[index]['service_image'],
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Custom_Text(
                        text: status,

                        // controller.orderList[index]['status'],
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color:status == 'refused'.tr ? Colors.red : Colors.green),
                  ),
                ),
                Custom_Text(
                  text: controller.orderList[index]['service_name'],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: duplicate_ignore
                  children: [
                    // ignore: prefer_interpolation_to_compose_strings
                    Custom_Text(
                      text: 'freelancer'.tr + " : ",
                      fontSize: 15,
                      color: Colors.black,
                    ),

                    Custom_Text(
                      text: controller.orderList[index]['freelancer_name'],
                      fontSize: 15,
                      color: Colors.black,
                    ),

                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: prefer_interpolation_to_compose_strings
                    Custom_Text(
                      text:
                      DateFormat.yMMMMEEEEd(Get.locale.toString()).format(
                        DateTime.parse(
                            controller.orderList[index]['date'].toString())
                            .toLocal(),
                      ),
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                (controller.orderList[index]['order_status'] == 'accept')?
                SizedBox(
                  width:210,
                  child: CustomButton(text: 'taskDone'.tr,
                      onPressed: (){

                        Get.to( TaskDoneView(data:controller.orderList[index]));

                      }),
                ):const SizedBox(),
                const SizedBox(
                  height: 16,
                ),

              ]),
            ),
          );
        });
  }
  else{
    return   Center(
      child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(child: Image.asset('assets/images/order_empty.webp')),
            const SizedBox(height: 11,),
            Custom_Text(text: 'noOrders'.tr,
              fontWeight:FontWeight.w700,
              fontSize: 25,alignment:Alignment.center,
            )
          ],
        ),
      ),
    );
  }

}
