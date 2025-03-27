import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:health_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:iconsax/iconsax.dart';

import '../../appbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import 'Doc_User_Controller.dart';
class DoctorHomepage extends StatelessWidget {
  const DoctorHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(child: Column(
              children: [
                const DocHomeScreenAppbar(),
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
                    hintText: "Search",
                    hintStyle: WidgetStatePropertyAll(TextStyle(color: darkMode?TColors.white:TColors.darkerGrey ,)),
                    // backgroundColor: WidgetStatePropertyAll(darkMode?TColors.dark: TColors.light),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                    // padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: TSizes.defaultSpace)),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems*2,
                ),
              ],
            )),
            const DocGridBody(),
          ],
        ),
      ),
    );
  }
}
class DocHomeScreenAppbar extends StatelessWidget {
  const DocHomeScreenAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DocUserController());
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
class DocGridBody extends StatelessWidget {
  const DocGridBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: GridView.builder(
        itemCount: 4,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 200,
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
class MyBox extends StatelessWidget {
  var i=["assets/images/hsci/grid/g1.jpg","assets/images/hsci/grid/g2.jpg","assets/images/hsci/grid/g3.png","assets/images/hsci/grid/g4.jpg","assets/images/hsci/grid/g5.jpg","assets/images/hsci/grid/gc1.jpeg"],
      index=0,t=["My Online","My Offline","Buy","My Given","Track your ","Health"],
      t1=["Appointments","Appointments","Medicines","Prescriptions","Health","Assistant"],
      lbl=["Check Now","Check Now","45% off","Know More","View more","Try now"];
  MyBox(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        (index==0)? Get.to((){}):();
      },

      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          // image: DecorationImage(image: AssetImage(i[index])),
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [Expanded(flex: 6,child:
          Stack(
            children:[
              Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade200,
              ),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(i[index],),
              ),),
              Positioned(
                bottom: 0,
                right:15,
                left: 15,
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: TColors.primary,
                  ),
                  child: Center(child: Text(lbl[index],style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white),)),
                ),
              ),
            ],
          ),),
            Expanded(flex: 2,child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Text(t[index],style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.black),),
                  Text(t1[index],style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.black),maxLines: 2,),
                ],
              ),
            ),),
            // Expanded(flex: 1,child: Text(t1[index],style: Theme.of(context).textTheme.bodyLarge,maxLines: 2,),),
          ],
        ),
      ),
    );
  }
}