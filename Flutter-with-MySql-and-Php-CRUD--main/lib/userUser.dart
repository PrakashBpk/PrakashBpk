import 'dart:convert';

List<UUser> userFromJson(String str) =>
    List<UUser>.from(json.decode(str).map((x) => UUser.fromJson(x)));

String userToJson(List<UUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UUser {
  var approved;

  UUser({
    this.approved,
    this.requeststatus,
    this.count,
  });

  String requeststatus;
  String count;

  factory UUser.fromJson(Map<String, dynamic> json) => UUser(
        requeststatus: json["requeststatus"],
        count: json["COUNT(*)"],
      );

  Map<String, dynamic> toJson() => {
        "requeststatus": requeststatus,
        "COUNT(*)": count,
      };
}
