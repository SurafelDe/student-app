import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:student_app/util/message.dart';
import '../../core/api/student_api.dart';
import '../../core/model/response.dart';

class StudentListController extends GetxController {

  bool _isSearching = false;
  bool get isSearching => _isSearching;
  set isSearching(bool value) {
    _isSearching = value;
    update();
  }

  StudentListController() {
    getStudents();
  }
  List<Student> studentList = [];

  getStudents({bool showShimmer = true}) async {
    try {
      isSearching = showShimmer;
      var response = await StudentApi().getAll();
      if (response.status == 'success') {
        studentList = response.students ?? [];
      }

      isSearching = false;
      update();
    } catch (ex, stack) {
      print(ex);
    }
  }

  deleteStudent(index) async {
    try {
      EasyLoading.show();
      var response = await StudentApi().delete(studentList[index].id ?? "");
      if (response.status == 'success') {
        await getStudents(showShimmer: false);
        update();

        Toast.message(response.message ?? "Student deleted");
      }
      else {
        Toast.message(response.message ?? "Deleting student failed");
      }

      update();
      EasyLoading.dismiss();
    } catch (ex, stack) {
      EasyLoading.dismiss();
      print(ex);
    }
  }
}
