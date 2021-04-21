import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio_project1/EmpCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var responseJson;

  var index = 0;

  var EmpId;



  Future _getDAta() async {
    var res = await http.get(
        'http://ubiattendance.zentylpro.com/index.php/AttendanceAK/emp');

    setState(() {
      responseJson = jsonDecode(res.body.toString());
    });
    return responseJson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
           Text("Employee-Details"),
        centerTitle: true,

      ),


      body: FutureBuilder(
        future: _getDAta(),
        builder: (context,snapshot) {
          if( snapshot.data!=null) {
            return Container(
              child: CarouselSlider.builder(
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                height: 600,
                itemCount: (responseJson.length).round(),
                itemBuilder: (context, index) {
                  final int first = index * 1;


                  return Row(
                    children: [first].map((idx) {
                     EmpId= responseJson[idx]['id'];
                      return Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 600,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 50),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          2, 18.0, 2, 18.0),
                                      child: CircleAvatar(
                                        radius: 80.0,
                                        backgroundImage: NetworkImage(
                                            "http://www.newsshare.in/wp-content/uploads/2/Profile-WhatsApp-DP-13.jpg"),
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 5.0,
                                      runSpacing: 4.0, // gap between lines
                                      direction: Axis.horizontal,
                                      children: [
                                        Text(
                                          responseJson[idx]['First_Name'] + " ",
                                          style: TextStyle(fontSize: 28.0),
                                        ),
                                        Text(
                                          responseJson[idx]['Last_Name'],
                                          style: TextStyle(fontSize: 28.0),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 20, 0, 0),
                                          child: Wrap(
                                            spacing: 5.0,
                                            runSpacing: 4.0,
                                            // gap between lines
                                            direction: Axis.vertical,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(12, 8.0, 2, 8.0),
                                                child: Text("Email :"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(12, 8.0, 2, 8.0),
                                                child: Text("Address :"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(12, 8.0, 2, 8.0),
                                                child: Text("Mobile :"),
                                              ),


                                            ],
                                          ),
                                        ),
                                        Center(child:
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: Column(
                                            // mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(10, 12.0, 0, 8.0),
                                                child: Text(
                                                  responseJson[idx]['Email'],
                                                  style: TextStyle(
                                                      fontSize: 15.0),),
                                              ),


                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(10, 12.0, 0, 8.0),
                                                child: Text(
                                                  responseJson[idx]['Address'],
                                                  style: TextStyle(
                                                      fontSize: 15.0),),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(10, 12.0, 0, 10.0),
                                                child: Text(
                                                  responseJson[idx]['Mobile'],
                                                  style: TextStyle(
                                                      fontSize: 15.0),),
                                              ),

                                            ],
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3,),


                                    Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child:
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [



                                          TextButton(child: Text(
                                            'Emp Details' + "  ",
                                            style: TextStyle(fontSize: 20.0),),
                                            onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EmpCard(responseJson[index]['id'])));
                                          print(responseJson[index]['id']);
                                            },
                                            style: TextButton.styleFrom(
                                              primary: Colors.teal,),

                                          )
                                        ],
                                      ),
                                    ),

                                  ],

                                ),
                              )

                            ],


                          ),
                        ),

                      );
                    }).toList(),
                  );
                },

              ),

            );
          }
          else{
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }

}
//
//
