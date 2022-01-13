// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_movie_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedMovieData _$DetailedMovieDataFromJson(Map<String, dynamic> json) =>
    DetailedMovieData(
      movieTitle: json['movieTitle'] as String?,
      movieDescription: json['movieDescription'] as String?,
      movieImageUrl: json['movieImageUrl'] as String?,
      movieReleaseYear: json['movieReleaseYear'] as String?,
      movieRating: json['movieRating'] as String?,
      movieDuration: json['movieDuration'] as String?,
      movieGenre: json['movieGenre'] as String?,
    );

Map<String, dynamic> _$DetailedMovieDataToJson(DetailedMovieData instance) =>
    <String, dynamic>{
      'movieTitle': instance.movieTitle,
      'movieReleaseYear': instance.movieReleaseYear,
      'movieDuration': instance.movieDuration,
      'movieDescription': instance.movieDescription,
      'movieImageUrl': instance.movieImageUrl,
      'movieRating': instance.movieRating,
      'movieGenre': instance.movieGenre,
    };
