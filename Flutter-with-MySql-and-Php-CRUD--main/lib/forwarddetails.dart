import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/JsonParseDemo.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/approvedViewDetails.dart';
import 'package:flutter_mysql_crud/forwardlist.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'details.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'newdata.dart';

/* void main() => runApp(MaterialApp(
      title: "Api Test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: adminDash(),
    )); */

class ForwardDetails extends StatefulWidget {
  @override
  _ForwardDetailsState createState() => _ForwardDetailsState();
}

class _ForwardDetailsState extends State<ForwardDetails> {
  Future<List> getData() async {
    final responce =
        await http.get("http://14.141.213.116:861/forwarddetails.php");
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forward Lists"),
        backgroundColor: Color(0xFFECA585),
      ),
      /*   floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contex) => JsonParseDemo(),
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
            return approvedItems(list: ss.data);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class approvedItems extends StatelessWidget {
  List list;

  approvedItems({this.list});
  var name;
  @override
  Widget build(BuildContext context) {
    // print(list.length);
    // Text("");

    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          String approved = ('${list.length}');
          print(approved);
          //   new  return Text(data)
          return GestureDetector(
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Forward(list: list, index: i),
                    ),
                  ),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                          child: Text(
                            list[i]['id'],
                            style: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(170, 5, 0, 0),
                          child: Text(
                            list[i]['requestdate'],
                            style: FlutterFlowTheme.bodyText1,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                          child: Text(
                            list[i]['name'],
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                          child: Text(
                            list[i]['carmodel'],
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        /*   Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                      child: Text(
                        list[i]['salesexcutivename'],
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ), */
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                          child: Text(
                            list[i]['yearmake'],
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                          child: Text(
                            list[i]['discountvalue'],
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));

          /* ListTile(
              //      leading:
              // title: Text(list[i]['name']),
              title: Text('${list.length}'),
              subtitle: Text(list[i]['salesexcutivename']),

              //subtitle: Text(list[i]['salesexcutivename']),
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Approvedviewdetails(list: list, index: i),
                    ),
                  )); */
        });
  }
}
