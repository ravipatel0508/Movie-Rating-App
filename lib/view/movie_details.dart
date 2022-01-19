import 'package:flutter/material.dart';
import 'package:movie_rating/model/search_data.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({required this.data, Key? key}) : super(key: key);

  final SearchedDataList data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.topCenter,
        child: Hero(
          tag: 'ImageHero ${data.imdbID}',
          child: Image.network(
            data.poster,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
