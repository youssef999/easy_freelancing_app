// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:get_storage/get_storage.dart';

buildBottomNavigationMenu(context, bottomNavBarController) {

  final box=GetStorage();
  String roleId=box.read('roleId')??'1';

  if(roleId=='1'){
    return BottomAppBar(
      elevation: 0,
      color: AppColors.transparent,
      child: Container(
        height: 64,
        margin: const EdgeInsets.only(
          left: 24 * 0.7,
          right: 24 * 0.7,
          bottom: 24 * 0.2,
        ),
        decoration: BoxDecoration(
            color: AppColors.primaryBGLightColor,
            borderRadius: BorderRadius.circular(10 * 3.22)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            bottomItemWidget('assets/icon/home.svg', bottomNavBarController, 0,
                AppColors.transparent),

            bottomItemWidget('assets/icon/messagetext.svg',
                bottomNavBarController, 1, AppColors.transparent),


            bottomItemWidget('assets/icon/torch.svg', bottomNavBarController, 2,
                AppColors.transparent),


            bottomItemWidget('assets/icon/profile.svg', bottomNavBarController, 3,
                AppColors.whiteColor.withOpacity(0.1)),

            // bottomItemWidget('assets/icon/my_gift.svg', bottomNavBarController, 3,
            //     AppColors.transparent),

          ],
        ),
      ),
    );
  }else{

    return BottomAppBar(
      elevation: 0,
      color: AppColors.transparent,
      child: Container(
        height: 64,
        margin: const EdgeInsets.only(
          left: 24 * 0.7,
          right: 24 * 0.7,
          bottom: 24 * 0.2,
        ),
        decoration: BoxDecoration(
            color: AppColors.primaryBGLightColor,
            borderRadius: BorderRadius.circular(10 * 3.22)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            bottomItemWidget('assets/icon/home.svg', bottomNavBarController, 0,
                AppColors.transparent),

            bottomItemWidget('assets/icon/messagetext.svg',
                bottomNavBarController, 1, AppColors.transparent),

            bottomItemWidget('assets/icon/cross.svg', bottomNavBarController, 2,
                AppColors.transparent),



            bottomItemWidget('assets/icon/details.svg', bottomNavBarController, 3,
                AppColors.transparent),

bottomItemWidget('assets/icon/profile.svg', bottomNavBarController, 4,
                AppColors.whiteColor.withOpacity(0.1)),


            // bottomItemWidget('assets/icon/seetings.webp', bottomNavBarController, 5,
            //     AppColors.whiteColor.withOpacity(0.1)),

            // bottomItemWidget('assets/icon/my_gift.svg', bottomNavBarController, 3,
            //     AppColors.transparent),

          ],
        ),
      ),
    );



  }

}

bottomItemWidget(
  var icon,
  bottomNavBarController,
  page,
  Color color,
) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        bottomNavBarController.selectedIndex.value = page;
        print(bottomNavBarController.selectedIndex.value);
      },
      child: CircleAvatar(
        radius: 25,
        backgroundColor: color,
        child: SvgPicture.asset(
          icon,
          color: bottomNavBarController.selectedIndex.value == page
              ? AppColors.whiteColor
              : AppColors.whiteColor.withOpacity(0.4),
          height: 24,
        ),
      ),
    ),
  );
}
