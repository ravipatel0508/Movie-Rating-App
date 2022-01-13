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

  Future getTitleData() async {
    String url =
        "https://www.omdbapi.com/?apikey=c1f93322&t=${controller.text}";

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Movie Title',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    data?["Response"] == "False"
                        ? Container()
                        : Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    data?["Poster"] ?? "https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png",
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 150,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Your Other Widgets if you want'),
                                      const SizedBox(height: 20),
                                      Text('Your Other Widgets if you want'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
