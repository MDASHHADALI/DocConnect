import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:health_app/AppointmentsAndConsultations/appointment_controller.dart';
import 'package:health_app/AppointmentsAndConsultations/appointment_user_model.dart';
import 'package:health_app/TSectionHeading.dart';
import 'package:health_app/data/repositories/user/user_repository.dart';
import 'package:health_app/homescreen.dart';
import 'package:health_app/navigation_menu.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:intl/intl.dart';

import '../circular_image.dart';
import '../common/widgets/success_screen/success_screen.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/helpers/helper_functions.dart';
import '../utils/helpers/network_manager.dart';
import '../utils/popup/full_screen_loader.dart';
import '../utils/popup/loaders.dart';
import 'appointment_user_repository.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final appointmentController= AppointmentController.instance;
    final userController = UserController.instance;
    var selIndex=-1.obs;
    var selIndex2=-1.obs;
    var C=[Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue].obs;
    var C2=[Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue].obs;
    var st=['6:00 am','8:00 am','10:00 am','12:00 pm','2:00 pm','4:00 pm','6:00 pm','8:00 pm','10:00 pm','12:00 am'];
    var st1='';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Consultation'),
        leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
      ),
      body: SingleChildScrollView(
          child:
          Column(
            children: [
              const SizedBox(height: TSizes.defaultSpace,),
          const SizedBox(
          child: Center(child: CircularImage(image: "assets/user/1024.png",
            width: 80,
            height: 80,
            isNetworkImage: false,
            fit: BoxFit.fill,
            backgroundColor: Colors.blue,
            padding: 0,)),
    ),
    const SizedBox(
    height: TSizes.spaceBtwItems,
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        children: [
      Text(appointmentController.selDoctor,style: Theme.of(context).textTheme.headlineMedium,),
      const SizedBox(height: TSizes.spaceBtwInputFields/2,),
      Text(appointmentController.doctorSpecialization,style: Theme.of(context).textTheme.headlineSmall,),
      const SizedBox(height: TSizes.spaceBtwItems/2,),
      Text(appointmentController.degreeOfDoctor,style: Theme.of(context).textTheme.headlineSmall,),
      const SizedBox(height: TSizes.spaceBtwInputFields/2,),
      ]),
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text("4.9/5",style: Theme.of(context).textTheme.headlineSmall,),
    const Icon(Icons.star,color: Colors.yellow,),
    const Icon(Icons.star,color: Colors.yellow,),
    const Icon(Icons.star,color: Colors.yellow,),
    const Icon(Icons.star,color: Colors.yellow,),
    const Icon(Icons.star,color: Colors.yellow,)
    ],
    ),
    const SizedBox(height: TSizes.spaceBtwSections,),
    const Padding(
    padding: EdgeInsets.only(left: TSizes.defaultSpace),
    child: TSectionHeading(title: "Select Date",showActionButton: false,),
    ),
    Padding(
    padding: const EdgeInsets.all(TSizes.defaultSpace),
    child: GridView.builder(
      itemCount: 9,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisExtent: 40,
      mainAxisSpacing: TSizes.gridViewSpacing,
      crossAxisSpacing: TSizes.gridViewSpacing,
      ),
      itemBuilder: (context, index) {
      return  Obx(
          ()=> GestureDetector(
            onTap: ()=>{
              if(selIndex!=index)
                {
                  if(selIndex > -1)
                    {
                      C[selIndex] = Colors.blue,

                    },
                  C[index] = Colors.green,
                  selIndex = index,
                  st1=DateFormat.yMMMMd().format(DateTime.now().add(Duration(days: index))) ,
                }
              else{
                selIndex=-1,
                C[index]=Colors.blue,
              }
            },
            child: Container(
              width: 50,
              height: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: darkMode?TColors.white:TColors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: C[index],
                ),
              child:  Center(child: Text(DateFormat.MMMMd().format(DateTime.now().add(Duration(days: index))),style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.white),)),
              ),

          ),
      );

      },
      ),

    ),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const Padding(
                padding: EdgeInsets.only(left: TSizes.defaultSpace),
                child: TSectionHeading(title: "Select Time Slot",showActionButton: false,),
              ),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 40,
                    mainAxisSpacing: TSizes.gridViewSpacing,
                    crossAxisSpacing: TSizes.gridViewSpacing,
                  ),
                  itemBuilder: (context, index) {
                    return  Obx(
                          ()=> GestureDetector(
                        onTap: ()=>{
                          if(selIndex2!=index)
                            {
                              if(selIndex2 > -1)
                                {
                                  C2[selIndex2] = Colors.blue,

                                },
                              C2[index] = Colors.green,
                              selIndex2 = index,
                            }
                          else{
                            selIndex2=-1,
                            C2[index]=Colors.blue,
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(color: darkMode?TColors.white:TColors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: C2[index],
                          ),
                          child:  Center(child: Text(st[index],style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.white),)),
                        ),

                      ),
                    );

                  },
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async{
                        try{
                          TFullScreenLoader.openLoadingDialog('Booking Appointment....', TImages.docerAnimation);
                          final isConnected=await NetworkManager.instance.isConnected();
                          if(!isConnected)
                          {
                            TFullScreenLoader.stopLoading();
                            return;
                          }
                          if(selIndex==-1)
                          {
                            TFullScreenLoader.stopLoading();
                            TLoaders.errorSnackBar(title: 'Select the date', message: 'No Date has been selected');
                            return;
                          }
                          if(selIndex2==-1)
                          {
                            TFullScreenLoader.stopLoading();
                            TLoaders.errorSnackBar(title: 'Select the time slot', message: 'No Time Slot has been selected');
                            return;
                          }
                          appointmentController.date=st1;
                          appointmentController.time="Between ${st[selIndex2]} - ${st[selIndex2+1]}";
                          final newPatient=AppointmentUserModel(dob: appointmentController.dob.text,
                              symptoms: appointmentController.symptoms,
                              habits: appointmentController.habits,
                              selDoctor: appointmentController.selDoctor,
                              date: appointmentController.date,
                              time: appointmentController.time,
                              gender: appointmentController.gender,
                              status: 'Upcoming',
                              id: userController.user.value.fullName+appointmentController.date+(1000000+Random().nextInt(9000000)).toString(),
                              userid: userController.user.value.id,
                              doctorId: appointmentController.doctorId,
                              firstName: appointmentController.firstName.text,
                              lastName: appointmentController.lastName.text,
                              degree: appointmentController.degreeOfDoctor,
                              specialization: appointmentController.doctorSpecialization,
                              link: 'No',
                          );
                          final patientRepository = Get.put(AppointmentUserRepository());
                          await patientRepository.saveUserRecord(newPatient);

                          TFullScreenLoader.stopLoading();
                          Get.off(
                                  ()=> SuccessScreen(image: TImages.successfullyRegisterAnimation,
                                title: "Your Appointment is booked successfully",
                                subtitle: " Your appointment with ${appointmentController.selDoctor} is booked.\nThe doctor will call between ${st[selIndex2]} - ${st[selIndex2+1]} on $st1",
                                onPressed: ()=> {Get.offAll(()=>const NavigationMenu())},
                              )
                          );
                        } catch(e)
                        {
                          TFullScreenLoader.stopLoading();
                          TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
                        }
                      },
                      child: const Text('Book Appointment')),
                ),
              ),
    ],
    ),
    ),
    );
  }
}
