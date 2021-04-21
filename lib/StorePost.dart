import 'dart:convert';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StorePost extends StatefulWidget {
  @override
  _StorePostState createState() => _StorePostState();
}

class _StorePostState extends State<StorePost> {
  TextEditingController FirstName = new TextEditingController();
  TextEditingController LastName = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController Mobile = new TextEditingController();
  TextEditingController Address = new TextEditingController();
  var datauser = null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color.fromRGBO(4, 170, 176, 1),
                Color.fromRGBO(3, 205, 172, 1)
              ],
            ),
          ),

        ),
        title: Text("SIGN UP"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: FirstName,
                          decoration:
                              new InputDecoration(labelText: 'FirstName'),
                          style: TextStyle(fontSize: 20, color: Colors.white24,
                           decorationStyle: TextDecorationStyle.wavy,
                           ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: LastName,
                          decoration:
                              new InputDecoration(labelText: "Last Name"),
                          style: TextStyle(fontSize: 20, color: Colors.white24,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: Email,
                          decoration: new InputDecoration(labelText: "Email"),
                          style: TextStyle(fontSize: 20, color: Colors.white24,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: Password,
                          decoration:
                              new InputDecoration(labelText: "Password"),
                          style: TextStyle(fontSize: 20, color: Colors.white24,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: Mobile,
                          decoration: new InputDecoration(labelText: "Mobile"),
                          style: TextStyle(fontSize: 20, color: Colors.white24,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: Address,
                          decoration: new InputDecoration(labelText: "Address"),
                          style: TextStyle(fontSize: 20, color: Colors.white24,
                          ),
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                          onPressed: () {
                            Register(
                              FirstName.text,
                              LastName.text,
                              Email.text,
                              Password.text,
                              Mobile.text,
                              Address.text,
                            );
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Signed Up'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('You are successfully registered'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('LogIn'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(

                              borderRadius:BorderRadius.circular(5.0),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Color.fromRGBO(3, 205, 172, 1),
                                  Colors.cyanAccent
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Text('Submit',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void Register(String FirstNamei, String LastNamei, String Emaili,
      String Passwordi, String Mobilei, String Addressi) async {
    int number = int.parse(Mobilei);
    final response = await http.get(
        "http://ubiattendance.zentylpro.com/index.php/AttendanceAK/create?First_Name=$FirstNamei&Last_Name=$LastNamei&Email=$Emaili&Password=$Passwordi&Mobile=$number&Address=$Addressi");
    datauser = json.decode(response.body.toString());

  }
}

/*
*
*/
//========================================================================================================
//// List <String> array = [
//   //   'C',"C++","Python","Android","Flutter",
//   // ] ;
//   // String dropdownValue = 'C';

// DropdownButton<String>(
//   value: dropdownValue,
//   onChanged: (String newValue) {
//     setState(() {
//       dropdownValue = newValue;
//     });
//   },
//   items: array
//       .map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(value),
//     );
//   }).toList(),
// )
