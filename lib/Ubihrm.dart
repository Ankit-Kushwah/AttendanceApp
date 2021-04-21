import 'package:flutter/material.dart';

void main() {
  runApp(EMPNOTIFICATION());
}

class EMPNOTIFICATION extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Notification());
  }
}

class Notification extends StatefulWidget {

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  bool isSwitched = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  bool isSwitched4 = false;
  bool _TimeoffEndSwt1 =false;
  bool _TimeoffEndSwt2 =false;
  bool _TimeoffEndSwt3 =false;
  bool _TimeoffEndSwt4 =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Notifications"),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ListTile(
                    title: Text('On Time off Start'),
                    subtitle: Text('(Every time for every Employee)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('On Time off End'),
                    subtitle: Text('(Every time for every Employee)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Visit punch'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Outside Geofence'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Fake Location'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Face ID registration'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Face ID disapproved'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _TimeoffEnd(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Suspicious Selfie'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Suspicious Device'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Disapproved Attendance'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _TimeoffEnd(context),
                          );
                        }),
                  ),
                ],
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    title: Text('Attendance edited'),
                    subtitle: Text('(Every Instance)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 325, top: 10),
                    child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'To Change',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _TimeoffEnd(context),
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ), );
  }

  Widget _buildPopupDialog(BuildContext context) {

    return new AlertDialog(
      title: const Text('On Time off Start',textAlign: TextAlign.center),
      content:StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Divider(thickness: 2,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 25, top: 0),
                              child: Text('App', textAlign: TextAlign.left),),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 25, top: 30),
                              child: Text('Mail', textAlign: TextAlign.left),),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 25, top: 30),
                              child: Text(
                                  'Employee', textAlign: TextAlign.left),),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 25, top: 30),
                              child: Text('Admin', textAlign: TextAlign.left),),
                          ]),
                      Column(children: [
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                        Switch(
                          value: isSwitched2,
                          onChanged: (value) {
                            setState(() {
                              isSwitched2= value;
                              print(isSwitched2);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                        Switch(
                          value: isSwitched3,
                          // onChanged: (value) {
                          //
                          // },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                        Switch(
                          value: isSwitched4,
                          onChanged: (value) {
                            setState(() {
                              isSwitched4 = value;
                              print(isSwitched4);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        )

                      ]),


                    ]),

              ]);
        }
        ),
      actions: <Widget>[

Padding(padding: const EdgeInsets.only(right: 70),
child:  Row(

  children: [
    MaterialButton(onPressed: (){
      Navigator.of(context).pop();
    },
      child:Text("Save"),
    ),

    new FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      textColor: Theme.of(context).primaryColor,
      child: const Text('Cancel'),
    ),

  ],),
)

      ],
    );
  }

  Widget _TimeoffEnd(BuildContext context) {
    return new AlertDialog(
      title: const Text('On Time off End', textAlign: TextAlign.center),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Divider(
                    thickness: 2,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 25, top: 0),
                            child: Text('App',),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25, top: 30),
                            child: Text('Mail',),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25, top: 30),
                            child: Text('Employee',),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25, top: 30),
                            child: Text('Admin',),
                          ),
                        ]),
                    Column(children: [
                      Switch(
                        value: _TimeoffEndSwt1,
                        onChanged: (value) {
                          setState(() {
                            _TimeoffEndSwt1 = value;
                            print(_TimeoffEndSwt1);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                      Switch(
                        value: _TimeoffEndSwt2,

                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                      Switch(
                        value: _TimeoffEndSwt3,
                        onChanged: (value) {
                          setState(() {
                            _TimeoffEndSwt3 = value;
                            print(_TimeoffEndSwt3);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                      Switch(
                        value: _TimeoffEndSwt4,
                        // onChanged: (value) {
                        //
                        // },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      )
                    ]),
                  ]),
                ]);
          }),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 70),
          child: Row(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Save"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: Theme.of(context).primaryColor,
                child: const Text('Cancel'),
              ),
            ],
          ),
        )
      ],
    );
  }
Compare(String NotiName, int val) async {
    var num1, num2, num3, num4;
    var value;
    if (val == 1) {
      isSwitched ? num1 = 1 : num1 = 0;
      isSwitched2 ? num2 = 1 : num2 = 0;
      isSwitched3 ? num3 = 1 : num3 = 0;
      isSwitched4 ? num4 = 1 : num4 = 0;
    } else {
      _TimeoffEndSwt1 ? num1 = 1 : num1 = 0;
      _TimeoffEndSwt2 ? num2 = 1 : num2 = 0;
      _TimeoffEndSwt3 ? num3 = 1 : num3 = 0;
      _TimeoffEndSwt4 ? num4 = 1 : num4 = 0;
    }
    value = (num1 * pow(2, 3)) +
        (num2 * pow(2, 2)) +
        (num3 * pow(2, 1)) +
        (num4 * pow(2, 0));
    var Noti = await http.post(path +
        "NotificationTest?ColumnName=$NotiName&Value=$value&OrgId=$orgId");
  }
}
