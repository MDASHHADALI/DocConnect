import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/forget_password_controller.dart';
import 'package:health_app/login.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/constants/text_strings.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key,required this.email});
   final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: const AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(email,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                TTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                TTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: ()=>Get.offAll(()=> const LoginScreen()), child: const Text(TTexts.done)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
              onPressed: ()=>ForgetPasswordController.instance.resendPasswordResetEmail(email), child: const Text(TTexts.resendEmail)),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
