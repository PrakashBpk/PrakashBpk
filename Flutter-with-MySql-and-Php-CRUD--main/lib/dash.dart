/* import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:clickmeetplay/iam/user/postbean.dart';
import 'package:http/http.dart' as http;

class PostHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PostScreen(),
      ),
    );
  }
}

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List _postList = new List();

  get Post => null;

  Future<List> fetchPost() async {
    final response =
        await http.get('http://192.168.1.234/requeststatuscount.php');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      /* if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _postList.add(Post.fromJson(map));
            debugPrint('Id-------${map['id']}');
          }
        }
      } */
      return _postList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    fetchPost();
  }
}
 */
/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    home: new HomPage(),
  ));
}

class HomPage extends StatefulWidget {
  @override
  _HomPageState createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  String url = "http://192.168.68.153/API_FOlder/pendingcount.php";
  List data;

  /*onCreate*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getJSONData(); //method
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("my JSON app")),
      body: new ListView.builder(
        // itemCount: 1,
        //itemCount: data==null ? 0 :data.length ,
        itemCount: data == null ? 0 : data.length,

        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child:
                          new Text(data[0]['requeststatus'].toString() ?? ''),
                      padding: EdgeInsets.all(20),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /*method*/ //RT is Future<String>
  Future<String> getJSONData() async {
    var response = await http.get(
      Uri.encodeFull(url), /* headers: {"Accept": "application/json"} */
    );
    print(response.body);
    debugPrint(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });

    return "Success";
  }
}
 */
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('http://14.141.213.116:861/pendingcount.php'));

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

class required {}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              const Text("Approved");
              if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data.approved,
                    style: TextStyle(fontSize: 100),
                  ),
                  // new: Text(data)
                );

                //new Text(snapshot.data.approved);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
} 

/*import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://192.168.68.153/API_FOlder/pendingcount.php'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  //final int albumId;
  //final int id;
  //final String title;
  //final String url;
  final String COUNT;

  const Photo({
    // this.albumId,
    // this.id,
    // this.title,
    //this.url,
    this.COUNT,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      //  albumId: json['albumId'] as int,
      //id: json['id'] as int,
      //title: json['title'] as String,
      //url: json['url'] as String,
      COUNT: json['COUNT'] as String,
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({Key key, this.photos}) : super(key: key);

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return ListTile(
          //      leading:
          // title: Text(list[i]['name']),
          title: Text(photos[index].COUNT),
          // subtitle: Text(list[i]['salesexcutivename']),

          //subtitle: Text(list[i]['salesexcutivename']),
          /*  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Approvedviewdetails(list: list, index: i),
                    ),
                  ) */
        );
      },
    );
  }
}*/
