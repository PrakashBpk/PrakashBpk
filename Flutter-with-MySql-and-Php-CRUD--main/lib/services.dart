import 'package:http/http.dart' as http;
import 'package:flutter_mysql_crud/Users.dart';

class Services {
  //
  static const String url = 'http://14.141.213.116:861/pendingcount.php';
  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<User> users = userFromJson(response.body);
        return users;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }
}
