import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_app/changeName.dart';
import 'package:health_app/doctor/Signup/Doc_User_Controller.dart';
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
import '../../common/widgets/profilewidgets/profile_menu.dart';


class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});


  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller= DocUserController.instance;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
        leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
               SizedBox(
                child: Column(
                  children: [
                    Obx((){
                      final networkImage= controller.user.value.profilePicture;
                      final image= networkImage.isNotEmpty? networkImage:"assets/user/1024.png";
                      return
                        controller.imageUploading.value?
                        const TShimmerEffect(width: 80, height: 80,radius: 80,):
                        CircularImage(image: image,width: 80,height: 80,isNetworkImage: networkImage.isNotEmpty,fit: BoxFit.scaleDown,);
                    }
                    ),
                    TextButton(onPressed: ()=> controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),
              ///Details
              const SizedBox(height: TSizes.spaceBtwItems/2,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),
              ///Heading Profile Info
              const TSectionHeading(title: 'Doctor Information',showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),
              ProfileMenu(title: 'Name',icon: Iconsax.copy ,value: controller.user.value.fullName,onPressed: ()=>{Clipboard.setData(ClipboardData(text:controller.user.value.fullName)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)},),
              ProfileMenu(onPressed: ()=>{ Clipboard.setData(ClipboardData(text: controller.user.value.fullName)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)},icon: Iconsax.copy , title: 'Username', value: controller.user.value.username),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),
              ///Heading Personal Info
              const TSectionHeading(title: 'Personal Information',showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: controller.user.value.id)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'User ID',icon: Iconsax.copy ,value: controller.user.value.id),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: controller.user.value.email)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Email', icon: Iconsax.copy,value: controller.user.value.email,),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: controller.user.value.phoneNumber)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Phone Number',icon: Iconsax.copy ,value: controller.user.value.phoneNumber),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: controller.user.value.specialization)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Specialization',icon: Iconsax.copy ,value: controller.user.value.specialization),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: controller.user.value.degree)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Degree',icon: Iconsax.copy ,value: controller.user.value.degree),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: controller.user.value.yearOfExp)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Year of Experience',icon: Iconsax.copy ,value: controller.user.value.yearOfExp),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: controller.user.value.licenseNumber)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Licence Number',icon: Iconsax.copy ,value: controller.user.value.licenseNumber),
              ProfileMenu(onPressed: ()=>{Clipboard.setData(ClipboardData(text: controller.user.value.location)),TLoaders.successSnackBar(title: "Text copied to clipboard",duration: 1)}, title: 'Location of Clinic',icon: Iconsax.copy ,value: controller.user.value.location),
            ],
          ),
        ),
      ),
    );
  }
}


