import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Emp_log.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyState(),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.title,
    this.user,
    this.viewCount,
  });

  final Widget thumbnail;
  final String title;
  final String user;
  final int viewCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
             child:Text(""),

            ),

          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}
class MyState extends StatefulWidget {
  MyState({Key key}) : super(key: key);

  @override
  _MyStateState createState() => _MyStateState();
}

class _MyStateState extends State<MyState> {
  var responseJson;
  void initState() {
    initplatformstate();
  }

  void initplatformstate() async {
    var res = await http.get('http://ubiattendance.zentylpro.com/index.php/AttendanceAK/emp');

    setState(() {
      responseJson = jsonDecode(res.body.toString());
      print("helo");

    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(8.0),
      // itemExtent: 106.0,
      crossAxisCount: 1,

      // ignore: missing_return
      children: List.generate(responseJson.length, (index)
      {
        CustomListItem(
          user: responseJson['First_Name'],
          viewCount: 999000,
          thumbnail: Container(
            decoration: const BoxDecoration(color: Colors.blue),
          ),
        );
      }
      ),
    );
  }
}