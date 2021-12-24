import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/deleteddetails.dart';
import 'package:flutter_mysql_crud/forwarddetails.dart';
import 'package:flutter_mysql_crud/newdata.dart';
import 'package:flutter_mysql_crud/pendingdetails.dart';
import 'package:flutter_mysql_crud/randomcolor.dart';
import 'package:flutter_mysql_crud/reviseddetails.dart';
import 'package:flutter_mysql_crud/userUser.dart';
import 'package:flutter_mysql_crud/userservice.dart';
import 'approveddetails.dart';
import 'denieddetails.dart';
import 'services.dart';
//import 'UUsers.dart';
import 'Constants.dart';

/* main() {
  const oneSec = Duration(seconds: 1);
  Timer.periodic(oneSec, (Timer t) => print('hi!'));
} */

class UserDashboard extends StatefulWidget {
  //
  UserDashboard() : super();
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  //
  Timer timer;
  List<UUser> _users;
  //List request = [];
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    SServices.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
    /*  main();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => JsonParseDemo()); */
  }

  @override
  Widget build(BuildContext context) {
    var choiceAction;
    var orientation;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFECA585),
          centerTitle: true,
          title: Text(
            _loading ? 'Loading...' : 'DAAPP',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          /*  actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ], */
          /*  bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
              ),
            ],
          ) ,*/
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFEBA889),
                ),
                child: Text(
                  'DAAPP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UserDashboard()));
                },
                leading: Icon(Icons.analytics),
                title: Text('DashBoard'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => NewData()));
                },
                leading: Icon(Icons.edit),
                title: Text('Request Form'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UserDashboard()));
                },
                leading: Icon(Icons.report_sharp),
                title: Text('Reports'),
              ),
              /*  ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => adminDash()));
                },
                leading: Icon(Icons.pending_actions_outlined),
                title: Text('Menu'),
              ), */
            ],
          ),
        ),
        backgroundColor: Color(0xFFEBA889),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
              // itemCount: 20,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (orientation == Orientation.portrait) ? 2 : 2),
              itemCount: null == _users ? 0 : _users.length,
              itemBuilder: (context, index) {
                UUser user = _users[index];
                // request = user.requeststatus as List;
                // print(request);
                print(user.requeststatus);

                return new GestureDetector(
                    child: new Card(
                  color: RandomColorModel().getColor(),
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )),
                  child: ListTile(
                    //  leading: Icon(Icons.analytics_rounded, size: 45),
                    title: Text(user.requeststatus,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    subtitle: new Center(
                      child: Text(user.count,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    /* child: GridTile(
                        footer: Text(user.count,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 50)),
                        //new chil:Tex,
                        child: Text(user.requeststatus.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontFamily: 'helvetica_neue_medium',
                                fontWeight: FontWeight.bold,
                                fontSize: 30)),

                        /* onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => adminDash()));
                  },  */
                      ) */

                    onTap: () {
                      switch (user.requeststatus.toLowerCase()) {
                        case "denied":
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DeniedDetails()));
                          }
                          break;
                        case "approved":
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ApprovedDetails()));
                          }
                          break;
                        /*  case "revised":
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RevisedDetails()));
                          }
                          break; */
                        case "pending":
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PendingDetails()));
                          }
                          break;
                        case "approved":
                          {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => adminDash()));
                          }
                          break;
                        case "forward":
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ForwardDetails()));
                          }
                          break;
                        case "delete":
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => deleteDetails()));
                          }
                          break;
                        default:
                          break;
                      }
                      /*  showDialog(
                builder: (context) => new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  content: new Text("Selected Item $index"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ),
                barrierDismissible: false,
                context: context,
              ); */
                    },
                  ),
                ));
              }),
        ));
  }
}
/* body: GridView.builder(
  itemCount: data.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
  itemBuilder: (BuildContext context, int index) {
    return new Card(
      child: new GridTile(
        footer: new Text(data[index]['name']),
        child: new Text(data[index]
            ['image']), //just for testing, will fill with image later
      ),
    );
  },
), */