import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app/TSectionHeading.dart';
import 'package:health_app/appbar.dart';
import 'package:health_app/circular_image.dart';
import 'package:health_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:health_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:health_app/common/widgets/screens/profile.dart';
import 'package:health_app/shimmer.dart';
import 'package:health_app/signoutfn.dart';
import 'package:health_app/tsetting_menu_tile.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                TAppBar(
                  title: Text(
                    "Account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),
                TUserProfileTile(controller: controller),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )),

            ///Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSectionHeading(title: 'Account Overview',showActionButton: false,),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingMenuTile(icon: Iconsax.safe_home, title: 'My Address', subtitle: 'Set your Delivery Address',onTap: (){},),
                  TSettingMenuTile(icon: Iconsax.calendar, title: 'Upcoming and Past Appointments', subtitle: 'View details of your appointments',onTap: (){},),
                  TSettingMenuTile(icon: Iconsax.book, title: 'Medical Conditions & Allergies', subtitle: 'Comprehensive overview of  diagnosed health conditions and known allergies.',onTap: (){},),
                  TSettingMenuTile(icon: Iconsax.omega_circle, title: 'Ongoing Medications ', subtitle: 'Track your current medications, dosage schedules, and prescription details.',onTap: (){},),
                  TSettingMenuTile(icon: Iconsax.screenmirroring4, title: 'Vaccination History', subtitle: 'Track your immunization records,',onTap: (){},),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  SizedBox(width: double.infinity,
                    child: OutlinedButton(onPressed: ()=>emailAndPasswordSignOut(), child: const Text("Logout")),

                  ),
                  const SizedBox(height: TSizes.spaceBtwSections*2.5,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.controller,
  });

  final UserController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: /*const CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage("assets/user/as.jpg"),
      ),*/
       Obx((){
        final networkImage= controller.user.value.profilePicture;
        final image= networkImage.isNotEmpty? networkImage:"assets/user/as.jpg";
        return
          controller.imageUploading.value?
          const TShimmerEffect(width: 80, height: 80,radius: 80,):
          CircularImage(image: image,width: 50,height: 50,isNetworkImage: networkImage.isNotEmpty,fit: BoxFit.fill,padding: 0,);
      }
      ),
      title: Obx(()
        => Text(
          controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white),
        ),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
          onPressed: () => Get.to(const ProfileScreen()),
          icon: const Icon(
            Iconsax.edit,
            color: TColors.white,
          )),
    );
  }
}
