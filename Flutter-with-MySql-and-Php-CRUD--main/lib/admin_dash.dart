import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/JsonParseDemo.dart';
import 'package:flutter_mysql_crud/approveddetails.dart';
import 'package:flutter_mysql_crud/dash.dart';
import 'package:flutter_mysql_crud/denieddetails.dart';
import 'package:flutter_mysql_crud/editdata.dart';
import 'package:flutter_mysql_crud/main.dart';
import 'package:flutter_mysql_crud/revised.dart';
import 'package:flutter_mysql_crud/reviseddetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Constants.dart';
import 'package:flutter/foundation.dart';
import 'pendingdetails.dart';

/* Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://192.168.68.153/API_FOlder/pendingcount.php'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  //final int userId;
  //final int id;
  final String approved;

  Album({
    // this.userId,
    //this.id,
    this.approved,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      // userId: json['userId'],
      // id: json['id'],
      approved: json['approved'],
    );
  }
}
 */
class adminDash extends StatefulWidget {
  // const DashBoard{ Key? key }) : super(key: key);
  @override
  final title = 'Grid List';
  State<adminDash> createState() => _adminDashState();
}

class _adminDashState extends State<adminDash> {
  //List _postList =new List();
  bool isLoaded = false;
  int cont = 0;
  List acount = [];
  List a = [];
  String b;
  // Future<Album> futureAlbum;
  //final List<int>newcount = count.map((e)=>int.parse(e)).toList();
  // var count = nullableList;
  // var COUNT(*)='';
  fetchPost() async {
    final responce =
        await http.get("http://14.141.213.116:861/pendingcount.php");
    print("Test Print");
    // String rec = responce.body;
    // print(rec);
    //print(rec[0]);
    //List<dynamic> acount = jsonDecode(rec);

    acount.add(jsonDecode(responce.body));
    print(acount);
    print(acount[0]);
    b = acount[0].toString();

    print(b);

    //print(acount[0]['approved']);
    //String result = acount.map((val) => val.trim()).join(',');
    //  print(result);
    //print(jsonDecode(responce.body));
    // print(acount);
    //print(acount.length);
    //print(acount)
    // print(acount[0]);
    // print(acount[1]['COUNT(requeststatus)']);
    // print('b');
    // b = acount[0]['COUNT(*)'];
    //print(b);

    //print(count[0]['COUNT(*)']);['COUNT(requeststatus)']
    //print(acount[0]['COUNT(*)']);
    //print(acount[0]['COUNT(*)']);
    // print(acount[0]['COUNT(*)']);
    //Map jsonData = json.decode(responce.body) as Map;
    //a = acount[0]['approved'];
    print("outside");
    // print(a);
    // print(a[0]['approved']);
    // print(a[1]['COUNT(*)']);
    // print(a[2]['COUNT(*)']);

    return jsonDecode(responce.body);
  }

  /*  Future getAllCategory() async {
    var url = "http://192.168.43.232/api_folder/pendingcount.php";
    var response = await http.get(url);
         
    print(getAllCategory());
    return getAllCategory();
  }
*/
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    fetchPost();
    // futureAlbum = fetchAlbum();
    print("initstate print");
  }

  get child => null;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    //  IconData? icon;
    return Scaffold(
      appBar: AppBar(
        title: Text("DAAPP"),
        elevation: .1,
        backgroundColor: Color.fromRGBO(140, 158, 255, 1.0),
        actions: <Widget>[
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
        ],
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
                    MaterialPageRoute(builder: (_) => JsonParseDemo()));
              },
              leading: Icon(Icons.analytics),
              title: Text('DashBoard'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => adminDash()));
              },
              leading: Icon(Icons.pending_actions_outlined),
              title: Text('Menus'),
            ),
          ],
        ),
      ),
      body:

          /* FutureBuilder<List>(
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
      ),  */

          Container(
        decoration: new BoxDecoration(color: Colors.transparent),
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            /* RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PendingDetails()));
              },
              color: Colors.grey,
              textColor: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Center(
                      child: Icon(Icons.people_outline,
                          size: 50.0, color: Colors.black),
                    ),
                    Center(
                        child: Text("Request",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.black))),
                  ]),
            ), */
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ApprovedDetails()));
              },
              color: Colors.grey,
              textColor: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Center(
                      child: Icon(Icons.approval_sharp,
                          size: 50.0, color: Colors.black),
                    ),
                    Center(
                        child: Text("Approved",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.black))),
                    /*    Center(
                        child: Text(acount[0]['approved'],
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.black))), */
                  ]),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PendingDetails()));
              },
              color: Colors.grey,
              textColor: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Center(
                      child: Icon(Icons.pending_actions_outlined,
                          size: 50.0, color: Colors.black),
                    ),
                    Center(
                        child: Text("Pending",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.black))),
                    // ignore: null_aware_before_operator
                    /*  Center(
                        child: Text((a[3]['COUNT(*)']),
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.black))), */
                  ]),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DeniedDetails()));
              },
              color: Colors.grey,
              textColor: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Center(
                      child: Icon(Icons.cancel_presentation_rounded,
                          size: 50.0, color: Colors.black),
                    ),
                    Center(
                        child: Text("Denied",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.black))),
                    /*  Center(
                        child: Text((a[2]['COUNT(*)']),
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.black))), */
                  ]),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RevisedDetails()));
              },
              color: Colors.grey,
              textColor: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Center(
                      child: Icon(Icons.call_received,
                          size: 50.0, color: Colors.black),
                    ),
                    Center(
                        child: Text("Reviesd",
                            style: new TextStyle(
                                fontSize: 18.0, color: Colors.black))),
                    /*     Center(
                        child: Text((a[4]['COUNT(*)']),
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.black))), */
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.Profile) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => JsonParseDemo()));
    } else if (choice == Constants.Logout) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => adminDash()));
    }
  }
}
