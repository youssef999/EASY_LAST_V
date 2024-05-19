

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/freelancer/controllers/freelancer_controller.dart';
import 'package:get/get.dart';

class AddPortfolio extends StatefulWidget {
  const AddPortfolio({super.key});

  @override
  State<AddPortfolio> createState() => _AddPortfolioState();
}

class _AddPortfolioState extends State<AddPortfolio> {
    FreelancerController controller=Get.put(FreelancerController());

    @override
  void initState() {
   controller.getFreelancerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      appBar: CustomAppBar('', context, false),
      body:Padding(
        padding:  const EdgeInsets.all(8.0),
        child: GetBuilder<FreelancerController>(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(children:  [
                const SizedBox(height: 11,),
                        
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
                                                    text: 'addPortfolio'.tr,
                                                    color: AppColors.textColorDark,
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
                                            Column(
                                              children: [
                                                const SizedBox(height: 11,),

                                                (controller.isDataLoading==false)?
                                                CustomButton(text: 'add'.tr,
                                                    onPressed: (){

                                                      controller.addNewImage();

                                                    }):const Center(
                                                  child: CircularProgressIndicator(),
                                                )
                                              ],
                                            ),

                                    ],
                                  ),
            );
          }
        )
                         

      
      ),
    );
  }
}