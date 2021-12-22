import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/editdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'JsonParseDemo.dart';
import 'Users.dart';
import 'details.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_widgets.dart';
import 'newdata.dart';

/* void main() => runApp(MaterialApp(
      title: "Api Test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: adminDash(),
    )); */
/* main() {
  const oneSec = Duration(seconds: 1);
  Timer.periodic(oneSec, (Timer t) => print('hi!'));
} */

class PendingDetails extends StatefulWidget {
  @override
  _PendingDetailsState createState() => _PendingDetailsState();
}

class _PendingDetailsState extends State<PendingDetails> {
  Future<List> getData() async {
    final responce = await http.get("http://14.141.213.116:861/pending.php");
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Lists"),
        backgroundColor: Color(0xFFEBA889),
      ),
      /* floatingActionButton: FloatingActionButton(
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
  List<User> _users;
  bool _loading;
  Items({this.list});
  void editData(String requeststatus, statuschangetime) {
    var url = "http://14.141.213.116:861/editdata.php";
    var i;
    var widget;
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      /*  "booking_id": bookingId.text,
      "name": cname.text,
      "salesexcutivename": cmobile.text,
      "branch": branch.text,
      "carmodel": carmodel.text,
      "yearmake": yearmake.text,
      "currentoffer": currentoffer.text,
      "discountvalue": discountvalue.text,
      "customerstatus": existingornew.text,
      "referredcustomer": referredcustomer.text,
      "referrername": referrername.text, */
      "requeststatus": requeststatus,
      "statuschangetime": statuschangetime //categoryItemlist
      //"requeststatus": denied(),
      // "requeststatus": reviseed()
    });
  }

  @override
  void initState() {
    // super.initState();
    // setState(() {});
    // editData(requeststatus, statuschangetime);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return GestureDetector(
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
                        "Booking ID",
                        style: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                      child: Text(
                        list[i]['id'],
                        style: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(170, 5, 0, 0),
                    child: Text(
                      list[i]['requestdate'],
                      style: FlutterFlowTheme.bodyText1,
                    ),
                  )
                ]),
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
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          DateTime dateToday = new DateTime.now();
                          String statuschangetime =
                              dateToday.toString().substring(0, 10);
                          editData("denied", statuschangetime);
                          // denied();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    JsonParseDemo()),
                          );
                          /* .then((users) => setState(() {
                                    _users = users;
                                    _loading = true;
                                  })); */

                          print('Button pressed ...');
                        },
                        text: 'Approved',
                        options: FFButtonOptions(
                          width: 70,
                          height: 40,
                          color: Color(0xFF7FD35A),
                          textStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: Color(0xE862E37B),
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          DateTime dateToday = new DateTime.now();
                          String statuschangetime =
                              dateToday.toString().substring(0, 10);
                          editData("denied", statuschangetime);
                          // denied();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    JsonParseDemo()),
                          );
                          /*  .then((users) => setState(() {
                                    _users = users;
                                    _loading = true;
                                  })); */

                          print('Button pressed ...');
                        },
                        text: 'Denied',
                        options: FFButtonOptions(
                          width: 70,
                          height: 40,
                          color: Color(0xFFE98282),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          DateTime dateToday = new DateTime.now();
                          String statuschangetime =
                              dateToday.toString().substring(0, 10);
                          editData("denied", statuschangetime);
                          // denied();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    JsonParseDemo()),
                          );
                          /*  .then((users) => setState(() {
                                    _users = users;
                                    _loading = true;
                                  })); */

                          print('Button pressed ...');
                        },
                        text: 'Revise',
                        options: FFButtonOptions(
                          width: 70,
                          height: 40,
                          color: Color(0xFFEAA74A),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          DateTime dateToday = new DateTime.now();
                          String statuschangetime =
                              dateToday.toString().substring(0, 10);
                          editData("denied", statuschangetime);
                          // denied();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    JsonParseDemo()),
                          );
                          /*  .then((users) => setState(() {
                                    _users = users;
                                    _loading = true;
                                  })); */

                          print('Button pressed ...');
                        },
                        text: 'Forward',
                        options: FFButtonOptions(
                          width: 70,
                          height: 40,
                          color: Color(0xFF4E9EED),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 3,
                  color: Color(0xE8B7A5D1),
                )
              ],
            ),
          ));
          /* ListTile(
            //      leading:
            title: Text(list[i]['salesexcutivename']),
            //title: Text(i),

            subtitle: Text(list[i]['requestdate']),
            trailing: Icon(Icons.keyboard_arrow_right),
            //subtitle: Text(list[i]['salesexcutivename']),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Edit(list: list, index: i),
            )),
          ); */
          // print('list');
        });
  }

  setState(Null Function() param0) {}
}
