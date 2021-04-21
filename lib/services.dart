// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// import 'one.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage2(),
//     );
//   }
// }
//
// class MyHomePage2 extends StatefulWidget {
//   @override
//   _MyHomePage2State createState() => _MyHomePage2State();
// }
//
// class _MyHomePage2State extends State<MyHomePage2> {
//   File pickedFile;
//   File tmpFile;
//   String fileName;
//   String _dateString;
//   String _time;
//   int Status;
//   var Email;
//   var Gid;
//   var Splitimg;
//   String base64Image;
//   static final String uploadEndPoint =
//       'http://192.168.0.200/Ankit/UbiAttendance/index.php/Attendance/Image';
//
//   final picker = ImagePicker();
//
//   var responseJson;
//
//     var check_Att_id;
//
//
//
//   void initState() {
//     // TODO: implement initState
//     ShareData();
//     super.initState();
//     Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
//   }
//
//
//
//
//   // ignore: non_constant_identifier_names
//   ShareData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       Gid = prefs.getString("id");
//       Email = prefs.getString("Email");
//       _attendanceData();
//     });
//   }
//   _attendanceData() async {
//     check_Att_id = await http.get(
//         "http://192.168.0.200/Ankit/UbiAttendance/index.php/Attendance/EmpAttcheck?Emp_id=$Gid");
//     setState(() {
//       responseJson = jsonDecode(check_Att_id.body.toString());
//     });
//     Status = responseJson['Attendance_Status'];
//   }
//
//   void _getTime() {
//     final String time = DateFormat("H:m:s").format(DateTime.now());
//     final String formattedDateTime =
//         DateFormat('y-M-d').format(DateTime.now()).toString();
//     setState(() {
//       _dateString = formattedDateTime;
//       _time = time;
//     });
//   }
//   Future getImage() {
//
//      var pickedFile = ImagePicker.pickImage(source: ImageSource.camera);
//      tmpFile = pickedFile;
//
//     setState(() {
//        if (null != tmpFile) {
//          print('errMessage');
//
//         if (Status == 1) {
//           fileName = tmpFile.path.split('/').last;
//           _attDataOUT(fileName);
//           Upload(fileName);
//           } else {
//           fileName = tmpFile.path.split('/').last;
//             _attDataIN(fileName);
//             Upload(fileName);
//           }
//        }
//       else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   Upload(img){
//   http.post(uploadEndPoint, body: {
//   "image": base64Image,
//   "name": img,
//     });}
//
//
//   void _attDataIN(img) async {
//     Status = 1;
//     final response = await http.post(
//         "http://192.168.0.200/Ankit/UbiAttendance/index.php/Attendance/EmpAtt?Time_in_Image=$img&Data=$_dateString&Time_in_time=$_time&AttStatus=$Status&Emp_id=$Gid&Emp_Email=$Email");
//   }
//
//   void _attDataOUT(image) async {
//     Status = 2;
//     final response = await http.post(
//         "http://192.168.0.200/Ankit/UbiAttendance/index.php/Attendance/EmpAttupd?Time_Out_Image=$image&Time_Out_time=$_time&AttStatus=$Status&Emp_id=$Gid");
//     Status = 0;
//     Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
//   }
//
//
//   Widget showImage() {
//
//     FutureBuilder<File>(
//       future: pickedFile,
//       builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done &&
//             null != snapshot.data) {
//           tmpFile = snapshot.data;
//           return Container(
//               height: MediaQuery.of(context).size.height * 0.6,
//               width: MediaQuery.of(context).size.width * 0.8,
//               decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(width: 2, color: Colors.tealAccent),
//                     right: BorderSide(width: 2, color: Colors.tealAccent),
//                     left: BorderSide(width: 2, color: Colors.tealAccent),
//                     bottom: BorderSide(width: 2, color: Colors.tealAccent),
//                   )),
//               child: Column(
//                 children: [
//                   // ElevatedButton.icon(onPressed: null, icon: null, label: null),
//                   const Icon(
//                     Icons.account_circle_rounded,
//                     color: Colors.teal,
//                     size: 180.0,
//                   ),
//                   Text(Email, style: TextStyle(fontSize: 20)),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.25,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: new BorderRadius.all(
//                                   new Radius.circular(4))),
//                           height: MediaQuery.of(context).size.height * 0.05,
//                           textColor: Colors.black87,
//                           color: Colors.greenAccent,
//                           child: Text(
//                             "Time_Out",
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                           onPressed: () {
//                             getImage();
//                           }),
//                     ],
//                   )
//                 ],
//               ));
//         }else if (null != snapshot.error) {
//           return const Text(
//             'Error Picking Image',
//             textAlign: TextAlign.center,
//           );
//         } else {
//           return const Text(
//             'No Image Selected',
//             textAlign: TextAlign.center,
//           );
//         }
//       },
//     );
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance'),
//       ),
//       body: Center(
//           child: Status == 1
//               ?showImage()
//               : Container(
//                   height: MediaQuery.of(context).size.height * 0.6,
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   decoration: BoxDecoration(
//                       border: Border(
//                     top: BorderSide(width: 2, color: Colors.tealAccent),
//                     right: BorderSide(width: 2, color: Colors.tealAccent),
//                     left: BorderSide(width: 2, color: Colors.tealAccent),
//                     bottom: BorderSide(width: 2, color: Colors.tealAccent),
//                   )),
//                   child: Column(
//                     children: [
//                       // ElevatedButton.icon(onPressed: null, icon: null, label: null),
//                       const Icon(
//                         Icons.account_circle_rounded,
//                         color: Colors.teal,
//                         size: 180.0,
//                       ),
//                       Text(Email, style: TextStyle(fontSize: 20)),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.25,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: new BorderRadius.all(
//                                       new Radius.circular(4))),
//                               height: MediaQuery.of(context).size.height * 0.05,
//                               textColor: Colors.black87,
//                               color: Colors.greenAccent,
//                               child: Text(
//                                 "Time_IN",
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontStyle: FontStyle.italic,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 getImage();
//                               }),
//                         ],
//                       )
//                     ],
//                   ))
//           // Image.file(_image),//=================================Image presentation========================================
//           ),
//
//     );
//   }
// }
//
// //
// // //GallerySaver.saveImage("{$cpath}+{$pickedFile}");
// // // _image = pickedFile ;
// // //img = _image.toString();
// // //Splitimg  =  img .replaceAll('\'', '');
//
//
// //
// //
// // import 'package:flutter/material.dart';
// // import 'dart:io';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:image_picker/image_picker.dart';
// //
// // class UploadImageDemo2 extends StatefulWidget {
// //   UploadImageDemo2() : super();
// //
// //   final String title = "Upload Image Demo";
// //
// //   @override
// //   UploadImageDemo2State createState() => UploadImageDemo2State();
// // }
// //
// // class UploadImageDemo2State extends State<UploadImageDemo2> {
// //   //
// //   static final String uploadEndPoint =
// //       'http://192.168.0.200/Ankit/UbiAttendance/index.php/Attendance/Image';
// //   Future<File> file;
// //   String status = '';
// //   String base64Image;
// //   File tmpFile;
// //   String errMessage = 'Error Uploading Image';
// //
// //   chooseImage() {
// //     setState(() {
// //       file = ImagePicker.pickImage(source: ImageSource.camera);
// //     });
// //     setStatus('');
// //   }
// //
// //   setStatus(String message) {
// //     setState(() {
// //       status = message;
// //     });
// //   }
// //
// //   startUpload() {
// //     setStatus('Uploading Image...');
// //     if (null == tmpFile) {
// //       setStatus(errMessage);
// //       return;
// //     }
// //     String fileName = tmpFile.path.split('/').last;
// //     upload(fileName);
// //   }
// //
// //   upload(String fileName) {
// //     http.post(uploadEndPoint, body: {
// //       "image": base64Image,
// //       "name": fileName,
// //     }).then((result) {
// //       setStatus(result.statusCode == 200 ? Next() : errMessage);
// //     }).catchError((error) {
// //       setStatus(error);
// //     });
// //
// //   }
// //
// //   Next(){
// //     print("Helllllllllll no");
// //   }
// //
// //
// //   Widget showImage() {
// //     return FutureBuilder<File>(
// //       future: file,
// //       builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
// //         if (snapshot.connectionState == ConnectionState.done &&
// //             null != snapshot.data) {
// //           tmpFile = snapshot.data;
// //           base64Image = base64Encode(snapshot.data.readAsBytesSync());
// //           return Flexible(
// //             child: Image.file(
// //               snapshot.data,
// //               fit: BoxFit.fill,
// //             ),
// //           );
// //         } else if (null != snapshot.error) {
// //           return const Text(
// //             'Error Picking Image',
// //             textAlign: TextAlign.center,
// //           );
// //         } else {
// //           return const Text(
// //             'No Image Selected',
// //             textAlign: TextAlign.center,
// //           );
// //         }
// //       },
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Upload Image Demo"),
// //       ),
// //       body: Container(
// //         padding: EdgeInsets.all(30.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: <Widget>[
// //             OutlineButton(
// //               onPressed: chooseImage,
// //               child: Text('Choose Image'),
// //             ),
// //             SizedBox(
// //               height: 20.0,
// //             ),
// //             showImage(),
// //             SizedBox(
// //               height: 20.0,
// //             ),
// //             OutlineButton(
// //               onPressed: startUpload,
// //               child: Text('Upload Image'),
// //             ),
// //             SizedBox(
// //               height: 20.0,
// //             ),
// //             Text(
// //               status,
// //               textAlign: TextAlign.center,
// //               style: TextStyle(
// //                 color: Colors.green,
// //                 fontWeight: FontWeight.w500,
// //                 fontSize: 20.0,
// //               ),
// //             ),
// //             SizedBox(
// //               height: 20.0,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }