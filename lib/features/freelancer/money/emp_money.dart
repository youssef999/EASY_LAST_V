


 import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/money/controller/money-controller.dart';
import 'package:get/get.dart';

class EmpMoney extends StatefulWidget {
   const EmpMoney({super.key});

   @override
   State<EmpMoney> createState() => _EmpMoneyState();
 }

 class _EmpMoneyState extends State<EmpMoney> {
  
  MoneyController controller=Get.put(MoneyController());
  
  @override
  void initState() {
   controller.getOrdersData();
    super.initState();
  }
   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       appBar: CustomAppBar('', context, true),
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: GetBuilder<MoneyController>(
           builder: (_) {
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: ListView(
                 children: [
                   const SizedBox(height: 40,),
                 Custom_Text(text: 'total'.tr+" = "+controller.finalMoney.toString()
                     +" "+currency,

                   fontSize: 21,color: Colors.black,
                   ),
                   const SizedBox(height: 7),
                   Custom_Text(text: 'totalNote'.tr,
                   color:Colors.grey,fontSize: 16,
                   ),
                   const SizedBox(height: 10,),

                   (controller.orderList.isNotEmpty)?
                   ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                       itemCount: controller.orderList.length,
                       itemBuilder: (context,index){
                     return Card(
                       child:Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(children: [
                           Custom_Text(text:
                           "serviceName".tr+"  :  "+
                           controller.orderList[index]['service_name'],
                           color: Colors.black,fontSize: 17,
                           ),
                           const SizedBox(height: 6,),
                           Custom_Text(text:
                               "price".tr+" "+
                           controller.orderList[index]['service_price'].toString()+' '+currency,
                           color: Colors.blue,fontSize: 16,
                           ), const SizedBox(height: 6,),
                           Custom_Text(text:
                           controller.orderList[index]['date'].toString(),
                           color: Colors.grey,fontSize: 16,
                           ),const SizedBox(height: 6,),




                         ],),
                       ),
                     );
                   }):Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(children: [
                       const SizedBox(height: 11,),
                       Container(
                         width: 500,
                         color: Colors.white,
                         child: SizedBox(
                             height: 155,
                             child: Image.asset('assets/images/noServ.jpeg')),
                       ),
                       const SizedBox(height: 7),

                       Custom_Text(text: 'noProfit'.tr,
                       fontSize: 22,color:Colors.black,
                         fontWeight: FontWeight.w700,
                       )
                     ],),
                   )
                 ],
               ),
             );
           }
         ),
       ),
     );
   }
 }
