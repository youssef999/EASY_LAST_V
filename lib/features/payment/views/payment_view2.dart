// ignore_for_file: unused_local_variable, unnecessary_const, must_be_immutable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/const/app_message.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/checkout/controllers/checkout_controller.dart';
import 'package:freelancerApp/features/payment/controllers/pay_controller.dart';
import 'package:freelancerApp/features/payment/controllers/payment_controller.dart';
import 'package:freelancerApp/features/payment/views/last_pay/doc/last_web_view.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';


 class PaymentView2 extends StatefulWidget {

 DocumentSnapshot data;
  String url;
  num price;

  PaymentView2({super.key,required this.url,required this.data,
     required this.price});

  @override
  State<PaymentView2> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView2> {

 PayController controller2=Get.put(PayController());

 // String url='';

  @override
  void initState() {
  //  controller2.createCheckout();
  // controller.getClientData2(widget.data,widget.price);
   //controller.firstApi();
   super.initState();

  }

    @override
    Widget build(BuildContext context) {

  CheckoutController controller=Get.put(CheckoutController());
      return Scaffold(
     appBar: CustomAppBar('', context, false),
      body:GetBuilder<PayController>(
        builder: (_) {
          return Padding(
            padding:  const EdgeInsets.all(8.0),
            // ignore: prefer_const_literals_to_create_immutables
            child: ListView(children: [
              const SizedBox(height: 10,),
                GetBuilder<PayController>(
                  builder: (_) {
                    return SizedBox(
                    height: 1500,
                    child: WebView(
                         navigationDelegate: (NavigationRequest request) {
                          print("req==${request.url}");

                          Future.delayed(const Duration(seconds: 2), () {

                          }).then((value) {

                            Get.to(LastWebView
                              (url: request.url, data: widget.data,
                                price: widget.price));
                          });
                          return NavigationDecision.prevent;

          // Implement your navigation delegation logic here
          //                 if (request.url.startsWith('https://pay.chargily.dz/test/payments/success')) {
          //
          //   Future.delayed(const Duration(seconds: 2), () {
          //      controller.addBalanceToFreelancer
          //     (widget.data['freelancer_email']).then((value) {
          //         controller.addOrderToFirebase(widget.data);
          //     }).then((value) {
          //         Get.offNamed(Routes.ROOT);
          //   appMessage(text: 'payDone'.tr, fail: false);
          //     });
          //   });
          //
          //   // Allow navigation if URL starts with 'https://example.com'
          // return NavigationDecision.prevent;
          // } else {
          //
          //    Get.offAll(RootView());
          //   appMessage(text: 'payError'.tr, fail: true);
          // return NavigationDecision.prevent;
          //   // Block navigation for all other URLs
          //   //return NavigationDecision.prevent;
          // }
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


