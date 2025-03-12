import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/common/widgets/signupwidgets/termsandcondition.dart';
import 'package:health_app/common/widgets/signupwidgets/verifyemail.dart';
import 'package:health_app/signup_controller.dart';
import 'package:health_app/utils/validators/validation.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value)=>TValidator.validateEmptyText('First name', value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.firstName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                controller: controller.lastName,
                validator: (value)=>TValidator.validateEmptyText('Last name', value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.lastName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
          validator: (value)=>TValidator.validateEmptyText('Username', value),
          controller: controller.username,
          expands: false,
          decoration: const InputDecoration(
              labelText: TTexts.username, prefixIcon: Icon(Iconsax.user_edit)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
          validator: (value)=>TValidator.validateEmail(value),
          controller: controller.email,
          decoration: const InputDecoration(
              labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
          controller:  controller.phoneNumber,
          validator: (value)=>TValidator.validatePhoneNumber(value),
          decoration: const InputDecoration(
              labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        Obx(
            ()=> TextFormField(
            controller: controller.password,
            validator: (value)=>TValidator.validatePassword(value),
            obscureText: controller.hidePassword.value,
            decoration:  InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () =>controller.hidePassword.value=!controller.hidePassword.value,
                    icon:  Icon(controller.hidePassword.value?Iconsax.eye_slash:Iconsax.eye))),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        const TermsAndConditionCheckbox(),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TTexts.createAccount)),
        ),
      ],
    ));
  }
}
