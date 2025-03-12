import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/login.dart';
class OnBoardingController extends GetxController
{
  static OnBoardingController get instance => Get.find();
  //variables
  final pageController=PageController();
  Rx<int> currentPageIndex=0.obs;
  void updatePageIndicator(index)=> currentPageIndex.value=index;
  void dotNavigationClick(index){
    //currentPageIndex.value=index;
    pageController.animateToPage(index, duration: const Duration(microseconds: 500), curve: Curves.easeInOut);
  }
  void nextPage(){
    if(currentPageIndex.value==2)
      {
        final storage=GetStorage();
        storage.write('isFirstTime', false);
        Get.offAll(()=>const LoginScreen());
      }
    else
      {
        int page= currentPageIndex.value+1;
        pageController.animateToPage(page, duration: const Duration(microseconds: 500), curve: Curves.easeInOut);
      }
  }
  void skipPage(){
    //currentPageIndex.value=2;
    pageController.animateToPage(2, duration:const Duration(microseconds: 500), curve: Curves.easeInOut);
  }
}