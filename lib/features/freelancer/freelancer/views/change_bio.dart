


 import 'package:flutter/material.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield.dart';
import 'package:freelancerApp/features/freelancer/freelancer/controllers/freelancer_controller.dart';
import 'package:get/get.dart';

class ChangeBiView extends StatefulWidget {
  const ChangeBiView({super.key});

  @override
  State<ChangeBiView> createState() => _ChangeBiViewState();
}

class _ChangeBiViewState extends State<ChangeBiView> {

  FreelancerController controller=Get.put(FreelancerController());

   @override
  void initState() {

     controller.getFreelancerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('changeBio'.tr, context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<FreelancerController>(
          builder: (_) {
            return ListView(children:  [
              const SizedBox(height: 11,),
              CustomTextFormField(hint: controller.freelancerData[0]['bio'],
                  icon:(Icons.description),
                  obs: false, controller: controller.bioController,
              max: 7,
              ),
              const SizedBox(height: 21,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(text: 'changeBio'.tr,
                    onPressed: (){

                  controller.updateBio();

                    }),
              )

            ],);
          }
        ),
      ),
    );
  }
}
