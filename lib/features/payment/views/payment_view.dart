

// ignore_for_file: unused_local_variable, unnecessary_const, must_be_immutable, avoid_print
import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/const/app_message.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/checkout/controllers/checkout_controller.dart';
import 'package:freelancerApp/features/payment/controllers/payment_controller.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';



class PaymentView extends StatefulWidget {

 Map<String,dynamic> data;
  String url;
 num price;

     PaymentView({super.key,required this.url,required this.data,
     required this.price
     });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  PaymentController controller=Get.put(PaymentController());

  String url='';
  
  @override
  void initState() {

   controller.getClientData(widget.data,widget.price);
   //controller.firstApi();
   super.initState();

  }

    @override
    Widget build(BuildContext context) {

  CheckoutController controller=Get.put(CheckoutController());
      return Scaffold(
     appBar: CustomAppBar('', context, false),
      body:GetBuilder<PaymentController>(
        builder: (_) {
          return Padding(
            padding:  const EdgeInsets.all(8.0),
            // ignore: prefer_const_literals_to_create_immutables
            child: ListView(children: [
              const SizedBox(height: 10,),
                GetBuilder<PaymentController>(
                  builder: (_) {
                    return SizedBox(
                    height: 1200,
                    child: WebView(
                         navigationDelegate: (NavigationRequest request) {
                          print("req==${request.url}");
          // Implement your navigation delegation logic here
          if (request.url.startsWith('https://maktapp.credit/Pay/Success')) {

            Future.delayed(const Duration(seconds: 2), () {
               controller.addBalanceToFreelancer
              (widget.data['freelancer_email']).then((value) {
                  controller.addOrderToFirebase2(widget.data);
              }).then((value) {

                Future.delayed(const Duration(seconds: 3)).then((value) {
     Get.offNamed(Routes.ROOT);
            appMessage(text: 'payDone'.tr, fail: false);
                });
              
              });
            
            });
           
            // Allow navigation if URL starts with 'https://example.com'
          return NavigationDecision.prevent;
          } else {

             Get.offAll(RootView());
            appMessage(text: 'payError'.tr, fail: true);
          return NavigationDecision.prevent;
            // Block navigation for all other URLs
            //return NavigationDecision.prevent;
          }
        },
                                initialUrl: widget.url,
                                //'https://maktapp.credit/pay/MCPaymentPage?paymentID=TV3VVKTQL8SW33300997771TV',
                                //'https://pub.dev/packages/webview_flutter/example',
                                //controller.webUrl, // Enter your URL here
                                javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
                              ),
                                  );
                  }
                )
            
            ]),
          );
        }
      ),
      );
    }
}


