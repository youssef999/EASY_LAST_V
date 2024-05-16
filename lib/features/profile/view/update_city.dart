

 import 'package:flutter/material.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

import '../../../Core/resources/app_colors.dart';
import '../../../core/widgets/Custom_Text.dart';

class UpdateCity extends StatefulWidget {
  Map<String,dynamic> data;

   UpdateCity({super.key,required this.data});

  @override
  State<UpdateCity> createState() => _UpdateCityState();
}

class _UpdateCityState extends State<UpdateCity> {

  ProfileController controller=Get.put(ProfileController());
  @override
  void initState() {
    controller.getAllCities();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('', context, false),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: [
          GetBuilder<ProfileController>
            (builder: (_) {
            return Column(
              children: [
                const SizedBox(height: 33,),
                Custom_Text(
                  text: 'city'.tr,
                  fontSize: 18,
                  color: AppColors.textColorDark,
                  fontWeight: FontWeight.w600,
                ),

                Row(
                  children: [
                    Custom_Text(
                      text: 'city'.tr,
                      fontSize: 16,
                      color: AppColors.textColorLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.grey[100]!),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedCity,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.changeCityValue(newValue);
                        }
                      },
                      items: controller.cityNames
                          .map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 11,),
                CustomButton(text: 'change'.tr,
                    onPressed: (){

                  controller.updateCity(controller.selectedCity);

                    })
              ],
            );
          }),
        ],),
      ),
    );
  }
}
