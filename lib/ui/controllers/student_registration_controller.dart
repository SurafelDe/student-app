import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../ui/controllers/student_list_controller.dart';

import '../../data/api/student_api.dart';
import '../../data/model/response.dart';
import '../../util/toast.dart';
import '../../ui/pages/image_picker_page.dart';

class StudentRegistrationController extends GetxController {
  StudentRegistrationController(this.isForUpdate, this.studentData) {
    // if(studentData_ != null) studentData = studentData_;
    if (isForUpdate && studentData != null) {
      firstNameController.text = studentData?.firstName ?? "";
      lastNameController.text = studentData?.lastName ?? "";
      dateOfBirthController.text = studentData?.dateOfBirth ?? '';
    }
    update();
  }

  bool isForUpdate = false;
  Student? studentData;

  final firstNameFormKey = GlobalKey<FormState>();
  final lastNameFormKey = GlobalKey<FormState>();

  final formKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var dateOfBirthController = TextEditingController();
  var profileImageController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  ScrollController scrollController = ScrollController();

  bool isFormValidated = false;

  bool validateForms() {
    var isValid = (formKey.currentState?.validate() ?? false);

    bool isPhotoUploaded = !isForUpdate ? _imageFile?.path != null : true;
    isFormValidated = true;
    update();
    return isValid && isPhotoUploaded;
  }

  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;

  uploadPhoto() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = pickedFile;

      Get.to(() => ImagePickerPage(_imageFile, true, (status) async {
            if (status == 'upload') {
              var fileName = _imageFile?.path.split("/");

              if (isForUpdate) {
                studentData?.photo = _imageFile?.path;
              } else {
                profileImageController.text = _imageFile?.path ?? '';
              }

              Get.back();
              update();
            }
          }));


      update();
    }
  }

  createStudent() async {
    try {

      if(!validateForms()){
        return;
      }

      EasyLoading.show();
      var response = await StudentApi().create(Student(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          dateOfBirth: dateOfBirthController.text,
          photo: _imageFile?.path));

      if (response.status != null && response.status == 'success') {
        await updateHomePage();

        Get.back();
      } else {
        Toast.message("Creating student failed");
      }
      EasyLoading.dismiss();
    } catch (ex) {
      EasyLoading.dismiss();
      print(ex);
    }
  }

  updateStudent() async {
    try {
      if(!validateForms()){
        return;
      }

      EasyLoading.show();
      var response = await StudentApi().update(Student(
          id: studentData?.id,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          dateOfBirth: dateOfBirthController.text,
          photo: _imageFile?.path));

      if (response.status != null && response.status == 'success') {
        await updateHomePage();
        Get.back();
        Toast.message(response.message ?? "Student data updated");
      } else {
        Toast.message("Updating student data failed");
      }
      EasyLoading.dismiss();
    } catch (ex) {
      EasyLoading.dismiss();
      print(ex);
    }
  }

  updateHomePage() async {
    StudentListController studentListController = Get.find();
    await studentListController.getStudents();
    studentListController.update();
  }
}
