import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DetailedMovieData{
  final String? movieTitle;
  final String? movieReleaseYear;
  final String? movieDuration;
  final String? movieDescription;
  final String? movieImageUrl;
  final String? movieRating;
  final String? movieGenre;

  DetailedMovieData({
    required this.movieTitle, 
    required this.movieDescription,
    required this.movieImageUrl,
    required this.movieReleaseYear,
    required this.movieRating,
    required this.movieDuration,
    required this.movieGenre
  });
}