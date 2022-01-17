// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchedData _$SearchedDataFromJson(Map<String, dynamic> json) => SearchedData(
      search: json['Search'] as List<dynamic>,
      totalResults: json['totalResults'] as String?,
      response: json['Response'] as String?,
    );

Map<String, dynamic> _$SearchedDataToJson(SearchedData instance) =>
    <String, dynamic>{
      'search': instance.search,
      'totalResults': instance.totalResults,
      'response': instance.response,
    };
