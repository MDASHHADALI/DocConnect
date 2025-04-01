import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app/doctor/Signup/doc_navigation_page.dart';
import 'package:health_app/doctor/linkPage.dart';
import 'package:health_app/navigation_menu.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:url_launcher/url_launcher.dart';

import '../circular_image.dart';
import '../data/repositories/authentication/authentication_repository.dart';
import '../utils/constants/colors.dart';


class Notifications extends StatelessWidget {
  const Notifications({super.key, required this.pf});
  final String pf;

  @override
  Widget build(BuildContext context) {
    final _auth = AuthenticationRepository.instance;
    final FirebaseFirestore _db= FirebaseFirestore.instance;
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: (){
            Get.back();
          }),
          title: const Text('Notifications'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _db.collection("Notifications").where('PersonId',isEqualTo: _auth.authUser!.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  SizedBox(
                          height: MediaQuery.of(context).size.height-140,
                          child: const Center(
                              child: Text("Loading....")
                          )
                      );
                    }
                    return (snapshot.data!.docs.isEmpty)?SizedBox(
                      height: MediaQuery.of(context).size.height-140,
                      child: const Center(child: Text("No Data Found")),
                    ):ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_,index){
                          var data=snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 2.0),
                            child: ListTile(
                              onTap: ()async{
                                TFullScreenLoader.openLoadingDialog('Loading', TImages.docerAnimation);
                                await FirebaseFirestore.instance.collection('Notifications').doc(data.id).update({'Seen':'Yes'});
                                TFullScreenLoader.stopLoading();
                                Get.back();
                                (pf=='Doctor')?DocNavigationController.instance.selectedIndex.value=1:NavigationController.instance.selectedIndex.value=1;
                              },
                                leading: const CircularImage(image: "assets/user/as.png",padding: 0,fit: BoxFit.fill,),
                                title: Text(
                                  data['Title'],
                                  style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.red),
                                ),
                                subtitle:  Text( data["Subtitle"],style: Theme.of(context).textTheme.labelLarge,),
                                // trailing: const Icon(Iconsax.arrow_right),

                            ),
                          );

                        });
                  }
              ),
            ],
          ),
        )
    );
  }
}
