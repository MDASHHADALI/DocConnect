import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/common/widgets/screens/profile.dart';
import 'package:health_app/homescreen.dart';
import 'package:health_app/setting_screen.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/helpers/network_manager.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';

import 'data/repositories/authentication/authentication_repository.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(NavigationController());
    final darkMode=THelperFunctions.isDarkMode(context);
    return  Scaffold(
      bottomNavigationBar: Obx(
       ()=> NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index)=>controller.selectedIndex.value=index,
          backgroundColor: darkMode?TColors.black:Colors.white,
          indicatorColor: darkMode?TColors.white.withOpacity(0.1):TColors.black.withOpacity(0.1),
          destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.video), label: 'Consultations'),
            NavigationDestination(icon: Icon(Iconsax.calendar), label: 'Appointments'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],

        ),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}
class NavigationController extends GetxController{
  final Rx<int> selectedIndex=0.obs;
  final screens=[const HomeScreen(),Container(color:Colors.blue),Container(color: Colors.orange,),const SettingScreen()];

}
