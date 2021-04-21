import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'EmpCard.dart';
import 'one.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: HomePage3(),
  ));
}

class HomePage3 extends StatefulWidget {
  @override
  _HomePage3State createState() => _HomePage3State();

}


class _HomePage3State extends State<HomePage3> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController Age = new TextEditingController();
  TextEditingController Zip = new TextEditingController();
  TextEditingController City = new TextEditingController();
  TextEditingController States = new TextEditingController();




  var Gid;
  var _Age;

  void _validate() {
    if(_form.currentState.validate())
      {
        Register(Age.text,States.text,City.text,Zip.text,);
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
                    Text('Your Profile is successfully Edit'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Done'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile()),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
    else{
      _form.currentState.validate();
    }

  }

  void Register(String Age,
      String States, String City, String Zip) async {
    // int number = int.parse(Mobilei);
    final response = await http.get(
        "http://ubiattendance.zentylpro.com/index.php/AttendanceAK/Empedit?Age=$Age&States=$States&City=$City&Zip=$Zip&ID=$Gid");
  }



  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
  void initState(){
    Login();
  }
  Future Login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Gid = prefs.getString("id");
    });
  }


  String validateAge(String value) {
    String pattern = r'(^(?:2)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid Age';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child:
              //   TextFormField(
              //       decoration: InputDecoration(
              //           border: OutlineInputBorder(),
              //           labelText: 'Email',
              //           hintText: 'abc@gmail.com'),
              //       validator: MultiValidator([
              //         RequiredValidator(errorText: "* Required"),
              //         MaxLengthValidator(45, errorText: 'password must be at least 8 digits long'),
              //         EmailValidator(errorText: "Enter valid email id"),
              //       ])),
              // ),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child:TextFormField(
              //     validator:
              //     ValidationBuilder().minLength(5).maxLength(50).build(),
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'First_Name',
              //       helperText: 'max length: 50',
              //     ),
              //   ),
              // ),
              //
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child:TextFormField(
              //     validator:
              //     ValidationBuilder().minLength(5).maxLength(50).build(),
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Last_Name',
              //       helperText: 'max length: 50',
              //     ),
              //   ),
              // ),
              //
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child:TextFormField(
              //     validator:
              //     ValidationBuilder().minLength(5).maxLength(50).build(),
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Password',
              //       helperText: 'Min length:6 and max length: 50',
              //     ),
              //   ),
              // ),
              //
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child:TextFormField(
              //     validator: validateMobile,
              //     onSaved: (String val) {
              //       _mobile = val;
              //     },
              //     controller: Mobile,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Mobile',
              //       helperText: 'Mobile Number',
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10,),
              //
              //
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:TextFormField(
                  validator: validateAge,
                  onSaved: (String val){
                    _Age = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // controller: textFieldHolder,

                    labelText: 'Age',
                    helperText: 'Min Age: 18+',
                  ),
                    controller: Age,
                ),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:TextFormField(

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'State',
                    helperText: 'State Name',
                  ),
                  controller: States,

                ),
              ),
              SizedBox(height: 5,),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:TextFormField(

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                    helperText: 'City Name',
                  ),
                  controller: City,

                ),
              ),
              SizedBox(height: 5,),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:TextFormField(
                  validator:
                  ValidationBuilder().minLength(6).maxLength(7).build(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Zip Code',
                    helperText: 'Area Code',
                  ),
                  controller: Zip,
                ),
              ),
              SizedBox(height: 5,),

              MaterialButton(
                onPressed: () {
                  _validate();


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
        ),
      ),

    );
  }

}