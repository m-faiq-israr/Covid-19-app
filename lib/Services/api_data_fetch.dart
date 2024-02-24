import 'dart:convert';

import 'package:flutter_application_2/Model/worldstates_api_model.dart';
import 'package:flutter_application_2/Services/Utilities/api_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  //this file is for fetching data from api
  Future<WorldstatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(appUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body); //this class is for stats
      return WorldstatesModel.fromJson(data);
    } else {
      throw Exception('failed');
    }
  }

  Future<List<dynamic>> contrieslistApi() async {
    var data;
    final response = await http.get(Uri.parse(appUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body); //this class is for countries flags
      return data;
    } else {
      throw Exception('failed');
    }
  }
}
