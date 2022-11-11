import 'dart:convert';
import 'dart:developer';
import 'package:country_api/model/country.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiConstants {
  static String baseUrl = "https://restcountries.com/v3.1";
}

class Api {
  static Future<List<Country>> getcountrylist() async {
    //final listdata = await rootBundle.loadString("assets/images/data.json");
    var url = Uri.parse("${ApiConstants.baseUrl}/all");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List<Country> datalist = countryFromJson(response.body);
      return datalist;
    } else {
      return <Country>[];
    }
  }
  // static Future<List<Country>?> getcountrylist() async {
  //   try {
  //     var url = Uri.parse("${ApiConstants.baseUrl}/all");
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       List<Country> model = countryFromJson(response.body);
  //       print(response);
  //       return model;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }
}
