import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/emp/views/emp_checkout_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EmpDetailsView extends StatelessWidget {
  Map<String, dynamic> emp;

  EmpDetailsView({super.key, required this.emp});


  txtT(dynamic txt, String style, double size, FontWeight w, Color color) {
    return Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: Text(
        emp[txt].toString(),
        style: GoogleFonts.cairo(fontSize: size, fontWeight: w, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainly,
      appBar: CustomAppBar(emp['name'], context, false),
      bottomSheet: animBtn(() {
        Get.to(EmpCheckoutView(
          data: emp,
        ));


        //Get.toNamed(Routes.CART);
      }, 'buyService'.tr, AppColors.primary),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        // ignore: prefer_const_literals_to_create_immutables
        child: ListView(children: [
          Container(
            height: 300,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Center(
              child: Image.network(
                emp['image'],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Center(
              child: Container(
            constraints: const BoxConstraints(maxWidth: double.infinity),
            child: Text(
              emp['name'],
              style: GoogleFonts.cairo(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
          )),
          Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Text(
                  emp['emp'],
                  style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              )),
          dvid(40),
          const SizedBox(
            height: 5,
          ),


          txtS('price'.tr, 'Hind', 20, FontWeight.normal, Colors.black),


          Row(
            children: [
              txtS('startFrom'.tr, 'Hind', 15, FontWeight.normal,
                  Colors.black),
              const SizedBox(
                width: 10,
              ),
              txtT('price', 'Thasadith', 40, FontWeight.w900,
                  AppColors.primary),
              txtS(currency, 'Hind', 20, FontWeight.normal, Colors.black)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          dvid(30),
          // txtS('About This Item', 'Hind', 22, FontWeight.w300,
          //     Colors.black45),

          Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10,top:5),
            child: Text(emp['des'] ?? '',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: AppColors.greyColor.withOpacity(0.6)
                )),
          ),
          const SizedBox(height: 50,)

        ]),
      ),
    );
  }
}

animBtn(void Function() function, String txt, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: function,
        child: Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          width: 250,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              txt,
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      )
    ],
  );
}

dvid(double num) {
  return SizedBox(
      height: num,
      child: const Divider(
        indent: 40,
        endIndent: 40,
        color: Color.fromARGB(50, 0, 0, 0),
      ));
}

txtS(String txt, String style, double size, FontWeight w, Color color) {
  return Text(
    txt,
    style: GoogleFonts.cairo(fontSize: size, fontWeight: w, color: color),
  );
}
