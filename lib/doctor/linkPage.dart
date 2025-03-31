

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../notification/notification_model.dart';
import '../notification/notification_repository.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';
import '../utils/helpers/network_manager.dart';
import '../utils/popup/full_screen_loader.dart';
import '../utils/popup/loaders.dart';
import '../utils/validators/validation.dart';


class LinkPage extends StatelessWidget {
  const LinkPage({super.key, required this.patientId, required this.userId});

   final String patientId;
   final String userId;
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
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final Uri url = Uri.parse('https://meet.google.com/landing');
        if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
        }},
        tooltip: 'Start New Meeting',
        backgroundColor: Colors.blue.shade100,
        child: const Icon(Icons.video_call_outlined,size:32,color: Colors.black,),
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
                  final newNotification =NotificationModel(id: (1000000+Random().nextInt(900000000)).toString(),
                      title: 'Join the meeting',
                      subtitle: 'Doctor is on the call . please join the meeting',
                      picture: '',
                      seen: "No",
                      personId: userId);
                  final notificationRepository = Get.put(NotificationRepository());
                  await notificationRepository.saveUserRecord(newNotification);

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
