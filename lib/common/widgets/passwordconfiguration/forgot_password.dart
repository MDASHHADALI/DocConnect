import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/forget_password_controller.dart';
import 'package:health_app/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/common/widgets/passwordconfiguration/reset_password.dart';
import 'package:health_app/utils/constants/enums.dart';
import 'package:health_app/utils/constants/sizes.dart';

import '../../../utils/constants/text_strings.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              TTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections * 2,
            ),
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(
                    labelText: TTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () =>controller.sendPasswordResetEmail() ,
                  child: const Text(TTexts.submit)),
            ),
          ],
        ),
      ),
    );
  }
}
