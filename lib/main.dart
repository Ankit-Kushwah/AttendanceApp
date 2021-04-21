import 'dart:convert';
import 'package:dio_project1/services.dart';
import 'package:flutter/material.dart';
import 'Design.dart';
import 'EmpAttendance.dart';
import 'Emp_Edit.dart';
import 'Ubihrm.dart';
import 'one.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(new MyApp());
Map<int, Color> color = {
  50: Color.fromRGBO(4, 170, 176, .1),
  100: Color.fromRGBO(4, 170, 176, .2),
  200: Color.fromRGBO(4, 170, 176, .3),
  300: Color.fromRGBO(4, 170, 176, .4),
  400: Color.fromRGBO(4, 170, 176, .5),
  500: Color.fromRGBO(4, 170, 176, .6),
  600: Color.fromRGBO(4, 170, 176, .7),
  700: Color.fromRGBO(4, 170, 176, .8),
  800: Color.fromRGBO(4, 170, 176, .9),
  900: Color.fromRGBO(4, 170, 176, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF04AAB0, color);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Simple Login Demo',
      theme: new ThemeData(
        primarySwatch: colorCustom,
      ),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType.login;

  var responseJson;
  var Email = "";
  var Gid = "";
  var Mobile = "";
  var Address = "";
  var Last_Name = "";
  var First_Name = "";
  var Field = "";

  var id = "";

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form == FormType.register;
      } else {
        _form = FormType.login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: Container(
          padding: EdgeInsets.all(2.0),
          child:SingleChildScrollView (
            child: new Column(
            children: <Widget>[
              _buildImage(),
            SizedBox(height:MediaQuery.of(context).size.height*0.1,),
              _buildTextFields(),
              _buildButtons(),
            ],
          ),
          ),
        ),

    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Login"),
      centerTitle: true,
    );
  }

  Widget _buildImage() {
    return new Container(
      height: MediaQuery.of(context).size.height*0.2,
      child: Image(image: AssetImage('assets/Images/flutter_logo.png')),
    );
  }

  Widget _buildTextFields() {

    return new Container(

      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(labelText: 'Email'),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color.fromRGBO(3, 205, 172, 1),
                        Colors.cyanAccent
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(30, 8, 10, 2),
                  child: const Text('LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
                onPressed: () async {
                  _loginPressed();
                },
              ),
            ),

            SizedBox(height:MediaQuery.of(context).size.height*0.32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new FlatButton(
                    child: new Text('Forgot Password?'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UploadImageDemo()),
                      );
                    }),
              ],
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password
  Future<String> setdata() async {
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    Prefs.setString("First_Name", responseJson["First_Name"]);
    Prefs.setString("Last_Name", responseJson["Last_Name"]);
    Prefs.setString("Email", responseJson["Email"]);
    Prefs.setString("Mobile", responseJson["Mobile"]);
    Prefs.setString("Address", responseJson["Address"]);
    Prefs.setString("Field", responseJson["Field"]);
    Prefs.setString("id", responseJson["id"]);

    if (responseJson['Field'] == "Admin") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
    }
  }
  void _loginPressed() async {
    var res = await http.get(
        'http://ubiattendance.zentylpro.com/index.php/AttendanceAK/login?email=$_email&password=$_password');
    setState(() {
      responseJson = jsonDecode(res.body.toString());
      if (responseJson['status'] == 'false') {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signed Up'),
              content:
                 ListBody(
                  children: <Widget>[
                    Text('Please Enter Correct Email and PassWord  '),
                  ],
                ),

              actions: <Widget>[
                TextButton(
                  child: Container(
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
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('Login', style: TextStyle(fontSize: 20)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        setdata();
      }
    });
  }
}
