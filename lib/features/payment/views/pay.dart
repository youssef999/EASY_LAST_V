

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/payment/controllers/pay_controller.dart';
import 'package:freelancerApp/features/payment/controllers/payment_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PayView extends StatelessWidget {

  Map<String,dynamic>data;

  num price;

 PayView({super.key,required this.data,required this.price});

  @override
  Widget build(BuildContext context) {
    PayController controller=Get.put(PayController());
    num serviceTotal=price/10;

    return  Scaffold(
      appBar:CustomAppBar('', context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(18),
                color:AppColors.backgroundColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  const SizedBox(height: 40,),
                  Row(
                    children: [
                      Custom_Text(text: 'total'.tr,fontSize: 22,
                      color:AppColors.textColorDark,fontWeight:FontWeight.bold,
                      ),
                      const SizedBox(width: 20,),
                      Custom_Text(text: price.toString()+"   "+currency,fontSize: 22,
                      color:AppColors.primary,fontWeight:FontWeight.w700,
                      ),

                    ],
                  ),
                  const SizedBox(height: 11,),
                  const SizedBox(height: 11,),
                  Row(
                    children: [
                      Custom_Text(text: 'serviceCost'.tr,fontSize: 22,
                        color:AppColors.textColorDark,fontWeight:FontWeight.bold,
                      ),
                      const SizedBox(width: 20,),
                      Custom_Text(text: "$serviceTotal   $currency",fontSize: 22
                        , color:AppColors.primary,fontWeight:FontWeight.w500,
                      ),


                    ],
                  ),

                ],),
              ),
            ),
            const SizedBox(height: 16,),
            CustomButton(text: 'pay'.tr, onPressed: (){
              num total=price+serviceTotal;
              controller.getClientData(data,total);
            })
          ],
        ),
      ),
    );
  }
}