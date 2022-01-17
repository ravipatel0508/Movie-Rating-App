import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SearchedData {
  final List<dynamic> search;
  final String totalResults;
  final String response;

  SearchedData({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  // factory SearchedData.fromJson(Map<String, dynamic> json) =>
  //     _$SearchedDataFromJson(json);

  // Map<String, dynamic> toJson() => _$SearchedDataToJson(this);

  factory SearchedData.fromJson(Map<String, dynamic> json) {
   
    List search = json['Search'] ?? [];
    List<dynamic> searchedList =
        search.map((e) => SearchedDataList.fromJson(e)).toList();

    log(json['Response']);
    
    return SearchedData(
      search: searchedList,
      totalResults: json['totalResults'] ?? "1",
      response: json['Response'],
    );
  }
}


class SearchedDataList {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  SearchedDataList({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  factory SearchedDataList.fromJson(Map<String, dynamic> json) {
    return SearchedDataList(
      title: json['Title'] ?? "",
      year: json['Year'] ?? "",
      imdbID: json['imdbID'] ?? "",
      type: json['Type'] ?? "",
      poster: json['Poster'] ?? "N/A",
    );
  }
}
