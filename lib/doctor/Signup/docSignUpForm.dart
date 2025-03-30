import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';
import 'package:health_app/utils/constants/api_constants.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/utils/validators/validation.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import 'DocSignupController.dart';
import 'doctermsandconditioncheckbox.dart';

class DocSignUpForm extends StatefulWidget {
  const DocSignUpForm({
    super.key,
  });

  @override
  State<DocSignUpForm> createState() => _DocSignUpFormState();
}


class _DocSignUpFormState extends State<DocSignUpForm> {
  final controller = Get.put(DocSignupController());

  final _specList = [
    "Cardiologist",
    "Physician",
    "Pediatrician",
    "Neurologist",
    "Dentist"
  ];
  List <String> lo =[];
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: ()=>{lo=[]},
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('First name', value),
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
                    onTap: ()=>{setState(() {
                      lo=[];
                    })},
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last name', value),
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
            TextFormField(
              onTap:()=> setState(() {
                lo=[];
              }),
              validator: (value) =>
                  TValidator.validateEmptyText('License Number', value),
              controller: controller.licenseNumber,
              expands: false,
              decoration: const InputDecoration(
                  labelText: 'License Number',
                  prefixIcon: Icon(Iconsax.pen_add)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            DropdownButtonFormField(
              onTap: ()=>setState(() {
                lo=[];
              }),
              validator: (value) => TValidator.validateEmptyText(
                  'Specialization', value),
              decoration: const InputDecoration(
                  labelText: "Specialization",
                  prefixIcon: Icon(Iconsax.security_safe)),
              items: _specList.map(
                  (e){
                    return DropdownMenuItem(child: Text(e),value: e,);
                  }
              ).toList(),
              onChanged: (Object? value) {
                controller.specialization = value.toString();
              },
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onTap: ()=>setState(() {
                lo=[];
              }),
              validator: (value) =>
                  TValidator.validateEmptyText('Degree', value),
              controller: controller.degree,
              expands: false,
              decoration: const InputDecoration(
                  labelText: 'Degree',
                  prefixIcon: Icon(Iconsax.book)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onTap: ()=>setState(() {
                lo=[];
              }),
              validator: (value) =>
                  TValidator.validateYearofExp(value),
              controller: controller.year,
              expands: false,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Year of Experience',
                  prefixIcon: Icon(Iconsax.calendar)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onTap: ()=>setState(() {
                lo=[];
              }),
              validator: (value) =>
                  TValidator.validateEmptyText('Hospital/Clinic Location', value),
              controller: controller.location,
              expands: false,
              onEditingComplete: ()=>{

              FocusManager.instance.primaryFocus?.unfocus(),
                setState(() {
                  lo=[];
                }),
              },
              onChanged: (st) async {
                if(st=='')
                {
                setState(() {
                  lo=[];
                });
                }
                else{
               try{ final places = FlutterGooglePlacesSdk(googleApikey);
                 final predictions =
                    await places.findAutocompletePredictions(st);
                debugPrint('Result: ${predictions.predictions[0].fullText}');
                lo=[];
               for(int i=0;i<predictions.predictions.length; i++)
                 {
                   lo.add(predictions.predictions[i].fullText);
                   setState(() {

                   });
                 }

               }
                   catch(e)
                {
                  debugPrint("Error");
                }
                }
              },
              decoration: const InputDecoration(
                  labelText: 'Hospital/Clinic Location',
                  prefixIcon: Icon(Iconsax.hospital)),
            ),
            Ink(
              color: darkMode?Colors.black:const Color(0xFFFEF7FF),
              child: ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: lo.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      controller.location.text=lo[index];
                      setState(() {
                        lo=[];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                      child: Text(lo[index],style: TextStyle(color: darkMode?Colors.white:Colors.black),),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onTap: ()=>setState(() {
                lo=[];
              }),
              validator: (value) =>
                  TValidator.validateEmptyText('Username', value),
              controller: controller.username,
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onTap: ()=>setState(() {
                lo=[];
              }),
              validator: (value) => TValidator.validateEmail(value),
              controller: controller.email,
              decoration: const InputDecoration(
                  labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onTap: ()=>setState(() {
                lo=[];
              }),
              controller: controller.phoneNumber,
              validator: (value) => TValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                onTap: ()=>setState(() {
                  lo=[];
                }),
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye))),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            const DocTermsAndConditionCheckbox(),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(TTexts.createAccount)),
            ),
          ],
        ));
  }
}
