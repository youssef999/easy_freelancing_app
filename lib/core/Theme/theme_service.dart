import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../resources/app_colors.dart';


class ThemeService{
  // if(mode==ThemeMode.dark){
  //
  // }


  static TextStyle getDropdownTextStyle(BuildContext context) {
    ThemeMode mode= ThemeService().getThemeMode();
    if(mode==ThemeMode.dark){
      return Theme
          .of(context)
          .textTheme
          .bodyMedium!
          .copyWith(
        color: Colors.white,
      );
    }else{
      return Theme
          .of(context)
          .textTheme
          .bodyMedium!
          .copyWith(
        color: Colors.black,
      );
    }
// Replace with your logic to get the desired text style

  }

    final lightTheme = ThemeData.light().copyWith(
      hoverColor: Colors.blueAccent,
      highlightColor: Colors.blueAccent,
      indicatorColor:Colors.blueAccent,
     focusColor: Colors.blueAccent,
primaryColorLight:Colors.blueAccent,
canvasColor:Colors.blueAccent,
primaryColor: Colors.blue,

    textTheme:  const TextTheme(
     displaySmall: TextStyle(
       color:Colors.black,
       fontFamily: 'MYRIADPRO',
       // Replace with the font you want to use/ Adjust the text color as needed
     ),



      displayLarge: TextStyle(
        color:Colors.black,
        fontFamily: 'MYRIADPRO',
        // Replace with the font you want to use/ Adjust the text color as needed
      ),
      displayMedium: TextStyle(
        color:Colors.black,
        fontFamily: 'MYRIADPRO',
        // Replace with the font you want to use/ Adjust the text color as needed
      ),
      bodyMedium: TextStyle(
        color:Colors.black,
        fontFamily: 'MYRIADPRO',
        // Replace with the font you want to use/ Adjust the text color as needed
      ),
      bodySmall: TextStyle(
        color:Colors.black,
        fontFamily: 'MYRIADPRO',
        // Replace with the font you want to use/ Adjust the text color as needed
      ),
      bodyLarge: TextStyle(
        color:Colors.black,
        fontFamily: 'MYRIADPRO',
        // Replace with the font you want to use/ Adjust the text color as needed
      ),
    ),



      textSelectionTheme:  TextSelectionThemeData(
        cursorColor: AppColors.primary, // Set cursor color when focused
        selectionHandleColor: AppColors.primary,// Set text selection handle color
      ),

appBarTheme:  AppBarTheme(

  color:Colors.grey[100],

  titleTextStyle:const TextStyle(color:Colors.black)
),

progressIndicatorTheme:ProgressIndicatorThemeData(
  color:AppColors.primary
),

dividerColor: Colors.black12,

cardTheme: const CardTheme(color:Colors.white),

unselectedWidgetColor:Colors.red,

iconTheme:const IconThemeData(color:Colors.blue),

);

final darkTheme = ThemeData.dark().copyWith(

  hoverColor: Colors.blueAccent,
  highlightColor: Colors.blueAccent,
primaryColor: Colors.blue,
appBarTheme:  AppBarTheme(
  color:Colors.grey[900]!,
  titleTextStyle:const TextStyle(color:Colors.white)
),

dividerColor: Colors.white54,
  textSelectionTheme:  TextSelectionThemeData(
    cursorColor: AppColors.primary, // Set cursor color when focused
    selectionHandleColor: AppColors.primary,// Set text selection handle color
  ),

cardTheme: CardTheme(color:Colors.grey[700]),
  progressIndicatorTheme:ProgressIndicatorThemeData(
      color:AppColors.primary
  ),

iconTheme:const IconThemeData(color:Colors.black),

textTheme: const TextTheme(
  //bodySmall: const TextStyle(color:Colors.white),
  bodyMedium: TextStyle(
    color:Colors.white,
    fontFamily: 'MYRIADPRO',
    // Replace with the font you want to use/ Adjust the text color as needed
  ),
  bodySmall: TextStyle(
    color:Colors.white,
    fontFamily: 'MYRIADPRO',
    // Replace with the font you want to use/ Adjust the text color as needed
  ),
  bodyLarge: TextStyle(
    color:Colors.white,
    fontFamily: 'MYRIADPRO',
    // Replace with the font you want to use/ Adjust the text color as needed
  ),
),
);


final _getStorage = GetStorage();

final _darkThemeKey = "isDarkTheme";

void saveThemeData(bool isDarkMode) {

_getStorage.write(_darkThemeKey, isDarkMode);

}

bool isSavedDarkMode() {

return _getStorage.read(_darkThemeKey) ?? false;

}

ThemeMode getThemeMode() {

return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;

}

void changeTheme() {
Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
saveThemeData(!isSavedDarkMode());
}
}