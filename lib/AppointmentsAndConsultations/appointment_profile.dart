import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_app/changeName.dart';
import 'package:health_app/shimmer.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/TSectionHeading.dart';

import '../../../circular_image.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../common/widgets/profilewidgets/profile_menu.dart';

class AppointmentProfile extends StatelessWidget {
   const AppointmentProfile({super.key, required this.data});

  final QueryDocumentSnapshot<Object?> data;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment'),
        leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(
                child: CircularImage(image: "assets/user/1024.png",width: 80,height: 80,isNetworkImage: false,fit: BoxFit.scaleDown,),
              ),
              ///Details
              const SizedBox(height: TSizes.spaceBtwItems/2,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),
              ///Heading Profile Info
              const TSectionHeading(title: 'Doctor Information',showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),
               ProfileMenu(title: 'Name',icon: Iconsax.copy ,value: data['SelectedDoctorName'],onPressed: ()=>{Clipboard.setData(ClipboardData(text: data['SelectedDoctorName'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)},),
              ProfileMenu(onPressed: ()=>{ Clipboard.setData(ClipboardData(text: data['Specialization'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)},icon: Iconsax.copy , title: 'Specialization', value: data['Specialization']),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),
              ///Heading Appointment Info
              const TSectionHeading(title: 'Appointment Information',showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),
              ProfileMenu(title: 'Date',value: data['DateOfAppointment'],icon: Iconsax.copy ,onPressed: ()=>{Clipboard.setData(ClipboardData(text: data['DateOfAppointment'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)},),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: data['TimeOfAppointment'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)},icon: Iconsax.copy , title: 'Time', value: data['TimeOfAppointment']),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),
              ///Heading Personal Info
              const TSectionHeading(title: 'Patient Information',showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: data['FirstName']+" "+data['LastName'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Name',icon: Iconsax.copy ,value: data['FirstName']+" "+data['LastName']),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: data['Gender'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Gender', icon: Iconsax.copy,value: data['Gender'],),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: data['DateOfBirth'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Date of Birth',icon: Iconsax.copy ,value: data['DateOfBirth']),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: data['Symptoms'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Symptoms',icon: Iconsax.copy ,value: data['Symptoms']),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: data['LifestyleAndHabits'])),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Lifestyle',icon: Iconsax.copy ,value: data['LifestyleAndHabits']),

            ],
          ),
        ),
      ),
    );
  }
}


