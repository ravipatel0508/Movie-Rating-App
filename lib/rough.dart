import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_rating/api_service/api_service.dart';
import 'package:movie_rating/model/search_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controller = TextEditingController();
  late Future<SearchedData> searchedData;

  bool isLoading = true;
  bool hasResponse = false;
  
  String networkLoadingImage =
      "https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png";

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
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Movie Title',
                ),
                controller: controller,
                onSubmitted: (String value) {
                  ApiData data = ApiData();
                  data.getTitleData(controller.text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              hasResponse
                  ? Container(
                      height: 10,
                      color: Colors.accents[100],
                    )
                  : Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.search.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Image.network(
                                        snapshot.data!.search[index].poster ==
                                                "N/A"
                                            ? networkLoadingImage
                                            : snapshot.data?.search[index]
                                                    .poster ??
                                                networkLoadingImage,
                                        //data?["Poster"],
                                        fit: BoxFit.fitHeight,
                                        width: 125,
                                        height: 170,
                                      ),
                                      Positioned(
                                        bottom: 3,
                                        right: -15,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black54,
                                                blurRadius: 5,
                                                offset: Offset(0, 5),
                                              )
                                            ],
                                            color: Colors.blue[300],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              snapshot.data?.search[index]
                                                      .imdbID ??
                                                  "N/A",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          //'${data?["Search"][index]["Title"]} (${data?["Search"][index]["Year"]})',
                                          '${snapshot.data!.search[index].title} (${snapshot.data!.search[index].year})',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          snapshot.data?.response ?? "error",
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
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: Colors.amber[600],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              //'${data?["Search"][index]["Runtime"]}',
                                              'RUNTIME',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          //'${data?["Search"][index]["Plot"]}',
                                          'PLOT',
                                          style: TextStyle(
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
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
