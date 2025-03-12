import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/changeName.dart';
import 'package:health_app/shimmer.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/TSectionHeading.dart';

import '../../../circular_image.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../profilewidgets/profile_menu.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=UserController.instance;
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                  children: [
                    Obx((){
                      final networkImage= controller.user.value.profilePicture;
                      final image= networkImage.isNotEmpty? networkImage:"assets/user/as.jpg";
                      return
                        controller.imageUploading.value?
                            const TShimmerEffect(width: 80, height: 80,radius: 80,):
                        CircularImage(image: image,width: 80,height: 80,isNetworkImage: networkImage.isNotEmpty,);
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
            const TSectionHeading(title: 'Profile Information',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems,),

            Obx((){
              final name= controller.user.value.fullName;
              return ProfileMenu(title: 'Name',value: name,onPressed: ()=>Get.to(()=>const ChangeName()),);}),
            ProfileMenu(onPressed: (){}, title: 'Username', value: controller.user.value.username),
            const SizedBox(height: TSizes.spaceBtwItems,),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems,),
            ///Heading Personal Info
            const TSectionHeading(title: 'Personal Information',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems,),

            ProfileMenu(onPressed: (){}, title: 'User ID',icon: Iconsax.copy ,value: controller.user.value.id),
            ProfileMenu(onPressed: (){}, title: 'E-mail', value: controller.user.value.email),
            ProfileMenu(onPressed: (){}, title: 'Phone Number', value: controller.user.value.phoneNumber),
            ProfileMenu(onPressed: (){}, title: 'Gender', value: 'Male',),
            ProfileMenu(onPressed: (){}, title: 'Date of Birth', value: '27 April 2024'),

            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Center(
              child: TextButton(
                child: const Text('Close Account',style: TextStyle(color: Colors.red),),
                onPressed: (){},
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}


