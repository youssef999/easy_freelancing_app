import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Get.put(ProfileController());
    return Scaffold(
        backgroundColor: AppColors.mainly,
        appBar: CustomAppBar('account'.tr, context, false),
        body: Obx(() {
          return ListView(children: [
            Center(
              child: Container(
                width: 130,
                height: 150,
                margin: const EdgeInsets.only(top: 30,bottom: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.white),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                
                  controller.userData?['image'] ??
                      'https://threedio-cdn.icons8.com/nyQTub5XpLLjDfeBRnGZWVUGg_zQTGs4QC0GAdhQSKM/rs:fit:1024:1024/czM6Ly90aHJlZWRp/by1wcm9kL3ByZXZp/ZXdzLzExNy82M2Qx/NDFiNS04MjQ4LTRi/ZDQtYmQ1Mi1lNWE2/ZmI0NDBjNTMucG5n.png',
                  width: 130,
                 height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              controller.roleId == '1' ? 'مستخدم' : 'مستقل',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                  color: AppColors.primaryDarkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            txt('اسم المستخدم', controller.userData?['name'] ?? '', (p0) {}),
            txt('الايميل', controller.userData?['email'] ?? '', (p0) {}),
            txt('بلد المنشيء', controller.userData?['country'] ?? '', (p0) {}),
            txt('رمز الدخول', '*******', (p0) {}),

          if  (controller.roleId == '2') txt('المحتوي', controller.userData?['cat'] ?? '', (p0) {}),
                      if  (controller.roleId == '2')  txt('الوصف', controller.userData?['des'] ?? '', (p0) {}),

            const SizedBox(
              height: 90,
            )
          ]);
        }),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  width: 250,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLightColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'تعديل',
                      style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget txt(String hint, String label, void Function(String) onChanged) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          label: Text(
            label,            overflow: TextOverflow.clip,
maxLines: 1,
            style: GoogleFonts.cairo(),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: GoogleFonts.cairo(),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
