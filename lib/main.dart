import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String stringResponse;
  late Map mapResponse;
  late Map dataResponse;
  late List listResponse;

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Demo"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(listResponse[index]['avatar']),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Index: ${listResponse[index]['id'].toString()}"),
                        Text(listResponse[index]['email'].toString()),
                        Text(
                            "${listResponse[index]['first_name'].toString()}-${listResponse[index]['last_name'].toString()}"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: listResponse == null ? 0 : listResponse.length,
      ),
    );
  }
}
