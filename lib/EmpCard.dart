import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class EmpCard extends StatefulWidget {
  var empId;

  EmpCard(this.empId);


  @override
  _EmpCardState createState() => _EmpCardState(this.empId);
}
class _EmpCardState extends State<EmpCard> {
  var empId;
  var val;
  var _Id;
  _EmpCardState(this.empId);
  var responseJson;
  @override
  void initState() {
    initplatformstate();
  }

  Future initplatformstate() async {
    _Id=empId;

    var res = await http.get('http://ubiattendance.zentylpro.com/index.php/AttendanceAK/EmpLog?Id=$_Id');
    setState(() {
     responseJson = jsonDecode(res.body.toString());
    });
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
         future: initplatformstate(),
         builder:(BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.data == null)
      {
        return Center(
            child:Text('NO Attendance is Presents')
        );

      }

      else
      {
        return ListView.builder(
          itemCount:snapshot.data.length,
          itemBuilder:(BuildContext context, int index )
          {
            return new Card(
              child:Column(
                children: [
                  Row(

                    children: [
                      Text('Date',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      Center( heightFactor: 2.0,
                        child: Text(snapshot.data[index]['date']),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded( flex: 2,
                        child: Container(
                            child:  CircleAvatar(
                              backgroundImage:NetworkImage("http://ubiattendance.zentylpro.com/assets/${snapshot.data[index]['Time_In_image']}"),
                              radius: 50,
                            )),
                      ),

                      Expanded( flex: 2,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("http://ubiattendance.zentylpro.com/assets/${snapshot.data[index]['Time_Out_image']}"),
                            radius: 50,
                          )),

                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: const EdgeInsets.only(left:40.0,),
                        child:Text('Time IN: ', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ),

                      Text(snapshot.data[index]['Time_In_time']),
                      SizedBox(width: 50,),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child:Text('Time Out: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      Text(snapshot.data[index]['Time_Out_time']),
                    ],)

                ],
              ),
            );
          },
        );
      }


    }
    )
        ),
    );
  }
}
