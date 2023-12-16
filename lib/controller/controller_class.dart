import 'dart:convert';

import 'package:api_30_11_23/model/model_class.dart';
import 'package:http/http.dart' as http;

class Controllerclass {
  Welcome? modelobj;
  Map<String, dynamic> decodeData = {};

  Future getData() async {
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/");
    final response = await http.get(url);
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      decodeData = jsonDecode(response.body);
      print(decodeData);
      modelobj = Welcome.fromJson(decodeData);
    } else {
      print("Error");
    }
  }

  Future deleteData(String? id) async {
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/$id/");
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      await getData();
      return true;
    } else {
      return false;
    }
  }

  Future addData(String? name, String? designation) async {
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/");
    final response = await http
        .post(url, body: {"emplyoyee_name": name, "designation": designation});

    if (response.statusCode == 200) {
      await getData();
      return true;
    } else {
      return false;
    }
  }

  Future updateData(
      {required String name,
      required String designation,
      required String? id}) async {
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/$id/");
    final response = await http
        .put(url, body: {"employee_name": name, "designation": designation});

    if (response.statusCode == 200) {
      await getData();
      return true;
    } else {
      return false;
    }
  }
}
