import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controller = TextEditingController();
  Map<String, dynamic>? data;
  bool isLoading = true;
  String networkLoadingImage =
      "https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png";


  Future getTitleData() async {
    String url =
        "https://www.omdbapi.com/?apikey=c1f93322&s=${controller.text}";
    http.Response response = await http.get(Uri.parse(url), headers: {
      "X-CMC_PRO_API_KEY": "c1f93322",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      return data = json.decode(response.body);
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
        body: FutureBuilder(
          future: getTitleData(),
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Movie Title',
                    ),
                    controller: controller,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  data?["Response"] == "False"
                      ? Container()
                      : Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: data?["Search"]?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Image.network(
                                            data?["Search"][index]["Poster"] ==
                                                    "N/A"
                                                ? networkLoadingImage
                                                : data?["Search"][index]
                                                        ["Poster"] ??
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
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  data?["Search"][index]
                                                          ["imdbRating"] ??
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
                                              '${data?["Search"][index]["Title"]} (${data?["Search"][index]["Year"]})',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${data?["Search"][index]["Genre"]}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            //create cylinder timinng container
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
                                              child: Center(
                                                child: Text(
                                                  '${data?["Search"][index]["Runtime"]}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '${data?["Search"][index]["Plot"]}',
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
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
