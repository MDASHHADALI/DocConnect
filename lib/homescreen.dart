import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app/TVercelImageText3.dart';
import 'package:health_app/appbar.dart';
import 'package:health_app/chatbot.dart';
import 'package:health_app/common/widgets/custom_shapes/curved_edges.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/constants/enums.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';
import 'package:health_app/utils/helpers/network_manager.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:iconsax/iconsax.dart';

import 'AppointmentsAndConsultations/specialist.dart';
import 'TSectionHeading.dart';
import 'TVerticalImageText.dart';
import 'TverticalImageText2A.dart';
import 'common/widgets/custom_shapes/containers/circular_container.dart';
import 'common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'common/widgets/custom_shapes/curved_edges_widget.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'mybox.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{Get.to(ChatScreen())},
        tooltip: 'Doc Assistant',
        backgroundColor: Colors.blue.shade100,
        child: const Icon(Iconsax.message_search4,color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const HomeScreenAppbar(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: SearchBar(
                      leading: Icon(
                        Iconsax.search_normal,
                        color: darkMode?TColors.white:TColors.darkerGrey ,
                      ),
                      hintText: "Search Doctor",
                      hintStyle: WidgetStatePropertyAll(TextStyle(color: darkMode?TColors.white:TColors.darkerGrey ,)),
                      // backgroundColor: WidgetStatePropertyAll(darkMode?TColors.dark: TColors.light),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                      // padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: TSizes.defaultSpace)),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: "Doctor Specialization",
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems*2,
                  ),
                ],
              ),
            ),

            const GridBody(),
            const SizedBox(
              height: TSizes.spaceBtwItems/2,
            ),
            const Padding(
              padding: EdgeInsets.only(left: TSizes.defaultSpace),
              child: Column(
                children: [
                  TSectionHeading(
                    title: "Top doctors online for any consultation",
                    showActionButton: false,

                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  THomeCategories2(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  TSectionHeading(
                    title: "Book an In-Clinic Appointment",
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  THomeCategories3(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  TSectionHeading(
                    title: "Shop by Health Concerns",
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  GridBody2(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Accreditation(),
                  SizedBox(
                    height: TSizes.spaceBtwSections/2,
                  ),
                  Thanks(),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class Accreditation extends StatelessWidget {
  const Accreditation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 220,
      width:800,
      padding: const EdgeInsets.all(TSizes.sm),

      child:  const Center(
          child: Image(
            image: AssetImage("assets/images/hsci/scn.png"),
            fit: BoxFit.cover,
            // color: dark?TColors.light:TColors.dark,
          )),
    );
  }
}

class Thanks extends StatelessWidget {
  const Thanks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(


      padding: const EdgeInsets.all(TSizes.sm),

      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Stay Healthy',style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.grey.shade400 )),
          Row(
            children: [
              Text('Made with ',style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.grey.shade400 )),
              const Icon(Iconsax.heart_edit1,color: Colors.red,),
              Text(' By ',style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.grey.shade400 )),
              Text('DocConnect',style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.blueAccent )),

            ],
          ),
        ],
      ),
    );
  }
}

class GridBody extends StatelessWidget {
  const GridBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 160,
            mainAxisSpacing: TSizes.gridViewSpacing,
            crossAxisSpacing: TSizes.gridViewSpacing,
        ),
        itemBuilder: (context, index) {
          return MyBox(index);
        },
      ),
    );
  }
}

class GridBody2 extends StatelessWidget {
  const GridBody2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var st=["Stomach Care","Oral Care","Hygiene","Pain relief","Skin Care","Hair Care"];
    var add=["assets/images/hsci/smallcircle/sc1.png","assets/images/hsci/smallcircle/sc2.png","assets/images/hsci/smallcircle/sc3.png","assets/images/hsci/smallcircle/sc4.png","assets/images/hsci/smallcircle/sc5.png","assets/images/hsci/smallcircle/sc6.png"];
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 140,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
      ),
      itemBuilder: (context, index) {
        return TVerticalImageText3(image: add[index], title: st[index], onTap: (){},);
      },
    );
  }
}

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var st=["Cardiologist","Physician","Pediatrician","Neurologist","Dentist"];
    var add=["assets/images/homepage icon/heart.png","assets/images/homepage icon/h.png","assets/images/homepage icon/sthethoscope.png","assets/images/homepage icon/brain.png","assets/images/homepage icon/teeth.png"];
    return SizedBox(
      height: 95,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return  TVerticalImageText(image: add[index], title: st[index], onTap: (){Get.to(()=> SpecialistPage(currentIndex: index,));},);
          }),
    );
  }
}


class THomeCategories2 extends StatelessWidget {
  const THomeCategories2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var st=["PCOS/PCOD","Anxiety and","Headache and","Diabetes","Hypertension","High","Thyroid"];
    var st2=["management","stress","migraine","management","","cholesterol","disorders"];
    var add=["assets/images/hsci/circular/cir1.png","assets/images/hsci/circular/cir2.png","assets/images/hsci/circular/cir3.png","assets/images/hsci/circular/cir4.png","assets/images/hsci/circular/cir5.png","assets/images/hsci/circular/cir6.png","assets/images/hsci/circular/cir7.png"];
    return SizedBox(
      height: 170,
      child: ListView.builder(
          itemCount: 7,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return  TVerticalImageText2(image: add[index], title: st[index], onTap: (){}, title2: st2[index], borderRad: 100,);
          }),
    );
  }
}

class THomeCategories3 extends StatelessWidget {
  const THomeCategories3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var st=["Kidney stones","Fractures and","Chronic sinus","Severe","Chronic eczema","Uterine fibroids"];
    var st2=["","dislocations","infections","abdominal pain","or psoriasis","or ovarian cyst"];
    var add=["assets/images/hsci/lg/i1.png","assets/images/hsci/lg/i2.jpg","assets/images/hsci/lg/i3.jpg","assets/images/hsci/lg/i4.png","assets/images/hsci/lg/i5.jpg","assets/images/hsci/lg/i6.jpg"];
    return SizedBox(
      height: 170,
      child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return  TVerticalImageText2(image: add[index], title: st[index], onTap: (){}, title2: st2[index], borderRad: 10,);
          }),
    );
  }
}



class HomeScreenAppbar extends StatelessWidget {
  const HomeScreenAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome back",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: TColors.grey)),
          Obx(() => Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: TColors.white),
              ))
        ],
      ),
      actions: [
        Stack(children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.shopping_bag,
              color: TColors.white,
            ),
            tooltip: "Cart",
          ),
          Positioned(
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: TColors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: TColors.white, fontSizeFactor: 0.8),
                  ),
                ),
              ))
        ]),
        Stack(children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.notification,
              color: TColors.white,
            ),
            tooltip: "Notifications",
          ),
          Positioned(
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: TColors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    '4',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: TColors.white, fontSizeFactor: 0.8),
                  ),
                ),
              ))
        ]),
      ],
    );
  }
}
