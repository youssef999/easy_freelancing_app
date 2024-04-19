



 import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/auth/views/login_view.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';

class VerfiedEmailView extends StatelessWidget {
  const VerfiedEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('', context, false),
      body:Padding(
        padding: const EdgeInsets.all(22.0),
        child: ListView(children: [

          const SizedBox(height: 22,),
          Custom_Text(text: 'checkLink'.tr,
          fontWeight:FontWeight.w800,
            fontSize: 30,
          ),
          const SizedBox(height: 3),
          Custom_Text(text: 'checkLink2'.tr,
            fontWeight:FontWeight.w500,
            fontSize: 15,color:Colors.grey,
          ),
          const SizedBox(height: 33,),
          CustomButton(text: 'loginNow'.tr, onPressed: (){
            Get.off(Routes.LOGIN);
           // Get.off(const LoginView());
          })

        ],),
      )
    );
  }
}
