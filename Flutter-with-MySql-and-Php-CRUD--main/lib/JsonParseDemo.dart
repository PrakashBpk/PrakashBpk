import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/pendingdetails.dart';
import 'package:flutter_mysql_crud/randomcolor.dart';
import 'package:flutter_mysql_crud/reviseddetails.dart';
import 'approveddetails.dart';
import 'denieddetails.dart';
import 'services.dart';
import 'Users.dart';
import 'Constants.dart';

class JsonParseDemo extends StatefulWidget {
  //
  JsonParseDemo() : super();
  @override
  _JsonParseDemoState createState() => _JsonParseDemoState();
}

class _JsonParseDemoState extends State<JsonParseDemo> {
  //
  List<User> _users;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
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
                  color: Colors.indigoAccent,
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
                      MaterialPageRoute(builder: (_) => ApprovedDetails()));
                },
                leading: Icon(Icons.analytics),
                title: Text('DashBoard'),
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
                User user = _users[index];
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
                      leading: Icon(Icons.analytics_rounded, size: 45),
                      title: Text(user.requeststatus),
                      subtitle: Text(user.count),
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
                  ),
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
                      case "revised":
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RevisedDetails()));
                        }
                        break;
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
                );
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