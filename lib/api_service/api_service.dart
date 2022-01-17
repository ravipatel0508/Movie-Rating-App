import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_rating/model/search_data.dart';

class ApiData {
  Future getTitleData(controller) async {
    String url =
        "https://www.omdbapi.com/?apikey=c1f93322&s=${controller.text}";
    http.Response response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseData['Response'] == 'True') {
        return SearchedData.fromJson(jsonDecode(response.body));
      
    } else {
      throw Exception('Failed to load post');
    }
  }
}
