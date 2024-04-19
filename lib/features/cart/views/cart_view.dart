import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/cart/controllers/cart_controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 255, 255, 255),
      appBar: CustomAppBar('Cart', context, false),
      body: Scaffold(
          backgroundColor: AppColors.mainly,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
            
              ],
            ),
          )),
    );
  }
}
