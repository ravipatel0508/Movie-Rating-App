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

  bool isLoading = true;
  String networkLoadingImage =
      "https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png";

  Future getSearchedData() async {
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
      log(controller.text + snapshot!.response.toString());
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
                    onPressed: getSearchedData,
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              data?["Response"] == "False"
                  ? Container(
                      color: Colors.red,
                      height: 20,
                      child: Text(
                        '$data',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  : getCardDetails()
              //: getMovieGrid()
              // : Container(
              //   color: Colors.blue,
              //   child: Text(
              //         snapshot?.response ?? "response null",
              //         style: const TextStyle(
              //             fontSize: 20, fontWeight: FontWeight.bold),
              //       ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  getCardDetails() {
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot?.search.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: snapshot?.search.length ?? 1,
          crossAxisSpacing: 100,
          mainAxisSpacing: 100,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          return GridTile(
            child: Center(
              child: GestureDetector(
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
                },
                child: Stack(
                    children: [
                      Hero(
                        tag: 'ImageHero ${snapshot!.search[index].imdbID}',
                        child: Image.network(
                          snapshot!.search[index].poster == "N/A"
                              ? networkLoadingImage
                              : snapshot!.search[index].poster ??
                                  networkLoadingImage,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Positioned(
                        child: Text(
                          "${snapshot!.search[index].title} (${snapshot!.search[index].title})",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        bottom: 10,
                        right: 10,
                      )
                    ],
                  ),
              ),
            ),
          );
        },
      ),
    );
  }

  getMovieGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
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
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Hero(
                  tag: 'ImageHero ${snapshot!.search[index].imdbID}',
                  child: Image.network(
                    snapshot!.search[index].poster == "N/A"
                        ? networkLoadingImage
                        : snapshot!.search[index].poster ?? networkLoadingImage,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
                Text(
                  snapshot!.search[index].title,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
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
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //'${data?["Search"][index]["Title"]} (${data?["Search"][index]["Year"]})',
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
                          const SizedBox(height: 15),
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.amber[600],
                            ),
                            child: Center(
                              child: Text(
                                //'${data?["Search"][index]["Runtime"]}',
                                snapshot!.totalResults,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            //'${data?["Search"][index]["Plot"]}',
                            snapshot!.response,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            maxLines: 3,
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
