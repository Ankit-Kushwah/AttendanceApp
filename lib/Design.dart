import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Deshboard.dart';
import 'StorePost.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var responseJson;
  bool ishown = true;
  var Gid;
  var Mobile;
  var Address;
  var Last_Name;
  var First_Name;
  var Field;
  var Email;

  _MyHomePageState() {
    getdata();
  }

  getdata() async {
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
  }

  // _MyHomePageState(this.tb);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADMIN',
          style: TextStyle(fontSize: 16),
        ),
      ),
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
                      Container(

                        child:CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                          
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,

                        ),
                  width: 32.0,
                  height: 32.0,
                  padding: const EdgeInsets.all(2.0), // borde width
                  decoration: new BoxDecoration(
                    color: const Color(0xFFFFFFFF), // border color
                    shape: BoxShape.circle,
                      )
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
              title: Text('Employee Registration'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StorePost() ));
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
      body:SingleChildScrollView(child:Column(
              children: [
                Stack(
                  alignment: Alignment(0.8, 0.8),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Medium_format.jpg/1280px-Medium_format.jpg',
                            width: 400,
                            height: MediaQuery.of(context).size.height*0.41,
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 220.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        radius: 70,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                      ),
                      child: Text(
                        First_Name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.all(20.0),
                    height:MediaQuery.of(context).size.height*0.5,
                    width: 395.0,
                    color: Colors.amber[600],
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0, // gap between lines
                      direction: Axis.horizontal,
                      // const CrossAxisAlignment(0),
                      children: [
                        Chip(
                          label: Text(First_Name),
                        ),
                        Chip(
                          label: Text(Last_Name),
                        ),
                        Chip(
                          label: Text(Address),
                        ),
                        new Chip(
                          label: new Text(Mobile),
                        ),
                        SizedBox(height: 160,
                        width: MediaQuery.of(context).size.width*0.1),
                        Container(
                          padding: EdgeInsets.only(left: 110),
                          child: MaterialButton(
                            color: Color.fromRGBO(4, 170, 176, 0.8),
                            child: Text('Staff Detail'),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard() ));

                            },
                          ),
                        ),
                      ],
                    )),

              ],
            )
    ),

    );
  }
}
