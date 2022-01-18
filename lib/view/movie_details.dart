import 'package:flutter/material.dart';
import 'package:movie_rating/model/search_data.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    required this.data,
  });

  final SearchedDataList data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'ImageHero ${data.imdbID}',
          child: Image.network(data.poster)),
      ),
    );
  }
}
