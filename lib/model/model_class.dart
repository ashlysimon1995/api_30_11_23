// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String status;
  List<Employee> employees;
  int totalResults;

  Welcome({
    required this.status,
    required this.employees,
    required this.totalResults,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        employees: List<Employee>.from(
            json["employees"].map((x) => Employee.fromJson(x))),
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
        "totalResults": totalResults,
      };
}

class Employee {
  String id;
  String employeeName;
  String designation;

  Employee({
    required this.id,
    required this.employeeName,
    required this.designation,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeName: json["employee_name"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "designation": designation,
      };
}
