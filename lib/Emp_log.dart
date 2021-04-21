import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
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
  final String viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _EmployeeDescription(
              title: title,
              user: user,
              viewCount: viewCount,
            ),
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

class _EmployeeDescription extends StatefulWidget {
  const _EmployeeDescription({
    Key key,
    this.title,
    this.user,
    this.viewCount,
  }) : super(key: key);

  final String title;
  final String user;
  final String viewCount;

  @override
  __EmployeeDescriptionState createState() => __EmployeeDescriptionState();
}

class __EmployeeDescriptionState extends State<_EmployeeDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            widget.user,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            widget.viewCount,
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  String Gid;
  var _id;




  @override
  void initState(){
    _getData();
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Gid = prefs.getString("id");
    });
  }

  var responseJson;

  Future _getUser() async {
    _id = Gid;

    var res = await http.get(
        'http://ubiattendance.zentylpro.com/index.php/AttendanceAK/EmpLog?id=$_id');
    responseJson = json.decode(res.body);

    return responseJson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Log"),
      ),
      body: Center(
        child: FutureBuilder(
            future: _getUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (BuildContext context, int index) {
                      return new Column(
                        children: <Widget>[
                          Container(
                            height: 100,
                            decoration: BoxDecoration(color: Colors.white),
                            child: CustomListItem(
                              user: snapshot.data[index]['date'],
                              viewCount: snapshot.data[index]['time'],
                              thumbnail: Container(
                                decoration: BoxDecoration(color: Colors.blue),
                              ),
                              title: snapshot.data[index]['Email'],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    });
              }
            }
            // data == null ? CircularProgressIndicator() :
            ),
      ),
    );
  }
}

// class User {
//   final String Email;
//   final String date;
//   final String time;
//
//   User(this.Email, this.date, this.time);
// }
