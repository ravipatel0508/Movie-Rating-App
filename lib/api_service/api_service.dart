import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_rating/model/search_data.dart';

class ApiData {

  Future getTitleData(TextEditingController controller) async {
    String url =
        "https://www.omdbapi.com/?apikey=c1f93322&s=${controller.text}";
    http.Response response = await http.get(Uri.parse(url));

     if (response.statusCode == 200) {
        return SearchedData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
  }
}
