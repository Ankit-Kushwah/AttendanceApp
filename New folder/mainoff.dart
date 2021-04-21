import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var Email;
  var responseJson;
  var jum=2;

  void initState() {
    initplatformstate();
  }

  void initplatformstate() async {
    var res = await http.get('http://192.168.0.200/Ankit/UbiAttendance/index.php/Attendance/emp');

    setState(() {
      responseJson = jsonDecode(res.body.toString());
      Email= responseJson[1]['img_id'];
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', 'Ankit');
    var abc= prefs.getString("name");
    print('fasdf'+abc);
    prefs.setString('email', Email);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 2/1,
        padding: const EdgeInsets.all(20.0),
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 1,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(responseJson.length, (index) {
          return Center(

            child:Container(
                height: 150,
                width:360.0,
                color: Colors.amber[100],
                padding: EdgeInsets.fromLTRB(60, 50, 60, 30),
                child:Column(

                  children: [

                    Text(responseJson[index]['Email']),
                    Text(responseJson[index]['img_id']),
                    Text(responseJson[index]['date']),
                    Text(responseJson[index]['time']),

                  ],
                )
            ),
          );
        }),
      ),
    );
  }
}

