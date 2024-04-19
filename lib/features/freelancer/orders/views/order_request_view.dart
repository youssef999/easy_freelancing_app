
// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/orders/controllers/order_controller.dart';
import 'package:freelancerApp/features/freelancer/orders/widgets/order_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderRequestView extends GetView<OrderController> {
  const OrderRequestView({super.key});

  @override
  Widget build(BuildContext context) {

    OrderController controller=Get.put(OrderController());
  


    return GetBuilder<OrderController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors.mainly,
          appBar:CustomAppBar('orderRequest'.tr, context, false),
          body:ListView(children:  [
            const SizedBox(height: 11,),
            OrderWidgetFromFirebase(controller: controller),
          ]
          ),
        );
      }
    );
  }
}

class OrderWidgetFromFirebase extends StatelessWidget {
  
  OrderController controller;
 
  OrderWidgetFromFirebase({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:controller.orderList.length,
          itemBuilder: (context, index) {
        return OrderCardWidget(data:controller.orderList[index],controller:controller);
        });
      }
    );
  }
}