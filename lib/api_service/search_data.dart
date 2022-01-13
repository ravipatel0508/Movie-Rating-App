import 'package:json_annotation/json_annotation.dart';

part 'search_data.g.dart';

@JsonSerializable()
class SearchedData {
  final String? imdbID;
  final String? response;

  SearchedData({
    required this.imdbID,
    required this.response,
  });

  factory SearchedData.fromJson(Map<String, dynamic> json) =>
      _$SearchedDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchedDataToJson(this);
}
