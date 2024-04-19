// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_strings.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/core/widgets/custom_loading.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield2.dart';
import 'package:freelancerApp/core/widgets/phone_field_widget.dart';
import 'package:freelancerApp/features/auth/controllers/auth_controller.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/resources/app_colors.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  AuthController controller = Get.put(AuthController());
  final box = GetStorage();
  @override
  void initState() {
    String test = box.read('location') ?? 'x';
    if (test == 'x') {
      box.write('location', '');
    }
    controller.getLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Rx<String> locationName = box.read('location').toString().obs;
    // var email, pass;
    return Scaffold(
      backgroundColor: AppColors.mainly,
      appBar: CustomAppBar('', context, false),
      body: Form(
        child: Center(
          child: GetBuilder<AuthController>(builder: (_) {
            return

                //  Obx(() =>

                ListView(
              children: [
                Container(
                  width: 300,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: Image.asset(
                    'assets/images/logo.jpeg',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(children: [
                  Text('createNewAccount'.tr,
                      style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDarkColor,
                          fontFamily: 'Hind'))
                ]),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: AppColors.primaryDarkColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Column(
                    children: [
                      Obx(() {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.changeRoleId(1);
                                    controller.regRoleId = 1;
                                    controller.isSelected.value = 1;
                                  },
                                  style: controller.isSelected.value == 1
                                      ? ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  width: 1,
                                                  color: Colors.white)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.darkColor))
                                      : const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.whiteColor)),
                                  child: Text(
                                    'user'.tr,
                                    style: controller.isSelected.value == 1
                                        ? const TextStyle(color: Colors.white)
                                        : const TextStyle(color: Colors.black),
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.changeRoleId(2);

                                    controller.isSelected.value = 0;

                                    controller.roleId.text = '2';
                                  },
                                  style: controller.isSelected.value == 0
                                      ? ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  width: 1,
                                                  color: Colors.white)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.darkColor))
                                      : const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  AppColors.whiteColor)),
                                  child: Text(
                                    'freelancer'.tr,
                                    style: controller.isSelected.value == 0
                                        ? const TextStyle(color: Colors.white)
                                        : const TextStyle(color: Colors.black),
                                  )),
                            ),
                          ],
                        );
                      }),

                      (controller.regRoleId == 2)
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                (controller.idUrlList != null &&
                                        controller.idUrlList!.isNotEmpty)
                                    ? Column(children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        for (int i = 0;
                                            i < controller.idUrlList!.length;
                                            i++)
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.primary,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.41,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  File(controller
                                                                      .idUrlList![
                                                                          i]
                                                                      .path)),
                                                              fit:
                                                                  BoxFit.fill)),
                                                    ),
                                                    onTap: () {
                                                      controller.pickIdImage();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ])
                                    : InkWell(
                                        child: Column(
                                          children: [
                                            Custom_Text(
                                              text: 'addIdImage'.tr,
                                              color: AppColors.textColorLight,
                                              fontSize: 21,
                                              alignment: Alignment.center,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const CircleAvatar(
                                                radius: 100,
                                                child: Icon(
                                                  Icons.image,
                                                  size: 60,
                                                )),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          controller.pickIdImage();
                                          //  cubit.showDialogBox(context);
                                        },
                                      ),

                                //   ],
                                // ):const SizedBox(),

                                (controller.profilePickedFiles != null &&
                                        controller
                                            .profilePickedFiles!.isNotEmpty)
                                    ? Column(children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        for (int i = 0;
                                            i <
                                                controller
                                                    .profilePickedFiles!.length;
                                            i++)
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.primary,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.41,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  File(controller
                                                                      .profilePickedFiles![
                                                                          i]
                                                                      .path)),
                                                              fit:
                                                                  BoxFit.fill)),
                                                    ),
                                                    onTap: () {
                                                      controller
                                                          .pickProfileImage();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ])
                                    : InkWell(
                                        child: Column(
                                          children: [
                                            Custom_Text(
                                              text: 'addProfileImage'.tr,
                                              color: AppColors.textColorLight,
                                              fontSize: 21,
                                              alignment: Alignment.center,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const CircleAvatar(
                                                radius: 100,
                                                child: Icon(
                                                  Icons.image,
                                                  size: 60,
                                                )),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          controller.pickProfileImage();
                                          //  cubit.showDialogBox(context);
                                        },
                                      ),
                              ],
                            )
                          : const SizedBox(),
////////////////////////////////////////////////////////////////////////////////////////////

                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        controller: controller.nameController,
                        onSaved: (value) {
                          controller.nameController.text = value!;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return 'User Name Cant Be Larger Than 100 Letter';
                          }
                          if (value.length < 4) {
                            return 'User Name Cant Be Smaller Than 4 Letter';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: AppColors.whiteColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(
                              Icons.account_circle_outlined,
                              color: AppColors.darkColor,
                            ),
                            hintText: 'userName'.tr,
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            labelText: 'userName'.tr),
                        cursorColor: AppColors.darkColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.emailController,
                        onSaved: (value) {
                          controller.emailController.text = value!;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return 'Email Cant Be Larger Than 100 Letter';
                          }
                          if (value.length < 4) {
                            return 'Email Cant Be Smaller Than 4 Letter';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: AppColors.whiteColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: AppColors.darkColor,
                            ),
                            hintText: 'email'.tr,
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            labelText: 'email'.tr,
                            focusColor: AppColors.whiteColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: controller.passController,
                        onSaved: (value) {
                          controller.passController.text = value!;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return 'PassWord Cant Be Larger Than 100 Letter';
                          }
                          if (value.length < 4) {
                            return 'Password Cant Be Smaller Than 4 Letter';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: AppColors.whiteColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(
                              Icons.admin_panel_settings_sharp,
                              color: AppColors.darkColor,
                            ),
                            hintText: 'password'.tr,
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            labelText: 'password'.tr,
                            focusColor: AppColors.whiteColor),
                      ),

                      (controller.regRoleId == 2)
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                (controller.pickedImageXFiles != null &&
                                        controller
                                            .pickedImageXFiles!.isNotEmpty)
                                    ? Column(children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        for (int i = 0;
                                            i <
                                                controller
                                                    .pickedImageXFiles!.length;
                                            i++)
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.primary,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.41,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  File(controller
                                                                      .pickedImageXFiles![
                                                                          i]
                                                                      .path)),
                                                              fit:
                                                                  BoxFit.fill)),
                                                    ),
                                                    onTap: () {
                                                      controller
                                                          .pickMultiImage();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ])
                                    : InkWell(
                                        child: Column(
                                          children: [
                                            Custom_Text(
                                              text: 'addImage'.tr,
                                              color: AppColors.textColorLight,
                                              fontSize: 21,
                                              alignment: Alignment.center,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const CircleAvatar(
                                                radius: 100,
                                                child: Icon(
                                                  Icons.image,
                                                  size: 60,
                                                )),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          controller.pickMultiImage();
                                          //  cubit.showDialogBox(context);
                                        },
                                      ),
                              ],
                            )
                          : const SizedBox(
                              height: 10,
                            ),

                      GetBuilder<AuthController>(builder: (_) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Custom_Text(
                                  text: 'country'.tr,
                                  fontSize: 16,
                                  color: AppColors.textColorLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Colors.grey[100]!),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: controller.selectedCountry,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.changeCountryValue(newValue);
                                  }
                                },
                                items: controller.countryNames
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(value),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }),

                      const SizedBox(
                        height: 10,
                      ),

                      GetBuilder<AuthController>(builder: (_) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Custom_Text(
                                  text: 'city'.tr,
                                  fontSize: 16,
                                  color: AppColors.textColorLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Colors.grey[100]!),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: controller.selectedCity,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.changeCityValue(newValue);
                                  }
                                },
                                items: controller.cityNames
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(value),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }),

                      const SizedBox(
                        height: 10,
                      ),

                      (controller.regRoleId == 2)
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Custom_Text(
                                      text: 'price2'.tr,
                                      fontSize: 16,
                                      color: AppColors.textColorLight,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.priceController,
                                  onSaved: (value) {
                                    controller.priceController.text = value!;
                                  },
                                  validator: (value) {
                                    if (value!.length > 100) {
                                      return 'error';
                                    }
                                    if (value.length < 1) {
                                      return 'error';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: AppColors.whiteColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: AppColors.whiteColor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: AppColors.whiteColor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: AppColors.whiteColor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      prefixIcon: Icon(
                                        Icons.price_change,
                                        color: AppColors.darkColor,
                                      ),
                                      hintText: 'price2'.tr,
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      labelText: '',
                                      focusColor: AppColors.whiteColor),
                                ),
                              ],
                            )
                          : const SizedBox(),

                      const SizedBox(
                        height: 10,
                      ),

                      GetBuilder<AuthController>(builder: (_) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 6,
                            ),
                            (controller.regRoleId == 2)
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          Custom_Text(
                                            text: 'empType'.tr,
                                            fontSize: 16,
                                            color: AppColors.textColorLight,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            color: Colors.grey[100]!),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: controller.empType,
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              controller
                                                  .changeEmpType(newValue);
                                            }
                                          },
                                          items: controller.empTypeList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(value),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),

                            (controller.regRoleId == 1)
                                ? Obx(() {
                                    return InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors
                                                    .thirdLightTextColor),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Custom_Text(
                                                text: 'selectLocation'.tr,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textColorLight,
                                              ),
                                              Icon(
                                                Icons.location_on,
                                                color: AppColors.lightColor,
                                                size: 30,
                                              ),
                                              locationName.value != 'null' ||
                                                      locationName.value != ''
                                                  ? SizedBox(
                                                      width: 150,
                                                      height: 50,
                                                      child: Center(
                                                          child: Text(
                                                        locationName.value,
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color: Colors
                                                                    .white),
                                                        overflow:
                                                            TextOverflow.fade,
                                                      )))
                                                  : const SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Get.toNamed(Routes.LOCATION);
                                      },
                                    );
                                  })
                                : const SizedBox(),

                            (controller.empType == 'offline'.tr &&
                                        controller.regRoleId == 2 ||
                                    controller.empType == 'online'.tr &&
                                        controller.regRoleId == 2)
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      PhoneFieldWidget(
                                        labelText: "phoneNumber".tr,
                                        hintText: "223 665 7896".tr,
                                        onChanged: (phone) {
                                          controller.phoneNumber =
                                              phone!.number;
                                          Ui.logError(controller.phoneNumber);
                                        },
                                        isLast: false,
                                        isFirst: false,
                                      ),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors
                                                      .thirdLightTextColor),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Custom_Text(
                                                  text: 'selectLocation'.tr,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.textColorLight,
                                                ),
                                                Icon(
                                                  Icons.location_on,
                                                  color: AppColors.lightColor,
                                                  size: 30,
                                                ),
                                                locationName.value != 'null' ||
                                                        locationName.value != ''
                                                    ? SizedBox(
                                                        width: 150,
                                                        height: 50,
                                                        child: Center(
                                                            child: Text(
                                                          locationName.value,
                                                          style:
                                                              GoogleFonts.cairo(
                                                                  color: Colors
                                                                      .white),
                                                          overflow:
                                                              TextOverflow.fade,
                                                        )))
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Get.toNamed(Routes.LOCATION);
                                        },
                                      )
                                    ],
                                  )
                                : const SizedBox(),

                            const SizedBox(
                              height: 6,
                            ),
                            // Row(
                            //   children: [
                            //     Custom_Text(text: 'selectCat'.tr,
                            //     fontWeight: FontWeight.w500,
                            //       color:AppColors.textColorLight,
                            //     ),
                            //   ],
                            // ),

                            (controller.regRoleId == 2 &&
                                        controller.empType == 'online'.tr ||
                                    controller.regRoleId == 2 &&
                                        controller.empType == 'offline'.tr)
                                ? GetBuilder<AuthController>(
                                    builder: (context) {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: [
                                            Custom_Text(
                                              text: 'selectCat'.tr,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textColorLight,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          // height:200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              color: Colors.grey[100]!),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: controller.catValue,
                                              onChanged: (String? newValue) {
                                                if (newValue != null) {
                                                  controller
                                                      .changeCatValue(newValue);
                                                }
                                              },
                                              items: controller.catNames.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(value),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                : const SizedBox(),
                          ],
                        );
                      }),

                      const SizedBox(
                        height: 16,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 33.0, right: 33),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 7,
                              fixedSize: const Size(300, 60),
                              shadowColor: AppColors.darkColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.1, color: AppColors.darkColor),
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: AppColors.whiteColor),
                          child: Text(
                            "register".tr,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDarkColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            CustomLoading.showLoading('Loading...');

                            controller.startAddNewFreelancer();

                            //controller.userSignUp();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                //)
                ;
          }),
        ),
      ),
    );
  }
}
