import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/Design.dart';

void main() {
   
runApp( StaffInfo());
}
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


class StaffInfo extends StatelessWidget {


  
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: colorCustom,
      ),
      home: MyHomePage1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage1 extends StatefulWidget {

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  int currentIndex;

  String Field;


  _MyHomePage1State() {
    getData();
  }
  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Field=prefs.getString("Field");
    return Field;
  }



  @override
  void initState() {
    super.initState();

    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$Field Details",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0.2,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        currentIndex: currentIndex,
        hasInk: true,
        inkColor: Colors.black12,
        onTap: changePage,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
            title: Text('Home'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(
              Icons.folder_open,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.folder_open,
              color: Colors.indigo,
            ),
            title: Text('Folders'),
          ),
          BubbleBottomBarItem(

            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.assignment_ind_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.assignment_ind_outlined,
              color: Colors.deepPurple,
            ),
            title: Text('Emp_Detail'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.menu,
              color: Colors.green,
            ),
            title: Text('Menu'),
          ),
        ],
      ),
      body: MyHomePage(),
    );
  }
}
