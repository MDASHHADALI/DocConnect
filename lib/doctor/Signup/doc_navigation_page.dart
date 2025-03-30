import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/AppointmentsAndConsultations/upcomingAppointments.dart';
import 'package:health_app/common/widgets/screens/profile.dart';
import 'package:health_app/doctor/Signup/doctor_homepage.dart';
import 'package:health_app/doctor/doctor_upcoming%20appointment.dart';
import 'package:health_app/homescreen.dart';
import 'package:health_app/setting_screen.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/helpers/network_manager.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';

import 'Doc_User_Controller.dart';
import 'doc_setting_screen.dart';

class DocNavigationMenu extends StatelessWidget {
  const DocNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(DocNavigationController());
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
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],

        ),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}
class DocNavigationController extends GetxController{
  static DocNavigationController get instance => Get.find();
  final Rx<int> selectedIndex=0.obs;
  final screens=[const DoctorHomepage(),const DoctorUpcomingAppointment(),const  DocSettingScreen()];

}
