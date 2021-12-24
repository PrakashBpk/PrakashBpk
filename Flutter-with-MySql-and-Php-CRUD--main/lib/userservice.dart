import 'dart:async';

import 'package:flutter_mysql_crud/userUser.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_mysql_crud/Users.dart';

/* main() {
  const oneSec = Duration(seconds: 1);
  Timer.periodic(oneSec, (Timer t) => print('hi!'));
} */

class SServices {
  //
  static const String url = 'http://14.141.213.116:861/pendingcount.php';
  static Future<List<UUser>> getUsers() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<UUser> users = userFromJson(response.body);
        return users;
      } else {
        return List<UUser>();
      }
    } catch (e) {
      return List<UUser>();
    }
  }
}
