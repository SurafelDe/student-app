import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_app/mvc/view/student_registration_page.dart';

import '../../util/keys.dart';
import '../controller/student_list_controller.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: GetBuilder<StudentListController>(
            init: Get.put(StudentListController()),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                    title: const Text("Student List",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.grey[200],
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: !controller.isSearching && controller.studentList.isEmpty ?
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Lottie.asset("assets/no_data_found.json"),
                        ),
                        ButtonTheme(
                          minWidth: 100,
                          height: 40,
                          child://ElevatedButton(
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(side: BorderSide(width: 1,style: BorderStyle.solid, color: Keys.primaryColor),),
                            child:
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                              child: Text( "Refresh",
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  color: Keys.primaryColor,
                                  fontSize: 16,//fontSize,
                                ),
                              ),
                            ),

                            onPressed: () async {
                              controller.getStudents();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                      :
                  //Student List
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.isSearching ? 8 : controller.studentList.length,
                      itemBuilder: (BuildContext context, index) {
                        return controller.isSearching ?
                        searchWidget() :
                        Card(
                          margin: EdgeInsets.all(10),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8,8,0,8),
                            child: Row(
                              children: [
                                ClipOval(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          Container(color: Colors.grey[200]),
                                      errorWidget: (context, url, error) =>
                                          Container(color: Colors.grey[300]),
                                      imageUrl: controller
                                          .studentList[index]
                                          .photo != null ?
                                      Keys.baseUrl +
                                          controller
                                              .studentList[index].photo! :
                                      "https://cdn3.iconfinder.com/data/icons/generic-avatars/128/avatar_portrait_man_male_1-1024.png",
                                      fit: BoxFit.cover,
                                      width: 70,
                                      height: 70,
                                    )
                                ),
                                SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${controller.studentList[index].firstName} '
                                        '${controller.studentList[index].lastName}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    SizedBox(height: 5,),
                                    Text('Birth Date : '
                                        '${controller.studentList[index].dateOfBirth}',
                                      style: TextStyle(
                                          fontSize: 16
                                      ), ),
                                  ],
                                ),
                                Spacer(),
                                // Spacer(),

                                PopupMenuButton(
                                  child: const Padding(
                                    padding:  EdgeInsets.all(8.0),
                                    child: Icon(Icons.more_vert, color: Color(0xff6d460b),),
                                  ),
                                  itemBuilder: (context) {
                                    return List.generate(2, (index) {
                                      return PopupMenuItem(
                                        value: index,
                                        child: Row(
                                          children: [
                                            Icon(index == 0 ? Icons.edit : Icons.delete, color: index == 0 ? Keys.primaryColor : Keys.errorColor,),
                                            SizedBox(width: 5,),
                                            Text(index == 0 ? 'Edit' : 'Delete'),
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  onSelected: (value) async {
                                    if(value == 0) {
                                      Get.to(() => StudentRegistrationPage(true, controller.studentList[index]));
                                    }
                                    else {
                                      Get.defaultDialog(
                                        title: "Delete",
                                        content: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                          child: Text("Are you sure you want to delete the student data?"),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              Get.back();
                                              controller.deleteStudent(index);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Get.back();
                                            },
                                            child: Text(
                                              'No',
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                floatingActionButton: FloatingActionButton(
                  // isExtended: true,
                  child: const Icon(Icons.add),
                  backgroundColor: Keys.primaryColor,
                  onPressed: () {
                    Get.to(() => StudentRegistrationPage(false, null));
                  },
                ),
              );

            }));
  }

  searchWidget() {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade200,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    height: 30,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade200,
              child: Container(
                width: 15,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
