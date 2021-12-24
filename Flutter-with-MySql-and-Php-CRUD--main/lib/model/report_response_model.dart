import 'dart:convert';

List<ReportResponseModel> reportResponseModelFromJson(String str) => List<ReportResponseModel>.from(json.decode(str).map((x) => ReportResponseModel.fromJson(x)));

String reportResponseModelToJson(List<ReportResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportResponseModel {
  ReportResponseModel({
    this.id,
    this.name,
    this.salesexcutivename,
    this.branch,
    this.carmodel,
    this.yearmake,
    this.currentoffer,
    this.discountvalue,
    this.customerstatus,
    this.referredcustomer,
    this.referrername,
    this.requeststatus,
    this.requestdate,
    this.bookingId,
    this.revised,
    this.commants,
    this.statuschangetime,
  });

  String id;
  String name;
  String salesexcutivename;
  String branch;
  String carmodel;
  String yearmake;
  String currentoffer;
  String discountvalue;
  String customerstatus;
  String referredcustomer;
  String referrername;
  String requeststatus;
  String requestdate;
  dynamic bookingId;
  String revised;
  String commants;
  String statuschangetime;

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) => ReportResponseModel(
    id: json["id"],
    name: json["name"],
    salesexcutivename: json["salesexcutivename"],
    branch: json["branch"],
    carmodel: json["carmodel"],
    yearmake: json["yearmake"],
    currentoffer: json["currentoffer"],
    discountvalue: json["discountvalue"],
    customerstatus: json["customerstatus"],
    referredcustomer: json["referredcustomer"],
    referrername: json["referrername"],
    requeststatus: json["requeststatus"],
    requestdate: json["requestdate"],
    bookingId: json["booking_id"],
    revised: json["revised"],
    commants: json["commants"],
    statuschangetime: json["statuschangetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "salesexcutivename": salesexcutivename,
    "branch": branch,
    "carmodel": carmodel,
    "yearmake": yearmake,
    "currentoffer": currentoffer,
    "discountvalue": discountvalue,
    "customerstatus": customerstatus,
    "referredcustomer": referredcustomer,
    "referrername": referrername,
    "requeststatus": requeststatus,
    "requestdate": requestdate,
    "booking_id": bookingId,
    "revised": revised,
    "commants": commants,
    "statuschangetime": statuschangetime,
  };
}
