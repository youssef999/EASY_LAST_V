

import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/home/controllers/all_services_controller.dart';
import 'package:freelancerApp/features/home/controllers/freelancers_controller.dart';
import 'package:get/get.dart';
import '../../emp/views/emp_details_view.dart';
import '../../freelancer/freelancer/views/show_service_details.dart';


class AllEmpView extends StatefulWidget {

  const AllEmpView({super.key});

  @override
  State<AllEmpView> createState() => _AllServicesViewState();
}

class _AllServicesViewState extends State<AllEmpView> {

  AllFreelancerController controller=Get.put(AllFreelancerController());

  @override
  void initState() {
    controller.getAllEmployess();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar:CustomAppBar( 'serviceProviders'.tr, context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            EmpWidget()
          ],),
      ),
    );
  }

  Widget EmpWidget(){
    return GetBuilder<AllFreelancerController>(
        builder: (_) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.85, crossAxisSpacing: 4),
              itemCount:controller.allEmpList.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    child: Container(
                      decoration:BoxDecoration(
                          color:AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          SizedBox(
                            height: 115,
                            child:Image.network(controller.allEmpList[index]['image']),
                          ),
                          Custom_Text(text: controller.allEmpList[index]['name'],
                            color:AppColors.textColorDark,fontSize: 16,
                          ),
                          const SizedBox(height: 6,),
                          Custom_Text(text: "${controller.allEmpList
                          [index]['emp']}",
                            fontSize: 15,fontWeight:FontWeight.bold,
                            color:AppColors.primary,
                          ),
                        ],),
                      ) ,
                    ),
                    onTap:(){

                      Get.to(EmpDetailsView(
                        emp: controller.allEmpList[index]
                      ));



                    },
                  ),
                );
              }
          );
        }
    );
  }
}
