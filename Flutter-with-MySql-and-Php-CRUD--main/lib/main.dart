import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/JsonParseDemo.dart';
import 'package:flutter_mysql_crud/Login.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/dash.dart';
import 'package:flutter_mysql_crud/tapbarchecking.dart';
import 'package:flutter_mysql_crud/userlogin.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'details.dart';
import 'newdata.dart';

void main() => runApp(MaterialApp(
      title: "DAAPP",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginWidget(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final responce = await http.get("http://14.141.213.116:861/getData.php");
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color.fromRGBO(140, 158, 255, 1.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contex) => NewData(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.hasError) {
            print("error");
          }
          if (ss.hasData) {
            return Items(list: ss.data);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;

  Items({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            //      leading:
            title: Text(list[i]['id']),

            subtitle: Text(list[i]['name']),

            //subtitle: Text(list[i]['salesexcutivename']),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Details(list: list, index: i),
            )),
          );
        });
  }
}
