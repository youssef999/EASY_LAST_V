



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/payment/controllers/pay_controller.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../checkout/controllers/checkout_controller.dart';

class  NextWebView extends StatefulWidget {
  DocumentSnapshot data;
  String url;
  num price;

  NextWebView({super.key,required this.url,required this.data,
    required this.price});

  @override
  State< NextWebView> createState() => _LastWebViewState();
}

class _LastWebViewState extends State< NextWebView> {

//  WebViewController ? webViewController;

  @override
  void initState() {
    super.initState();
   // webViewController!.loadUrl(widget.url);
  }

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
                  height: 500,
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
                      //https://pay.chargily.dz/payment/edahabia-success?expires=1716681828&signature=a259ff733244622eefb8f8de7788446b98e174ac6bd245cc952c8c7d14edaf06&orderId=b5639810-fd46-4da3-9398-1d08de6acbad
                      // Implement your navigation delegation logic here
                      if (request.url.startsWith('https://pay.chargily.dz/payment/edahabia-success')) {
                        print("Success.....");
                        Future.delayed(const Duration(seconds: 2), () {
                          controller.addBalanceToFreelancer
                            (widget.data['freelancer_email']).then((value) {
                            controller.addOrderToFirebase(widget.data);
                          }).then((value) {
                            Get.offNamed(Routes.ROOT);
                            appMessage(text: 'payDone'.tr, fail: false);
                          });
                        });

                        // Allow navigation if URL starts with 'https://example.com'
                        return NavigationDecision.prevent;
                      } else {
                        print("FAIL.....");
                         Get.offAll(RootView());
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
