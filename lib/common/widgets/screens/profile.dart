import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_app/user_controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/TSectionHeading.dart';

import '../../../circular_image.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../profilewidgets/profile_menu.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                  children: [
                    const CircularImage(image: "assets/user/as.jpg",width: 80,height: 80,),
                    TextButton(onPressed: (){}, child: const Text('Change Profile Picture')),
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

            ProfileMenu(title: 'Name',value: controller.user.value.fullName,onPressed: (){},),
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


