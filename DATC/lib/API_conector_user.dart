import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Server {
  static User user;
  static Future<void> fetchUser(String _email, String _pass) async {
      Uri a=Uri.parse("https://proiectdatcapimanager.azure-api.net/datcProiect/createAccount");
      var map = <String, dynamic>{
        "name": "andrei",
        "pasw": "andrei",
      };
      final response =
      await http.post(a,headers: {'Ocp-Apim-Subscription-Key': '3bfcf61b6e00403281bc7c2f7015e5dc','Ocp-Apim-Trace': 'true'},body: map);//"https://delaproprietar.ro/api/authentificate?email=$_email&pass=$_pass");
      print("getUsers ${response.statusCode} Response: ${response.body}");
      if (response.statusCode == 200) {
        //user=User.fromJson(json.decode(response.body));
        // If the server did return a 200 OK response, then parse the JSON.
        //return user;
      } else {
        // If the server did not return a 200 OK response, then throw an exception.
        throw Exception('Failed to load album');
      }
    }
  static User parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.cast<User>((json) => User.fromJson(json)).toList();
  }
  static GetUser()
  {
    return user;
  }
}
class User {
  String id,errorCode;
  String first_name,last_name,email;
  User({this.id , this.first_name , this.last_name, this.errorCode, this.email});

  factory User.fromJson(Map<String, dynamic> json) {

    return User(
        errorCode: json['errorCode'].toString(),
        id: json['id'].toString(),
        first_name: json['first_name'].toString(),
        last_name: json['last_name'].toString(),
        email : json['email'].toString()
    );
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    first_name = map['first_name'];
    last_name = map['last_name'];
    email  = map['email'];
  }
}



