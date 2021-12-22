import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/pendingdetails.dart';
import 'package:flutter_mysql_crud/reviseddetails.dart';
import 'approveddetails.dart';
import 'denieddetails.dart';
import 'services.dart';
import 'Users.dart';
import 'Constants.dart';
import 'package:flutter_mysql_crud/randomcolor.dart';

//import '../approved_list/approved_list_widget.dart';
//import '../deleted_list/deleted_list_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
//import '../forwarded_list/forwarded_list_widget.dart';
//import '../pending_info/pending_info_widget.dart';
//import '../revised_list/revised_list_widget.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
      title: "DAAPP",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAppp(),
    ));

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DAAPP',
      home: new Home(),
      theme: new ThemeData(primaryColor: Colors.black),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController tabController;
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
    tabController = new TabController(length: 2, vsync: this);
    var choiceAction;
    var orientation;

    var tabBarItem = new TabBar(
      tabs: [
        new Tab(
          child: Text("Dashboard"),
          // icon: new Icon(Icons.list),
        ),
        new Tab(
          child: Text("Menu"),
          //icon: new Icon(Icons.grid_on),
        ),
      ],
      controller: tabController,
      indicatorColor: Colors.white,
    );

    var gridview = new GridView(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 3,
        childAspectRatio: 1,
      ),
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 20, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PendingDetails()));
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xE8D8A8D3),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pending_actions,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      'Pending',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      '',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 5, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ApprovedDetails()));
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFD2E9E4),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.approval,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      'Approved',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      '',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RevisedDetails()));
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFB9C0EF),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.update_outlined,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: Text(
                      'Revised',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Roboto',
                      color: FlutterFlowTheme.tertiaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 5, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => DeniedDetails()));
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFFCCBCB),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      'Denied',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      '',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyAppp()));
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFEAC3B1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.forward,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      'Forwarded',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      '',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 5, 0),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFD6B3F6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: FlutterFlowTheme.tertiaryColor,
                  size: 50,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Text(
                    'Reports',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Roboto',
                      color: FlutterFlowTheme.tertiaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );

    /* var gridView = new GridView.builder(

        /// itemCount: 20,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2),
        itemCount: null == _users ? 0 : _users.length,
        itemBuilder: (context, index) {
          User user = _users[index];
          //print(user[inde])
          return new GestureDetector(
              child: new Card(
            color: RandomColorModel().getColor(),
            elevation: 0.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            )),
            child: GridTile(
             /*  child: ListTile(
                title: Text(
                  '',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Text(
                      user.requeststatus.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.count,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ), */
              
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

                  onTap: () {
                switch(user.requeststatus.toLowerCase()){
               case "approved":{
                 Navigator.push(context,
                        MaterialPageRoute(builder: (_) => adminDash()));
               }
                  break;
                case "approved":
                {
                 Navigator.push(context,
                        MaterialPageRoute(builder: (_) => adminDash()));
               }
                  break;
                  case "approved":
                  {
                 Navigator.push(context,
                        MaterialPageRoute(builder: (_) => adminDash()));
               }
                  break; 
                  case "approved":
                  {
                 Navigator.push(context,
                        MaterialPageRoute(builder: (_) => adminDash()));
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
                       
                        new Text(user.requeststatus.toUpperCase()),
                        new Icon(
                          Icons.analytics,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    content: new Text(user.count),
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
        }); */
    var gridView = new GridView.builder(
        // itemCount: 20,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2),
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
                child: GridTile(
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
                )),
            onTap: () {
              switch (user.requeststatus.toLowerCase()) {
                case "denied":
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DeniedDetails()));
                  }
                  break;
                case "approved":
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ApprovedDetails()));
                  }
                  break;
                case "revised":
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RevisedDetails()));
                  }
                  break;
                case "pending":
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PendingDetails()));
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
        });
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xFFECA585),
          centerTitle: true,
          title: Text(
            _loading ? 'Loading...' : 'DAAPP',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          bottom: tabBarItem,
        ),
        /* drawer: Drawer(
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
              /*  ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => JsonParseDemo()));
                },
                leading: Icon(Icons.analytics),
                title: Text('DashBoard'),
              ), */
              ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => adminDash()));
                },
                leading: Icon(Icons.pending_actions_outlined),
                title: Text('Menu'),
              ),
            ],
          ),
        ), */
        //backgroundColor: Color(0xFFEBA889),
        backgroundColor: FlutterFlowTheme.tertiaryColor,
        body:
            //backgroundColor: Color(0xFFEBA889),
            // padding: const EdgeInsets.all(10),
            new TabBarView(
          controller: tabController,
          children: [
            gridView,
            gridview,
          ],
        ),
      ),
    );
  }
}
