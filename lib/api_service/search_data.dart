import 'package:json_annotation/json_annotation.dart';

part 'search_data.g.dart';

@JsonSerializable()
class SearchedData {
  final List<dynamic> search;
  final String? totalResults;
  final String? response;

  SearchedData({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  // factory SearchedData.fromJson(Map<String, dynamic> json) =>
  //     _$SearchedDataFromJson(json);

  // Map<String, dynamic> toJson() => _$SearchedDataToJson(this);

  factory SearchedData.fromJson(Map<String, dynamic> json) {
   
    var search = json['Search'] as List;
    List<dynamic> searchedList =
        search.map((e) => SearchedDataList.fromJson(e)).toList();

    return SearchedData(
      search: searchedList,
      totalResults: json['totalResults'] as String,
      response: json['Response'] as String,
    );
  }
}


class SearchedDataList {
  final String? title;
  final String? year;
  final String? imdbID;
  final String? type;
  final String? poster;

  SearchedDataList({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  factory SearchedDataList.fromJson(Map<String, dynamic> json) {
    return SearchedDataList(
      title: json['Title'] as String,
      year: json['Year'] as String,
      imdbID: json['imdbID'] as String,
      type: json['Type'] as String,
      poster: json['Poster'] as String,
    );
  }
}
