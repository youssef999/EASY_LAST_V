
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/payment/controllers/pay_controller.dart';
import 'package:freelancerApp/features/payment/views/last_pay/doc/next_last.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../checkout/controllers/checkout_controller.dart';

class LastWebView extends StatefulWidget {

  DocumentSnapshot data;
  String url;
  num price;

  LastWebView({super.key,required this.url,required this.data,
    required this.price});

  @override
  State<LastWebView> createState() => _LastWebViewState();
}

class _LastWebViewState extends State<LastWebView> {




  @override
  Widget build(BuildContext context) {
    CheckoutController controller=Get.put(CheckoutController());

    return Scaffold(
      appBar:CustomAppBar('', context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child:  GetBuilder<PayController>(
            builder: (_) {
              return SizedBox(
                height: 900,
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {

                    webViewController.loadUrl(
                     widget.url,
                      headers: {'Cache-Control': 'no-cache'},
                    );
                   // webViewController.setJavaScriptEnabled(true);
                  },
                  navigationDelegate: (NavigationRequest request) {
                    print("req==${request.url}");
                    // Implement your navigation delegation logic here
                    if (request.url.startsWith('https://pay.chargily.dz/test/payments/success')) {
                      print("Success.....");
                      Get.to(NextWebView(
                        data: widget.data,
                        price: widget.price,
                        url: request.url,
                      ));
                      // Future.delayed(const Duration(seconds: 2), () {
                      //   controller.addBalanceToFreelancer
                      //     (widget.data['freelancer_email']).then((value) {
                      //     controller.addOrderToFirebase(widget.data);
                      //   }).then((value) {
                      //     Get.offNamed(Routes.ROOT);
                      //     appMessage(text: 'payDone'.tr, fail: false);
                      //   });
                      // });

                      // Allow navigation if URL starts with 'https://example.com'
                      return NavigationDecision.prevent;
                    } else {

                      print("FAIL.....");
                      Get.to(NextWebView(
                        data: widget.data,
                        price: widget.price,
                        url: request.url,
                      ));

                      // Get.offAll(RootView());
                      // appMessage(text: 'payError'.tr, fail: true);
                      return NavigationDecision.prevent;
                      // Block navigation for all other URLs
                      //return NavigationDecision.prevent;
                    }
                  },
                  initialUrl: widget.url,
                  gestureNavigationEnabled: true,

                  //javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
                ),
              );
            }
        )
      ),
    );
  }
}
