import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/onBoardingController.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:health_app/utils/device/device_utility.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(OnBoardingController());
    return  Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: "assets/img/op1n.png",
                title: "Welcome to DocConnect",
                subTitle: "Your partner in health and always to your side",
              ),
              OnBoardingPage(image: "assets/img/op2n.png", title: "Your Doctor is Just a Video Call Away.", subTitle: "Stay Connected to Care, Wherever You Are."),
              OnBoardingPage(image: "assets/img/op3n.png", title: "Your Health Essentials, Always in Stock", subTitle: "Just Get Started"),
            ],
          ),
          const OnBoardingSkipButton(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark= THelperFunctions.isDarkMode(context);
    return Positioned(
        right: TSizes.defaultSpace,
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            onPressed: ()=>OnBoardingController.instance.nextPage(),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: (dark)?TColors.primary:Colors.black
            ),
            child: const Icon(Iconsax.arrow_right_3)));
  }
}

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: kToolbarHeight,right: TSizes.defaultSpace ,child: TextButton(onPressed: ()=> OnBoardingController.instance.skipPage(), child: const Text('Skip')));
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    final controller=OnBoardingController.instance;
    return Positioned(bottom:TDeviceUtils.getBottomNavigationBarHeight()+25,left:TSizes.defaultSpace,child: SmoothPageIndicator(
        controller: controller.pageController,
        count: 3,
        onDotClicked: controller.dotNavigationClick,
        effect:ExpandingDotsEffect(activeDotColor: dark?TColors.light:TColors.dark,dotHeight: 6)));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle,
  });
  final String image,title,subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.6,
              image: AssetImage(image),
          ),
          Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(subTitle,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),


        ],
      ),
    );
  }
}
