
import 'dart:convert';

import '../../util/keys.dart';
import '../model/get_students_response.dart';
import '../model/response.dart';
import 'package:student_app/util/http/http_attrib_options.dart';
import 'package:student_app/util/http/http_service.dart';

class StudentApi {

  Future<GetStudentsResponse> getAll() async {
    try {
      String? response =
      await HttpService()
          .send(HttpAttribOptions(
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

  Future<Response> create(Student request) async {
    try {
      String? response =
      await HttpService()
          .multiPart(HttpAttribOptions(
          baseUrl: Keys.baseUrl,
          path: '/api/student/create',
          method: HttpMethods.POST,
          body: json.encode(request.toJson()),
      ), request.photo);

      if (response != null) {
        return Response.fromJson(json.decode(response));
      } else {
        return Response();
      }
    } catch (ex, stack) {
      return Response();
    }
  }

  Future<GetStudentsResponse> delete(String id) async {
    try {
      String? response =
      await HttpService()
          .send(HttpAttribOptions(
          baseUrl: Keys.baseUrl,
          path: '/api/student/delete/$id',
          method: HttpMethods.DELETE,));
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
      String? response =
      await HttpService()
          .multiPart(HttpAttribOptions(
          baseUrl: Keys.baseUrl,
          path: '/api/student/update/${request.id}',
          method: HttpMethods.PUT,
          body: json.encode(request.toJson()),
          headerAttribute: {
            'Authorization': 'Bearer'
          }), request.photo);

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
