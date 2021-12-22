import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  var approved;

  User({
    this.approved,
    this.requeststatus,
    this.count,
  });

  String requeststatus;
  String count;

  factory User.fromJson(Map<String, dynamic> json) => User(
        requeststatus: json["requeststatus"],
        count: json["COUNT(*)"],
      );

  Map<String, dynamic> toJson() => {
        "requeststatus": requeststatus,
        "COUNT(*)": count,
      };
}
