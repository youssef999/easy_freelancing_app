



import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/features/settings/controller/settings_controller.dart';
import 'package:freelancerApp/features/splash/splash_view.dart';
import 'package:get/get.dart';
import '../../../../Core/widgets/Custom_Text.dart';
import '../../../core/widgets/custom_app_bar.dart';


class ChangeLangView extends StatelessWidget {
  const ChangeLangView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller=Get.put(SettingsController());
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar:CustomAppBar('', context, false),
      body:Column(
        children: [
          const SizedBox(height: 22,),
          Custom_Text(text: 'changeLang'.tr,
            color:AppColors.primary,
            fontSize: 26,fontWeight:FontWeight.w900,
          ),
          const SizedBox(height: 21,),
          ProfileMenu(
            icon: "assets/images/arabic.svg",
            text: 'العربية ',
            press: () {
              controller.changeLang('ar');
              Get.offAll(const SplashView());

            },
          ),
          const SizedBox(height: 10,),
          ProfileMenu(
            icon: "assets/images/english-11.svg",
            text: 'English',
            press: () {
              controller.changeLang('en');
              Get.offAll(const SplashView());

            },
          ),
          const SizedBox(height: 21,),
          ProfileMenu(
            icon: "assets/images/fr.svg",
            text: 'francais',
            press: () {
              controller.changeLang('fr');
              Get.offAll(const SplashView());

            },
          ),


          // InkWell(
          //   child: ProfileCardWidget(
          //       icon:LineIcons.values['arabic']!,
          //     txt: 'English'
          //   ),
          //   onTap:(){
          //     controller.changeLang('en');
          //     Get.offAll(const MainHome());
          //   },
          // ),
          // InkWell(
          //   child: ProfileCardWidget(
          //       icon:LineIcons.values['instagram']!,
          //       txt: 'العربية '
          //   ),
          //   onTap:(){
          //     controller.changeLang('ar');
          //     Get.offAll(const MainHome());
          //   },
          // )
        ],
      ),
    );
  }

  Widget ProfileCardWidget({required IconData icon,required String txt}){

    return Padding(
      padding: const EdgeInsets.only(top:31,left: 18.0,right: 18),
      child: Container(
        height:77,
        decoration:BoxDecoration(
            color:AppColors.greyColor,
            borderRadius:BorderRadius.circular(18)
        ),
        child:Row(
          children: [
            const SizedBox(width: 20,),
            Icon(icon,size:33,color:Colors.blue,),
            const SizedBox(width: 20,),
            Custom_Text(text: txt,fontSize:21,alignment:Alignment.center,),
            const SizedBox(width: 20,),
            const Icon(Icons.arrow_forward_ios,color:Colors.black,
              size:32,
            )
          ],
        ),
      ),
    );
  }


}


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key ? key,
    @required this.text,
    @required this.icon,
    @required this.press,
    Null Function()? onpress,
  }) : super(key: key);
  final String ? text, icon;
  final VoidCallback ? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Container(
        height: 70,
        decoration:BoxDecoration(
            color:Colors.grey[300],
            borderRadius:BorderRadius.circular(16)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child:
        InkWell(
          onTap:press,
          child: Row(
            children: [
              SvgPicture.asset(
                  icon!,
                  width: 27,
              //    color: AppColors.redColor
              ),
              const SizedBox(width: 33),
              Expanded(
                  child: Text(
                    text!,
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  )),
              // Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

