import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';
import '../utils/validators/validation.dart';
class ConsultationForm extends StatelessWidget {
  const ConsultationForm({super.key});

  @override
  Widget build(BuildContext context) {
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
              validator: (value)=>TValidator.validateEmptyText(TTexts.dateOfBirth, value),
              controller: controller.username,
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.dateOfBirth, prefixIcon: Icon(Iconsax.calendar)),
               onTap: ()async {
                // user can pick date
               var pickedDate = await showDatePicker(context: context,initialDate: DateTime.now(),firstDate: DateTime(2000),lastDate: DateTime(2100),);
               String date = DateFormat.yMMMMd().format(pickedDate!);
               dateController.text = date;
                },
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

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // const TermsAndConditionCheckbox(),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text(TTexts.createAccount)),
            ),
          ],
        ));;
  }
}
