import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/AppointmentsAndConsultations/appointment_controller.dart';
import 'package:health_app/AppointmentsAndConsultations/schedule_page.dart';
import 'package:iconsax/iconsax.dart';
import '../circular_image.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';

class DoctorSelection extends StatefulWidget {
  const DoctorSelection({super.key});

  @override
  State<DoctorSelection> createState() => _DoctorSelectionState();
}
final searchBarController = TextEditingController();
String queryy="";

class _DoctorSelectionState extends State<DoctorSelection> {
  @override
  Widget build(BuildContext context) {
    final appointmentController = AppointmentController.instance;
    final FirebaseFirestore _db= FirebaseFirestore.instance;
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
     appBar: AppBar( title: const Text('Recommended Doctors'),
      leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
    ),
      body: SingleChildScrollView(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(
               height: TSizes.spaceBtwItems,
             ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace),
              child: SearchBar(
                controller: searchBarController,
                onChanged: (query){
                  queryy=query;
                  print(query);
                  setState(() {

                  });
                },
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
              height: TSizes.spaceBtwItems,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:  _db.collection("Doctors").where( 'FirstName',isGreaterThanOrEqualTo:queryy).snapshots(),
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
                ):
                   ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (_,index){
                      var data=snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: const CircularImage(image: "assets/user/1024.png",padding: 0,fit: BoxFit.fill,),
                          title: Text(
                            data['FirstName']+" "+data['LastName'],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( data['Specialization']+" | "+data['Degree'],style: Theme.of(context).textTheme.labelMedium,),
                              Row(
                                children: [
                                  const Icon(Icons.star,color: Colors.yellow,size: 20,),
                                  Text('4.9',style: Theme.of(context).textTheme.labelSmall,),
                                  const SizedBox(width: TSizes.spaceBtwSections,),
                                  Text("(2130 Reviews)",style: Theme.of(context).textTheme.labelSmall),
                                ],
                              )
                            ],
                          ),
                          trailing: const Icon(Iconsax.arrow_right),
                          onTap: (){
                            appointmentController.selDoctor=data['FirstName']+" "+data['LastName'];
                            appointmentController.degreeOfDoctor=data['Degree'];
                            appointmentController.doctorSpecialization=data['Specialization'];
                            appointmentController.doctorId=data.id;
                            Get.to(()=>const SchedulePage());
                          },
                        ),
                      );

                    });
              }
            ),

          ],
        ),
      ),
    );
  }
}
