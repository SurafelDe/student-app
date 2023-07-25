// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

StudentResponse responseFromJson(String str) => StudentResponse.fromJson(json.decode(str));

String responseToJson(StudentResponse data) => json.encode(data.toJson());

class StudentResponse {
  String? status;
  String? message;
  Student? data;

  StudentResponse({
    this.status,
    this.message,
    this.data,
  });

  factory StudentResponse.fromJson(Map<String, dynamic> json) => StudentResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Student.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}


class Student {
  String? id;
  String? firstName;
  String? lastName;
  String? photo;
  String? dateOfBirth;

  Student({
    this.id,
    this.firstName,
    this.lastName,
    this.photo,
    this.dateOfBirth,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    photo: json["photo"],
    dateOfBirth: json["dateOfBirth"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "photo": photo,
    "dateOfBirth": dateOfBirth,
  };
}
