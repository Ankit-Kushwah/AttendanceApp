import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'one.dart';

class UploadImageDemo extends StatefulWidget {
  UploadImageDemo() : super();

  final String title = "Upload Image Demo";

  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}

class UploadImageDemoState extends State<UploadImageDemo> {
  static final String uploadEndPoint =
      'http://ubiattendance.zentylpro.com/index.php/AttendanceAK/Image';
  File file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  var Gid;
  var Email;
  var check_Att_id;
  var responseJson;
  var Status1;
  String _dateString;
  String _time;
  var set = 0;

  void initState() {
    // TODO: implement initState
    ShareData();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }
  void _getTime() {
    final String time = DateFormat("H:m:s").format(DateTime.now());
    final String formattedDateTime =
    DateFormat('y-M-d').format(DateTime.now()).toString();

      _dateString = formattedDateTime;
      _time = time;

  }

  ShareData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Gid = prefs.getString("id");
      Email = prefs.getString("Email");
    });
    _attendanceData();
  }

  _attendanceData() async {
    check_Att_id = await http.post(
        "http://ubiattendance.zentylpro.com/index.php/AttendanceAK/EmpAttcheck?Emp_id=$Gid");
    setState(() {
      responseJson = jsonDecode(check_Att_id.body.toString());
    });
    Status1 = responseJson['Attendance_Status'];
    // print(Status1);
  }



// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>
  chooseImage() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera);
    base64Image = base64Encode(file.readAsBytesSync());
    setStatus('');
    setState(() {
      if (null == file) {
        print('No image selected.');
      }
      else {
        if (Status1 == "1") {
          String fileName = file.path.split('/').last;
          uploadout(fileName);
        } else {
          String fileName = file.path.split('/').last;
          uploadin(fileName);
        }
      }
    });
  }
  //            ==================================
  setStatus(String message) {
    print("setStatus is working");
    setState(() {
      status = message;
    });
  }


  _attDataIN(img) async {
    Status1 = "1";
    final response = await http.post(
        "http://ubiattendance.zentylpro.com/index.php/AttendanceAK/EmpAtt?Time_in_Image=$img&Data=$_dateString&Time_in_time=$_time&AttStatus=$Status1&Emp_id=$Gid&Emp_Email=$Email");
  }

  _attDataOUT(image) async {
    Status1 = "2";
    final response = await http.post(
        "http://ubiattendance.zentylpro.com/index.php/AttendanceAK/EmpAttupd?Time_Out_Image=$image&Time_Out_time=$_time&AttStatus=$Status1&Emp_id=$Gid");

    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  }



  uploadout(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? _attDataOUT(fileName) : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  uploadin(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? _attDataIN(fileName) : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image Demo"),
      ),
      body: Center(
          child:Status1 == "1" ?Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 2, color: Colors.tealAccent),
                    right: BorderSide(width: 2, color: Colors.tealAccent),
                    left: BorderSide(width: 2, color: Colors.tealAccent),
                    bottom: BorderSide(width: 2, color: Colors.tealAccent),
                  )),
                  child: Column(
                    children: [
                      // ElevatedButton.icon(onPressed: null, icon: null, label: null),
                      const Icon(
                        Icons.account_circle_rounded,
                        color: Colors.teal,
                        size: 180.0,
                      ),
                      Text(Email, style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(4))),
                              height: MediaQuery.of(context).size.height * 0.05,
                              textColor: Colors.black87,
                              color: Colors.greenAccent,
                              child: Text(
                                "Time_OUT",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              onPressed: () {
                                chooseImage();
                              }),

                        ],
                      )
                    ],
                  ))
              : Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 2, color: Colors.tealAccent),
                    right: BorderSide(width: 2, color: Colors.tealAccent),
                    left: BorderSide(width: 2, color: Colors.tealAccent),
                    bottom: BorderSide(width: 2, color: Colors.tealAccent),
                  )),
                  child: Column(
                    children: [
                      // ElevatedButton.icon(onPressed: null, icon: null, label: null),
                      const Icon(
                        Icons.account_circle_rounded,
                        color: Colors.teal,
                        size: 180.0,
                      ),
                      Text(Email, style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(4))),
                              height: MediaQuery.of(context).size.height * 0.05,
                              textColor: Colors.black87,
                              color: Colors.greenAccent,
                              child: Text(
                                "Time_IN",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              onPressed: () {
                                chooseImage();
                              }),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Text(
                        status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ))
          // Image.file(_image),//=================================Image presentation========================================
          ),
    );
  }
}
