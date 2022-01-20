import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_rating/model/detailed_movie_data.dart';
import 'package:movie_rating/model/search_data.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    required this.data,
    Key? key,
    required this.title,
  }) : super(key: key);

  final SearchedDataList data;
  final String title;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  DetailedMovieData? snapshot;

  Future movieDetailsCall() async {
    String uri = "https://www.omdbapi.com/?apikey=c1f93322&t=${widget.title}";
    http.Response response = await http.get(Uri.parse(uri), headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      setState(() {
        snapshot = DetailedMovieData.fromJson(jsonDecode(response.body));
      });
      log("${snapshot!.boxOffice}");
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    movieDetailsCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,
            alignment: Alignment.topCenter,
            child: Hero(
              tag: 'ImageHero ${widget.data.imdbID}',
              child: Image.network(
                widget.data.poster,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Text(
            "${snapshot?.movieTitle}",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
