import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'mydatamodel.dart';

void main() => runApp(MaterialApp(
      home: MyAppCountry(),
    ));

class MyAppCountry extends StatefulWidget {
  @override
  _MyAppCountryState createState() => _MyAppCountryState();
}

class _MyAppCountryState extends State<MyAppCountry> {
  List<Welcome> _postList = new List<Welcome>();

  Future<List<Welcome>> fetchingData() async {

    final responce = await http.get('https://restcountries.eu/rest/v2/all');
    List<dynamic> values = new List<dynamic>();
    values = json.decode(responce.body);

    if (values.length > 0) {

      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          _postList.add(Welcome.fromJson(map));
        }
      }
    }
    print(_postList.length.toString());
    return _postList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        builder: (context, projectSnap) {

          if (projectSnap.connectionState != ConnectionState.done) {
            return Center(child:  CircularProgressIndicator(backgroundColor: Colors.blue),);
          }

          return ListView.builder(

            itemCount: projectSnap.data.length,
            itemBuilder: (context, index) {

              Welcome project = projectSnap.data[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    color: Colors.green,
                    margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      project.name,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  )
                  // Widget to display the list of project
                ],
              );
            },

          );
        },
        future: fetchingData(),
      ),
    );
  }
}

