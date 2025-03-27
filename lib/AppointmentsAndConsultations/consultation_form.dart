import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';
import '../utils/helpers/helper_functions.dart';
import '../utils/helpers/network_manager.dart';
import '../utils/popup/full_screen_loader.dart';
import '../utils/popup/loaders.dart';
import '../utils/validators/validation.dart';
import 'appointment_controller.dart';
import 'doctor_selection.dart';
class ConsultationForm extends StatelessWidget {
   ConsultationForm({super.key});
   final appointmentController = Get.put(AppointmentController());
   var items =[DropdownItem(label: 'Fever', value: User(symptom: 'Fever', id: 1)),DropdownItem(label: 'Headache', value: User(symptom: 'Headache', id: 2)),DropdownItem(label: 'Nausea', value: User(symptom: 'Nausea', id: 3)),
     DropdownItem(label: 'Vomiting', value: User(symptom: 'Vomiting', id: 4)),DropdownItem(label: 'Chest pain', value: User(symptom: 'Chest pain', id: 5)),DropdownItem(label: 'Stomach Ache', value: User(symptom: 'Stomach Ache', id: 6))];

   var items2 =[DropdownItem(label: 'Smoking', value: User2(lifestyle: 'Smoking', id: 1)),DropdownItem(label: 'Do Exercise', value: User2(lifestyle: 'Do Exercise', id: 2)),DropdownItem(label: 'Drinking', value: User2(lifestyle: 'Drinking', id: 3)),
     DropdownItem(label: 'Non Vegetarian', value: User2(lifestyle: 'Non Vegetarian', id: 4)),];
   late String gender;
  GlobalKey<FormState> patientFormKey= GlobalKey<FormState>();
   final _specList = [
     "Male",
     "Female",
     "Others",
   ];
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Form(
        key: appointmentController.patientFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: appointmentController.firstName,
                    validator: (value)=>TValidator.validateEmptyText('First name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    controller: appointmentController.lastName,
                    validator: (value)=>TValidator.validateEmptyText('Last name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            DropdownButtonFormField(
              validator: (value) => TValidator.validateEmptyText(
                  'Gender', value),
              decoration: const InputDecoration(
                  labelText: "Gender",
                  prefixIcon: Icon(Iconsax.people)),
              items: _specList.map(
                      (e){
                    return DropdownMenuItem(value: e,child: Text(e),);
                  }
              ).toList(),
              onChanged: (Object? value) {
                appointmentController.gender= value.toString();
              },
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              validator: (value)=>TValidator.validateEmptyText(TTexts.dateOfBirth, value),
              controller: appointmentController.dob,
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.dateOfBirth, prefixIcon: Icon(Iconsax.calendar)),
               onTap: ()async {
                // user can pick date
               var pickedDate = await showDatePicker(context: context,initialDate: DateTime.now(),firstDate: DateTime(1900),lastDate: DateTime.now(),);
               String date = DateFormat.yMMMMd().format(pickedDate!);
               appointmentController.dob.text = date;
                },
              readOnly: true
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            // const TermsAndConditionCheckbox(),
            MultiDropdown(
              items: items,
              controller: appointmentController.controller,
              enabled: true,
              searchEnabled: true,
              chipDecoration: const ChipDecoration(
                backgroundColor: Colors.yellow,
                wrap: true,
                runSpacing: 2,
                spacing: 10,
                labelStyle: TextStyle(color: Colors.black),
              ),
              fieldDecoration: FieldDecoration(
                hintText: 'Symptoms',
                labelText: 'Symptoms' ,
                labelStyle: TextStyle(fontSize:TSizes.fontSizeMd, color: darkMode? TColors.white:TColors.black),
                hintStyle:  TextStyle(color: darkMode?TColors.white:TColors.black),
                prefixIcon: const Icon(Iconsax.filter,color: TColors.darkGrey,),
                suffixIcon: Icon(Icons.arrow_drop_down,color: darkMode?const Color(0xFFBDBDBD):const Color(0xFF606060),),
                showClearIcon: false,
                padding: const EdgeInsets.all(15),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
                  borderSide:  BorderSide(width: 1, color: darkMode? TColors.darkGrey:TColors.grey),
                ),

                focusedBorder:const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
                  borderSide: BorderSide(width: 1, color: darkMode? TColors.white:TColors.dark),
                ),
                errorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
                  borderSide: const BorderSide(width: 1, color: TColors.warning),
                ),



              ),
              dropdownDecoration: DropdownDecoration(
                marginTop: 2,
                maxHeight: 500,
                backgroundColor: const Color(0xFFFEF7FF),
                header: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Select Symptoms from the list',
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: Colors.black),
                  ),
                ),
              ),
              dropdownItemDecoration: DropdownItemDecoration(
                textColor: Colors.black,
                selectedBackgroundColor: Colors.lightGreenAccent,
                selectedTextColor: Colors.red,
                selectedIcon:
                const Icon(Icons.check_box, color: Colors.green),
                disabledIcon:
                Icon(Icons.lock, color: Colors.grey.shade300),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a symptom';
                }
                return null;
              },
              onSelectionChange: (selectedItems) {
                appointmentController.symptoms= selectedItems.toString();
                appointmentController.symptoms=appointmentController.symptoms.substring(1,appointmentController.symptoms.length-1);
                debugPrint("OnSelectionChange: $selectedItems");
              },
            ),
            const SizedBox(height: TSizes.spaceBtwItems,),
            MultiDropdown(
              items: items2,
              controller: appointmentController.controller2,
              enabled: true,
              searchEnabled: true,
              chipDecoration: const ChipDecoration(
                backgroundColor: Colors.yellow,
                wrap: true,
                runSpacing: 2,
                spacing: 10,
                labelStyle: TextStyle(color: Colors.black),
              ),
              fieldDecoration: FieldDecoration(
                hintText: 'Lifestyle & Habits',
                labelText: 'Lifestyle & Habits' ,
                labelStyle: TextStyle(fontSize:TSizes.fontSizeMd, color: darkMode? TColors.white:TColors.black),
                hintStyle:  TextStyle(color: darkMode?TColors.white:TColors.black),
                prefixIcon: const Icon(Iconsax.lifebuoy,color: TColors.darkGrey,),
                suffixIcon: Icon(Icons.arrow_drop_down,color: darkMode?const Color(0xFFBDBDBD):const Color(0xFF606060),),
                showClearIcon: false,
                padding: const EdgeInsets.all(15),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
                  borderSide:  BorderSide(width: 1, color: darkMode? TColors.darkGrey:TColors.grey),
                ),

                focusedBorder:const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
                  borderSide: BorderSide(width: 1, color: darkMode? TColors.white:TColors.dark),
                ),
                errorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
                  borderSide: const BorderSide(width: 1, color: TColors.warning),
                ),



              ),
              dropdownDecoration: DropdownDecoration(
                marginTop: 2,
                maxHeight: 500,
                backgroundColor: const Color(0xFFFEF7FF),
                header: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Select Lifestyle & Habits',
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: Colors.black),
                  ),
                ),
              ),
              dropdownItemDecoration: DropdownItemDecoration(
                textColor: Colors.black,
                selectedBackgroundColor: Colors.lightGreenAccent,
                selectedTextColor: Colors.red,
                selectedIcon:
                const Icon(Icons.check_box, color: Colors.green),
                disabledIcon:
                Icon(Icons.lock, color: Colors.grey.shade300),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a Lifestyle or Habits';
                }
                return null;
              },
              onSelectionChange: (selectedItems) {
                appointmentController.habits= selectedItems.toString();
                appointmentController.habits=appointmentController.habits.substring(1,appointmentController.habits.length-1);
                debugPrint("OnSelectionChange: $selectedItems");
              },
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async{
                    try{
                      TFullScreenLoader.openLoadingDialog('Saving Patient Details....', TImages.docerAnimation);
                      final isConnected=await NetworkManager.instance.isConnected();
                      if(!isConnected)
                      {
                        TFullScreenLoader.stopLoading();
                        return;
                      }
                      if(!appointmentController.patientFormKey.currentState!.validate())
                    {
                    TFullScreenLoader.stopLoading();
                    return;
                    }

                     TFullScreenLoader.stopLoading();
                      Get.to(()=>const DoctorSelection());
                    } catch(e)
                    {
                    TFullScreenLoader.stopLoading();
                    TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
                    }
                  },
                  child: const Text(TTexts.tContinue)),
            ),
          ],
        )
    );
  }
}
Future<void> val() async
{


}
