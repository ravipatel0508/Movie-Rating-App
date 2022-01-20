import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DetailedMovieData {
  final String? movieTitle;
  final String? movieReleaseYear;
  final String? movieReleaseDate;
  final String? movieDuration;
  final String? movieGenre;
  final String? movieDirector;
  final String? movieWriter;
  final String? movieActors;
  final String? moviePlot;
  final String? movieLanguage;
  final String? movieCountry;
  final String? movieAwards;
  final String? movieImageUrl;
  final List<dynamic>? movieRating;
  final String? imdbRating;
  final String? imdbVotes;
  final String? imdbId;
  final String? type;
  final String? boxOffice;
  final String? production;
  final String? website;

  DetailedMovieData({
    required this.movieTitle,
    required this.movieReleaseYear,
    required this.movieReleaseDate,
    required this.movieDuration,
    required this.movieGenre,
    required this.movieDirector,
    required this.movieWriter,
    required this.movieActors,
    required this.moviePlot,
    required this.movieLanguage,
    required this.movieCountry,
    required this.movieAwards,
    required this.movieImageUrl,
    required this.movieRating,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.boxOffice,
    required this.production,
    required this.website,
  });

  factory DetailedMovieData.fromJson(Map<String, dynamic> json) {
    List<dynamic> movieRating = json['Ratings'] as List<dynamic>;
    List<dynamic> movieRatingList =
        movieRating.map((e) => RatingList.fromJson(e)).toList();

    return DetailedMovieData(
      movieTitle: json['Title'] ?? '',
      movieReleaseYear: json['Year'] ?? '',
      movieReleaseDate: json['Released'] ?? '',
      movieDuration: json['Runtime'] ?? '',
      movieGenre: json['Genre'] ?? '',
      movieDirector: json['Director'] ?? '',
      movieWriter: json['Writer'] ?? '',
      movieActors: json['Actors'] ?? '',
      moviePlot: json['Plot'] ?? '',
      movieLanguage: json['Language'] ?? '',
      movieCountry: json['Country'] ?? '',
      movieAwards: json['Awards'] ?? '',
      movieImageUrl: json['Poster'] ?? '',
      movieRating: movieRatingList,
      imdbRating: json['imdbRating'] ?? '',
      imdbVotes: json['imdbVotes'] ?? '',
      imdbId: json['imdbID'] ?? '',
      type: json['Type'] ?? '',
      boxOffice: json['BoxOffice'] ?? '',
      production: json['Production'] ?? '',
      website: json['Website'] ?? '',
    );
  }
}

class RatingList {
  final String source;
  final String value;

  RatingList({
    required this.source,
    required this.value,
  });

  factory RatingList.fromJson(Map<String, dynamic> json) {
    return RatingList(
      source: json['Source'] ?? '',
      value: json['Value'] ?? '',
    );
  }
}
