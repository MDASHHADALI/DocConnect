import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../circular_image.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';
class SpecialistPage extends StatefulWidget {
  const SpecialistPage({super.key, required this.currentIndex});

  final int currentIndex ;
  @override
  State<SpecialistPage> createState() => _SpecialistPageState();
}

class _SpecialistPageState extends State<SpecialistPage> {
  var controller = ItemScrollController();
  var C = [TColors.grey,TColors.grey,TColors.grey,TColors.grey,TColors.grey];
  var prof="";
  var st=["Cardiologist","Physician","Pediatrician","Neurologist","Dentist"];
  var selIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    C[widget.currentIndex]=Colors.blue;
    selIndex=widget.currentIndex;
    prof=st[widget.currentIndex];
    WidgetsBinding.instance!.addPostFrameCallback((_)=>controller.jumpTo(index: widget.currentIndex));
  }
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
     appBar: AppBar(
       leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
       title: Text('Specialist',style: Theme.of(context).textTheme.headlineSmall,),
     ),
      body: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: ScrollablePositionedList.builder(
                itemCount: 5,
                itemScrollController: controller,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return  GestureDetector(
                      onTap: ()=>{

                        setState(() {
                          print(selIndex);
                          C[selIndex]=TColors.grey;
                          selIndex=index;
                          print(selIndex);
                          C[index]=Colors.blue;
                          prof=st[index];
                        })
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                        child: Container(
                          width: 120,
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
          const SizedBox(height: TSizes.spaceBtwSections,),
           Expanded(
             child: StreamBuilder<QuerySnapshot>(
                 stream:  FirebaseFirestore.instance.collection("Doctors").where( 'Specialization',isEqualTo:prof).snapshots(),
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
