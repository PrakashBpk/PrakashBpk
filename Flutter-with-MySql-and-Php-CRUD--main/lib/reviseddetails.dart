import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/editdata.dart';
import 'package:flutter_mysql_crud/revised.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'details.dart';
import 'newdata.dart';

/* void main() => runApp(MaterialApp(
      title: "Api Test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: adminDash(),
    )); */

class RevisedDetails extends StatefulWidget {
  @override
  _RevisedDetailsState createState() => _RevisedDetailsState();
}

class _RevisedDetailsState extends State<RevisedDetails> {
  Future<List> getData() async {
    final responce =
        await http.get("http://14.141.213.116:861/reviseddetails.php");
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Revised Lists"),
        backgroundColor: Color(0xFFEBA889),
      ),
      /*  floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contex) => NewData(),
          ),
        ),
        child: Icon(Icons.add),
      ), */
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
  var count;
  Items({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            //      leading:
            title: Text(list[i]['salesexcutivename']),
            //title: Text(i),

            subtitle: Text(list[i]['requestdate']),
            trailing: Icon(Icons.keyboard_arrow_right),
            //subtitle: Text(list[i]['salesexcutivename']),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Revised(),
            )),
          );
          // print('list');
        });
  }
}
