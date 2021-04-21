import 'dart:convert';
import 'package:dio_project1/EmpCard.dart';
import 'package:flutter/material.dart';
import 'EmpAttendance.dart';
import 'Emp_Edit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var Gid;
  var Mobile;
  var Address;
  var Last_Name;
  var First_Name;
  var Field;
  var Email;
  var check_Att_id;
  var responseJson;
  var Status;

  _attendanceData() async {
    check_Att_id = await http.get(
        "http://ubiattendance.zentylpro.com/index.php/AttendanceAK/EmpAttcheck?Emp_id=$Gid");
    setState(() {
      responseJson = jsonDecode(check_Att_id.body.toString());
    });
    Status = responseJson['Attendance_Status'];
  }

  Future Login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Gid = prefs.getString("id");
      Email = prefs.getString("Email");
      First_Name = prefs.getString("First_Name");
      Last_Name = prefs.getString("Last_Name");
      Mobile = prefs.getString("Mobile");
      Address = prefs.getString("Address");
      Field = prefs.getString("Field");
    });
    _attendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employees Page',
          style: TextStyle(fontSize: 16),
        ),
      ),
      //=====================================================Drawer===================================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      Text(
                        First_Name,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 5),
                      Text(
                        Last_Name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomePage3()));
              },
            ),
            Divider(
              thickness: 2.0,
              color: Colors.cyanAccent,
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                SharedPreferences Prefs = await SharedPreferences.getInstance();
                Prefs.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
            ),
            Divider(
              thickness: 2.0,
              color: Colors.cyanAccent,
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _profile(),
          ],
        ),
      ),
    );
  }

  Widget _profile() {
    return FutureBuilder(
        future: Login(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          } else {
            return Column(
                children: [
                  Stack(
                    alignment: Alignment(0.8, 0.8),
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.network(
                              'https://cdn.pixabay.com/photo/2014/08/01/00/08/pier-407252_960_720.jpg',
                              width:MediaQuery.of(context).size.width*1,
                              height: MediaQuery.of(context).size.height*0.5,
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 220.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
                          radius: 80,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.transparent,
                      //   ),
                      //   child: Text(
                      //     "",
                      //     style: TextStyle(
                      //       fontSize: 30,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(15, 25.0, 0, 0),
                      height:MediaQuery.of(context).size.height*0.5,
                      width: MediaQuery.of(context).size.width*1,
                      color: Colors.amber[100],
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0, left: 5),
                            child: Text(
                              "Name :",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
          Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 5),
          child: Text(
                              First_Name,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
          ),

          Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 5),
          child:  Text(
                              Last_Name,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 14.0, left: 5),
                                child: Text(
                                  "Email :",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Chip(
                                padding: EdgeInsets.only(top: 15),
                                backgroundColor: Colors.amber[100],
                                label: Text(
                                  Email,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 14.0, left: 5),
                                  child: Text(
                                    "EmployeeId :",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Chip(
                                labelPadding: EdgeInsets.only(top: 15),
                                backgroundColor: Colors.amber[100],
                                label: Text(
                                  Gid,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 0,
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: RaisedButton(
                            child: Text(" Logs "),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmpCard(Gid)),
                              );
                            },
                            color: Color(0xff0091EA),
                            textColor: Colors.white,
                            splashColor: Colors.grey,
                            padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                          )),
                      SizedBox(
                        width: 50,
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: RaisedButton(
                            child: Text(" Attendance "),
                            onPressed: () {
                              print(Status);
                              if (Status != '2') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UploadImageDemo()));
                              } else {
                                return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Attendance Status"),
                                    content: Text(
                                        "Your Today's Both Attendance are marked."),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text("okay"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            color: Color(0xff0091EA),
                            textColor: Colors.white,
                            splashColor: Colors.grey,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ))
                    ],
                  ),
                ],
              ),
          )
                ],
              );

          }
        });
  }
}
