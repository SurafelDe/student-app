import 'dart:convert';

import 'package:get/get.dart';

import '../../util/constants.dart';
import '../model/get_students_response.dart';
import '../model/response.dart';
import 'package:student_app/services/http_attrib_options.dart';
import '../../services/http_service.dart';

class StudentApi {
  static var httpService = Get.find<IHttpService>();

  static init() {
    Get.put<IHttpService>(HttpService());
  }

  Future<GetStudentsResponse> getAll() async {
    try {
      String? response = await httpService.send(HttpAttribOptions(
        baseUrl: Keys.baseUrl,
        path: '/api/student/list',
        method: HttpMethods.GET,
      ));
      if (response != null) {
        return GetStudentsResponse.fromJson(json.decode(response));
      } else {
        return GetStudentsResponse();
      }
    } catch (ex, stack) {
      return GetStudentsResponse();
    }
  }

  Future<StudentResponse> create(Student request) async {
    try {
      String? response = await httpService.multiPart(
          HttpAttribOptions(
            baseUrl: Keys.baseUrl,
            path: '/api/student/create',
            method: HttpMethods.POST,
            body: json.encode(request.toJson()),
          ),
          request.photo);

      if (response != null) {
        return StudentResponse.fromJson(json.decode(response));
      } else {
        return StudentResponse();
      }
    } catch (ex, stack) {
      return StudentResponse();
    }
  }

  Future<GetStudentsResponse> delete(String id) async {
    try {
      String? response = await httpService.send(HttpAttribOptions(
        baseUrl: Keys.baseUrl,
        path: '/api/student/delete/$id',
        method: HttpMethods.DELETE,
      ));
      if (response != null) {
        return GetStudentsResponse.fromJson(json.decode(response));
      } else {
        return GetStudentsResponse();
      }
    } catch (ex, stack) {
      return GetStudentsResponse();
    }
  }

  Future<GetStudentsResponse> update(Student request) async {
    try {
      String? response = await httpService.multiPart(
          HttpAttribOptions(
              baseUrl: Keys.baseUrl,
              path: '/api/student/update/${request.id}',
              method: HttpMethods.PUT,
              body: json.encode(request.toJson()),
              headerAttribute: {'Authorization': 'Bearer'}),
          request.photo);

      if (response != null) {
        return GetStudentsResponse.fromJson(json.decode(response));
      } else {
        return GetStudentsResponse();
      }
    } catch (ex, stack) {
      return GetStudentsResponse();
    }
  }
}
