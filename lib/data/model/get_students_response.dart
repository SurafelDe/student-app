// To parse this JSON data, do
//
//     final getStudentsResponse = getStudentsResponseFromJson(jsonString);

import 'dart:convert';
import 'response.dart';

GetStudentsResponse getStudentsResponseFromJson(String str) => GetStudentsResponse.fromJson(json.decode(str));

String getStudentsResponseToJson(GetStudentsResponse data) => json.encode(data.toJson());

class GetStudentsResponse {
  String? status;
  String? message;
  List<Student>? students;

  GetStudentsResponse({
    this.status,
    this.message,
    this.students,
  });

  factory GetStudentsResponse.fromJson(Map<String, dynamic> json) => GetStudentsResponse(
    status: json["status"],
    message: json["message"],
    students: json["students"] == null ? [] : List<Student>.from(json["students"]!.map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
  };
}

