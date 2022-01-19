import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_rating/api_service/api_service.dart';
import 'package:movie_rating/controller/api_data.dart';
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
  ApiStoredData? apiStoredData;

  // Future<SearchedData>? searchedData;
  //bool isLoading = true;
  String networkLoadingImage =
      "https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png";

  // @override
  // initState() {
  //   super.initState();
  //   searchedData = getTitleData();
  // }

  Future getSearchedDadta() async {
    String url =
        "https://www.omdbapi.com/?apikey=c1f93322&s=${controller.text}";
    http.Response response = await http.get(Uri.parse(url), headers: {
      "X-CMC_PRO_API_KEY": "c1f93322",
      "Accept": "application/json"
    });

    if (response.statusCode == 200) {
      // setState(() {
      //   isLoading = true;
      // });
      //data = json.decode(response.body);
      setState(() {
        snapshot = SearchedData.fromJson(jsonDecode(response.body));
      });
      log(controller.text + snapshot!.response.toString());
      //return "------------------------------------------success";
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
                      onPressed: () {
                        log(apiStoredData.toString());
                      },
                      icon: const Icon(Icons.search)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              getCard()
            ],
          ),
        ),
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
