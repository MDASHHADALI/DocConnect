import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/appbar.dart';
import 'package:health_app/update_Name_controller.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:health_app/utils/constants/text_strings.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';
import 'package:health_app/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(UpdateNameController());
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
        title: Text('Change Name',style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body:  Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Use real name for easy verification. This name will appear on several pages',
            style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
              children: [
                TextFormField(
                  controller: controller.firstName,
                  validator: (value)=> TValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: TTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),
                TextFormField(
                  controller:  controller.lastName,
                  validator: (value) => TValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: TTexts.lastName,prefixIcon: Icon(Iconsax.user)),
                )
              ],
            ),),
            const SizedBox(height: TSizes.spaceBtwSections,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()=>controller.updateUserName(), child: const Text('Save')),
            )
          ],
        ),

      ),
    );
  }
}
