
// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/orders/controllers/order_controller.dart';
import 'package:freelancerApp/features/freelancer/orders/widgets/order_widget.dart';
import 'package:get/get.dart';

class OrderRequestView extends StatefulWidget {
  const OrderRequestView({super.key});

  @override
  State<OrderRequestView> createState() => _OrderRequestViewState();
}

class _OrderRequestViewState extends State<OrderRequestView> {

  OrderController controller=Get.put(OrderController());


  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        return Scaffold(
          appBar:CustomAppBar('orderRequest'.tr, context, true),
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

    if(controller.orderList.isEmpty) {

     return Center(
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
    }else{
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
}