import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/student_registration_controller.dart';
import 'button.dart';
import 'package:student_app/util/keys.dart';
import 'package:intl/intl.dart';

class StudentRegistrationPage extends StatelessWidget {
  StudentRegistrationPage(isForUpdate, studentData) {
    Get.put(StudentRegistrationController(isForUpdate, studentData));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          child:
              GetBuilder<StudentRegistrationController>(builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  controller.isForUpdate ? "Edit Student" : "Create Student",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                leading: const BackButton(
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                shadowColor: Colors.grey[200],
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              body: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.uploadPhoto();
                            },
                            child: controller.isForUpdate
                                ? Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: Colors.grey[300],
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipOval(
                                          child: controller
                                                          .studentData?.photo !=
                                                      null &&
                                                  controller.studentData!.photo!
                                                      .contains('uploads')
                                              ? CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          color:
                                                              Colors.grey[200]),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Container(
                                                          color:
                                                              Colors.grey[300]),
                                                  imageUrl: controller
                                                              .studentData
                                                              ?.photo !=
                                                          null
                                                      ? Keys.baseUrl +
                                                          controller
                                                              .studentData!
                                                              .photo!
                                                      : "https://cdn3.iconfinder.com/data/icons/generic-avatars/128/avatar_portrait_man_male_1-1024.png",
                                                  fit: BoxFit.cover,
                                                  width: 120,
                                                  height: 120,
                                                )
                                              : Image.file(
                                                  File(
                                                    controller
                                                        .studentData!.photo!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                  width: 120,
                                                  height: 120,
                                                ),
                                        ),
                                        const Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Color(0xffecf5ec),
                                              radius: 16.0,
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 20.0,
                                                color: Colors.orange,
                                              ),
                                            ))
                                      ],
                                    ))
                                : Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: Colors.grey[300],
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipOval(
                                          child: controller
                                                  .profileImageController
                                                  .text
                                                  .isEmpty
                                              ? CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          color:
                                                              Colors.grey[200]),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Container(
                                                          color:
                                                              Colors.grey[300]),
                                                  imageUrl:
                                                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                                  fit: BoxFit.cover,
                                                  width: 120,
                                                  height: 120,
                                                )
                                              : Image.file(
                                                  File(controller
                                                      .profileImageController
                                                      .text),
                                                  fit: BoxFit.cover,
                                                  width: 120,
                                                  height: 120,
                                                ),
                                        ),
                                        const Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Color(0xffecf5ec),
                                              radius: 16.0,
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 20.0,
                                                color: Colors.orange,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 5),

                          !controller.isForUpdate &&
                                  controller
                                      .profileImageController.text.isEmpty &&
                                  controller.isFormValidated
                              ? Text(
                                  "Choose profile picture",
                                  style: TextStyle(
                                      fontSize: 16, color: Keys.errorColor),
                                )
                              : Container(),
                          // SizedBox(height: 100,),

                          const SizedBox(height: 30),

                          //First name
                          TextFormField(
                            controller: controller.firstNameController,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'First Name is required'
                                  : value.length > 1 &&
                                          GetUtils.hasMatch(value, "[a-zA-Z ]")
                                      ? null
                                      : 'Invalid First Name';
                            },
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Keys.errorColor, fontSize: 10),
                              isDense: true,
                              contentPadding: EdgeInsets.all(15.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              labelText: "First Name",
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z\\s]*")),
                            ],
                            onChanged: (value) {
                              if (controller.isFormValidated) {
                                controller.formKey.currentState!.validate();
                              }
                            },
                          ),

                          const SizedBox(height: 15),

                          //Last name
                          TextFormField(
                            controller: controller.lastNameController,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'Last Name is required'
                                  : value.length > 1 &&
                                          GetUtils.hasMatch(value, "[a-zA-Z ]")
                                      ? null
                                      : 'Invalid Last Name';
                            },
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Keys.errorColor, fontSize: 10),
                              isDense: true,
                              contentPadding: EdgeInsets.all(15.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              labelText: "Last Name",
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z\\s]*")),
                            ],
                            onChanged: (value) {
                              if (controller.isFormValidated)
                                controller.formKey.currentState!.validate();
                            },
                          ),

                          const SizedBox(height: 15),

                          //Date of birth
                          TextFormField(
                            controller: controller.dateOfBirthController,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            validator: (value) {
                              return value == null || value.isEmpty
                                  ? 'Date of birth is required'
                                  : null;
                            },
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now()
                                      .subtract(Duration(days: 1500)),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2020));
                              if (picked != null) {
                                controller.selectedDate = picked;

                                controller.dateOfBirthController.text =
                                    DateFormat("dd-MM-yyyy").format(picked);

                                controller.update();
                              }

                              controller.formKey.currentState!.validate();
                            },
                            readOnly: true,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Keys.errorColor, fontSize: 10),
                              isDense: true,
                              contentPadding: EdgeInsets.all(15.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              labelText: "Date of birth",
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z\\s]*")),
                            ],
                            onChanged: (value) {
                              if (controller.isFormValidated)
                                controller.formKey.currentState!.validate();
                            },
                          ),

                          const SizedBox(height: 15),

                          // controller.isForUpdate ? Container() :
                          // //Profile picture
                          // TextFormField(
                          //   controller: controller.profileImageController,
                          //   cursorColor: Colors.black,
                          //   cursorWidth: 1,
                          //   validator: (value) {
                          //     return value == null || value.isEmpty
                          //         ? 'Profile picture is required'
                          //         : null;
                          //   },
                          //   onTap: () async {
                          //     controller.uploadPhoto();
                          //   },
                          //   readOnly: true,
                          //   autofocus: false,
                          //   keyboardType: TextInputType.text,
                          //   enableSuggestions: false,
                          //   autocorrect: false,
                          //   decoration: InputDecoration(
                          //     errorStyle: TextStyle(
                          //         color: Keys.errorColor, fontSize: 10),
                          //     isDense: true,
                          //     contentPadding: EdgeInsets.all(15.0),
                          //     border: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.black12),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.black12),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.black12),
                          //     ),
                          //     labelText: "Profile picture",
                          //     labelStyle: TextStyle(
                          //       color: Colors.grey,
                          //       fontSize: 14,
                          //     ),
                          //   ),
                          //   inputFormatters: <TextInputFormatter>[
                          //     FilteringTextInputFormatter.allow(
                          //         RegExp("[a-zA-Z\\s]*")),
                          //   ],
                          //   onChanged: (value) {
                          //     if (controller.isFormValidated)
                          //       controller.formKey.currentState!.validate();
                          //   },
                          // ),

                          const SizedBox(height: 30),

                          Button(
                            text: controller.isForUpdate ? "Update" : "Create",
                            onPressed: () async {
                              try {
                                FocusScope.of(context).unfocus();

                                if (controller.isForUpdate) {
                                  await controller.updateStudent();
                                } else {
                                  await controller.createStudent();
                                }
                              } catch (ex, stack) {}
                            },
                          ),
                          const SizedBox(height: 10),

                          SecondaryButton(
                            text: "Cancel",
                            onPressed: () async {
                              try {
                                Get.back();
                              } catch (ex, stack) {}
                            },
                          ),

                          const SizedBox(height: 20),
                        ]),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
