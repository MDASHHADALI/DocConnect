import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/AppointmentsAndConsultations/appointment_profile.dart';
import 'package:health_app/AppointmentsAndConsultations/appointment_user_repository.dart';
import 'package:health_app/data/repositories/authentication/authentication_repository.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../circular_image.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';
import 'appointment_user_model.dart';
class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({super.key});


  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  var controller = ItemScrollController();
  var C = [Colors.blue,TColors.grey];
  var prof="";
  var st=["Upcoming Appointments", "Past Appointments"];
  var selIndex=0;
  final appointmentUserRepository= Get.put(AppointmentUserRepository());
  final FirebaseFirestore _db= FirebaseFirestore.instance;
  List<AppointmentUserModel> ap=[];
  String status ="Upcoming";
  final _auth = AuthenticationRepository.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Padding(padding: const EdgeInsets.only(left: TSizes.defaultSpace,top: TSizes.defaultSpace/2,right: TSizes.defaultSpace/2),
        child: Column(
          children: [
            const SizedBox(height: TSizes.spaceBtwSections,),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return  GestureDetector(
                      onTap: (){
                        setState(() {

                          C[selIndex]=TColors.grey;
                          selIndex=index;

                          C[index]=Colors.blue;
                          prof=st[index];
                          (selIndex==1)?status="Past":status="Upcoming";
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: C[index],
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: darkMode?TColors.light:TColors.dark),
                          ),
                          child:  Center(child: Text(st[index],style: Theme.of(context).textTheme.bodyLarge!.apply(color: index==selIndex?Colors.white:Colors.black),)),
                        ),
                      ),
                    );

                  }
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection("Patients").where('UserID',isEqualTo: _auth.authUser!.uid).where('Status',isEqualTo: status).snapshots(),
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
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_,index){
                        var data=snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: const CircularImage(image: "assets/user/1024.png",padding: 0,fit: BoxFit.fill,),
                            title: Text(
                              data['SelectedDoctorName'],
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle:  Text( "Patient Name - ${data['FirstName']} ${data['LastName']}\nDate - ${data['DateOfAppointment']}\nTime - ${data['TimeOfAppointment']}",style: Theme.of(context).textTheme.labelLarge!.apply(color: darkMode?Colors.lightGreenAccent:Colors.red),),
                           // trailing: const Icon(Iconsax.arrow_right),
                            onTap: (){
                              Get.to(()=>AppointmentProfile(data: data,));
                            },
                          ),
                        );
                  
                      });
                }
              ),
            ),

          ],
        ) ,
      ),
    );
  }
}
