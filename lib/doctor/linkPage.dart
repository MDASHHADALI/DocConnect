

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';
import '../utils/helpers/network_manager.dart';
import '../utils/popup/full_screen_loader.dart';
import '../utils/popup/loaders.dart';
import '../utils/validators/validation.dart';


class LinkPage extends StatelessWidget {
  const LinkPage({super.key, required this.patientId});

   final String patientId;
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

    var link= TextEditingController();
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
        title: Text('Enter Meeting Link',style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body:  Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Start a meeting in Google meet and paste the meeting link below',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            Form(
              key: updateUserNameFormKey,
              child: TextFormField(
                controller: link,
                validator: (value)=> TValidator.validateEmptyText('Meeting Link', value),
                expands: false,
                decoration: const InputDecoration(labelText: "Meeting link", prefixIcon: Icon(Iconsax.video)),
              ),),
            const SizedBox(height: TSizes.spaceBtwSections,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () async {

                try{
                  TFullScreenLoader.openLoadingDialog('We are sending the meeting link...', TImages.docerAnimation);
                  final isConnected = await NetworkManager.instance.isConnected();
                  if(!isConnected)
                  {
                    TFullScreenLoader.stopLoading();
                    return;
                  }
                  // Form Validation
                  if(!updateUserNameFormKey.currentState!.validate())
                  {
                    TFullScreenLoader.stopLoading();
                    return;
                  }
                  // Update user's first and last name in Firebase Firestore
                  await FirebaseFirestore.instance.collection('Patients').doc(patientId).update(({'Link':link.text}));

                  // Remove Loader
                  TFullScreenLoader.stopLoading();
                  Get.back();
                  // Show Success Message
                  TLoaders.successSnackBar(title: 'Meeting Link Send ', message: 'Meeting link is send to the patient. Patient will join the meeting soon');

                }
                catch(e)
                {
                  TFullScreenLoader.stopLoading();
                  TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
                }



              }, child: const Text('Send')),
            )
          ],
        ),

      ),
    );
  }
}
