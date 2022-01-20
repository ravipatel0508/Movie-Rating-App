import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_rating/model/search_data.dart';
import 'package:movie_rating/view/movie_details.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controller = TextEditingController();
  Map<String, dynamic>? data;
  SearchedData? snapshot;
  String networkLoadingImage =
      "https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png";

  Future getSearchedDadta() async {
    String url =
        "https://www.omdbapi.com/?apikey=c1f93322&s=${controller.text}";
    http.Response response = await http.get(Uri.parse(url), headers: {
      "X-CMC_PRO_API_KEY": "c1f93322",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      setState(() {
        snapshot = SearchedData.fromJson(jsonDecode(response.body));
      });
      log(snapshot.toString());
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Rating',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Rating'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  getTextField(),
                  IconButton(
                      onPressed: getSearchedDadta,
                      icon: const Icon(Icons.search)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // getCard()
            ],
          ),
        ),
      ),
    );
  }

  getCCard() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: snapshot?.search.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetails(
                    data: snapshot!.search[index],
                    title: snapshot!.search[index].title,
                  ),
                ),
              );
              log(snapshot!.search[index].title);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Hero(
                            tag: 'ImageHero ${snapshot!.search[index].imdbID}',
                            child: Image.network(
                              snapshot!.search[index].poster == "N/A"
                                  ? networkLoadingImage
                                  : snapshot!.search[index].poster ??
                                      networkLoadingImage,
                              height: 200,
                              width: 100,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snapshot!.search[index].title} (${snapshot!.search[index].year})',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            snapshot!.search[index].type ?? "error",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  getCard() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: snapshot?.search.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetails(
                    data: snapshot!.search[index],
                    title: snapshot!.search[index].title,
                  ),
                ),
              );
              log(snapshot!.search[index].title);
            },
            child: Container(
              height: 180,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(3, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    height: 150,
                    bottom: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        snapshot!.search[index].poster == "N/A"
                                  ? networkLoadingImage
                                  : snapshot!.search[index].poster ??
                                      networkLoadingImage,
                        fit: BoxFit.cover,
                        width: 150,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 197,
                    top: 60,
                    child: SizedBox(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            '${snapshot!.search[index].title} (${snapshot!.search[index].year})',
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            "movie.tags!",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          //emptyVerticalBox(height: 5),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 60,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                snapshot?.search[0].totalResults.toString() ??
                                    ""
                                        " IMDB",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  getTextField() {
    return Expanded(
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Movie Title',
        ),
        controller: controller,
      ),
    );
  }
}
