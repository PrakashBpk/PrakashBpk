// ignore_for_file: equal_keys_in_map, unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/JsonParseDemo.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/main.dart';
import 'package:flutter_mysql_crud/revised.dart';
import 'package:flutter_mysql_crud/reviseddetails.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:email_auth/email_auth.dart';

import 'Users.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_widgets.dart';

class Edit extends StatefulWidget {
  final List list;
  final int index;

  Edit({this.list, this.index});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  String dropdownvalue = 'Approved';
  List<User> _users;
  bool _loading;
  var items = [
    'Approved',
    'Denied',
  ];
  // String Approved;

//////get status update
  String requeststatus;
  // String denied = 'denied';
  List categoryItemlist = List();

  var child;
  Future getAllCategory() async {
    var url = "http://14.141.213.116:861/statuschange.php";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
    print(categoryItemlist);
  }

  String approve() {
    return "approved";
  }

  String denied() {
    return "denied";
  }

  String reviseed() {
    return "revised";
  }

  TextEditingController bookingId;
  TextEditingController cname;
  TextEditingController cmobile;
  TextEditingController branch;
  TextEditingController carmodel = new TextEditingController();
  TextEditingController yearmake = new TextEditingController();
  TextEditingController currentoffer = new TextEditingController();
  TextEditingController discountvalue = new TextEditingController();
  TextEditingController existingornew = new TextEditingController();
  TextEditingController referredcustomer = new TextEditingController();
  TextEditingController referrername = new TextEditingController();
  //TextEditingController requeststatus = new TextEditingController();

  //String Approvedbutton = 'Approved';

  //send mail
  /* Future sendmail() async {
    var url = Uri.parse("https://demo.codeworldindia.tech/form/form.php");
    var response = await http.post(url, body: {
      "name": cname.text,
      "salesexcutivename": cmobile.text,
      "branch": branch,
      "carmodel": carmodel.text,
      "yearmake": yearmake.text,
      "currentoffer": currentoffer.text,
      "discountvalue": discountvalue.text,
      "customerstatus": existingornew.text,
      "referredcustomer": referredcustomer.text,
      "referrername": referrername.text,
    });

    var data = jsonDecode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Request already exist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else {
      await FlutterSession().set('token', cname.text);
      Fluttertoast.showToast(
          msg: "Request Saved Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);

      String username = 'geekdinoabt@gmail.com';
      String password = 'ityqalqiqhuzbola';
      String domainSmtp = 'smtp.gmail.com';

      //also use for gmail smtp
      //final smtpServer = gmail(username, password);

      //user for your own domain
      final smtpServer = SmtpServer(domainSmtp,
          username: username, password: password, port: 587);

      final message = Message()
        ..from = Address(username, 'New Request from ${cmobile.text}')
        ..recipients.add('geekdinoabt@gmail.com')
        ..subject = 'New Request Submitted'
        ..text = ''
        ..html =
            "<p>Name: ${cname.text}</p>\n <p>Field Sales Executive name: ${cmobile.text}</p> \n <p>Branch: ${branch}</p> \n <p>Car Model: ${carmodel.text}</p> \n <p>year make: ${yearmake.text}</p> \n \n <p>Current Offer: ${currentoffer.text}</p> \n <p>Discount Value: ${discountvalue.text}</p> \n <p>Are you Existing Customer?: ${existingornew.text}</p> \n <p>Are you Referred Customer?: ${referredcustomer.text}</p> \n <p>Referrer Name: ${referrername.text}</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }
  } */

  Future editData(String requeststatus, statuschangetime) async {
    var url = "http://14.141.213.116:861/editdata.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      "booking_id": bookingId.text,
      "name": cname.text,
      "salesexcutivename": cmobile.text,
      "branch": branch.text,
      "carmodel": carmodel.text,
      "yearmake": yearmake.text,
      "currentoffer": currentoffer.text,
      "discountvalue": discountvalue.text,
      "customerstatus": existingornew.text,
      "referredcustomer": referredcustomer.text,
      "referrername": referrername.text,
      "requeststatus": requeststatus,
      "statuschangetime": statuschangetime //categoryItemlist
      //"requeststatus": denied(),
      // "requeststatus": reviseed()
    });
    var data;
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Request already exist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else {
      await FlutterSession().set('token', cname.text);
      Fluttertoast.showToast(
          msg: "Status updated Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);

      String username = 'geekdinoabt@gmail.com';
      String password = 'ityqalqiqhuzbola';
      String domainSmtp = 'smtp.gmail.com';

      //also use for gmail smtp
      //final smtpServer = gmail(username, password);

      //user for your own domain
      final smtpServer = SmtpServer(domainSmtp,
          username: username, password: password, port: 587);

      final message = Message()
        ..from = Address(username, 'Status Changed ${cmobile.text}')
        ..recipients.add('geekdinoabt@gmail.com')
        ..subject = 'New Request Submitted'
        ..text = ''
        ..html =
            "<p>Booking_Id: ${bookingId.text}</p>\n<p>Name: ${cname.text}</p>\n <p>Field Sales Executive name: ${cmobile.text}</p> \n <p>Branch: ${branch}</p> \n <p>Car Model: ${carmodel}</p> \n <p>year make: ${yearmake.text}</p> \n \n <p>Current Offer: ${currentoffer.text}</p> \n <p>Discount Value: ${discountvalue.text}</p> \n <p>Are you Existing Customer?: ${existingornew.text}</p> \n <p>Are you Referred Customer?: ${referredcustomer.text}</p> \n <p>Referrer Name: ${referrername.text}</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }
  }

  /* Future sendmail() async {
    var url = Uri.parse("http://14.141.213.116:861/adddata.php");
    var response = await http.post(url, body: {
      "name": cname.text,
      "salesexcutivename": cmobile.text,
      "branch": branch,
      "carmodel": carmodel,
      "yearmake": yearmake.text,
      "currentoffer": currentoffer.text,
      "discountvalue": discountvalue.text,
      "customerstatus": existingornew.text,
      "referredcustomer": referredcustomer.text,
      "referrername": referrername.text,
      "requeststatus": requeststatus,
      "booking_id": bookingId.text
    });

    var data;
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Request already exist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else {
      await FlutterSession().set('token', cname.text);
      Fluttertoast.showToast(
          msg: "Request Saved Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);

      String username = 'geekdinoabt@gmail.com';
      String password = 'ityqalqiqhuzbola';
      String domainSmtp = 'smtp.gmail.com';

      //also use for gmail smtp
      //final smtpServer = gmail(username, password);

      //user for your own domain
      final smtpServer = SmtpServer(domainSmtp,
          username: username, password: password, port: 587);

      final message = Message()
        ..from = Address(username, 'New Request from ${cmobile.text}')
        ..recipients.add('praveen.mca043@gmail.com')
        ..subject = 'New Request Submitted'
        ..text = ''
        ..html =
            "<p>Booking_Id: ${bookingId.text}</p>\n<p>Name: ${cname.text}</p>\n <p>Field Sales Executive name: ${cmobile.text}</p> \n <p>Branch: ${branch}</p> \n <p>Car Model: ${carmodel}</p> \n <p>year make: ${yearmake.text}</p> \n \n <p>Current Offer: ${currentoffer.text}</p> \n <p>Discount Value: ${discountvalue.text}</p> \n <p>Are you Existing Customer?: ${existingornew.text}</p> \n <p>Are you Referred Customer?: ${referredcustomer.text}</p> \n <p>Referrer Name: ${referrername.text}</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }
  } */

  @override
  void initState() {
    bookingId =
        TextEditingController(text: widget.list[widget.index]['booking_id']);
    cname = TextEditingController(text: widget.list[widget.index]['name']);
    cmobile = TextEditingController(
        text: widget.list[widget.index]['salesexcutivename']);
    branch = TextEditingController(text: widget.list[widget.index]['branch']);
    carmodel =
        TextEditingController(text: widget.list[widget.index]['carmodel']);
    yearmake =
        TextEditingController(text: widget.list[widget.index]['yearmake']);
    currentoffer =
        TextEditingController(text: widget.list[widget.index]['currentoffer']);
    discountvalue =
        TextEditingController(text: widget.list[widget.index]['discountvalue']);
    existingornew = TextEditingController(
        text: widget.list[widget.index]['customerstatus']);
    referredcustomer = TextEditingController(
        text: widget.list[widget.index]['referredcustomer']);
    referrername =
        TextEditingController(text: widget.list[widget.index]['referrername']);

    ///requeststatus =
    /// TextEditingController(text: widget.list[widget.index]['requeststatus']);
    super.initState();
    getAllCategory();
    approve();
    denied();
    setState(() {});
    //sendmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBA889),
        title: Text("Information About ${widget.list[widget.index]['name']}"),
      ),
      body: ListView(
        children: [
          //Text('salesexcutivename'),
          // Text(cname),
          TextField(
            controller: bookingId,
            enableInteractiveSelection: false,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Booking ID", labelText: "Booking ID"),
          ),
          TextField(
            controller: cname,
            enableInteractiveSelection: false,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Customer Name", labelText: "Customer Name"),
          ),
          TextField(
            controller: cmobile,
            enableInteractiveSelection: false,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Field Sales excutive name",
                labelText: "Field Sales excutive name"),
          ),
          TextField(
            controller: branch,
            enableInteractiveSelection: false,
            readOnly: true,
            enabled: false,
            decoration:
                InputDecoration(hintText: "Enter Branch", labelText: "Branch"),
          ),
          TextField(
            controller: carmodel,
            enableInteractiveSelection: false,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Car Model", labelText: "Car Model"),
          ),
          TextField(
            controller: yearmake,
            enableInteractiveSelection: false,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Year Make", labelText: "Year Make"),
          ),
          TextField(
            controller: currentoffer,
            enableInteractiveSelection: false,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Current Offer", labelText: "Current Offer"),
            readOnly: true,
          ),
          TextField(
            controller: discountvalue,
            enableInteractiveSelection: false,
            enabled: false,
            readOnly: true,
            decoration: InputDecoration(
                hintText: "Enter Discount Value", labelText: "Discount Value"),
          ),
          /*   TextField(
            controller: existingornew,
            decoration: InputDecoration(
                hintText: "Enter Existing or new",
                labelText: "Are You Existing Customer or new ?"),
          ),
          TextField(
            controller: referredcustomer,
            decoration: InputDecoration(
                hintText: "Enter Yes or No",
                labelText: "Are You Referred Customer?"),
          ),
          TextField(
            controller: referrername,
            decoration: InputDecoration(
                hintText: "Enter Referrer Name", labelText: "Referrer Name"),
          ), */
          /*     DropdownButton(
            //controller:requeststatus,
            isExpanded: true,
            hint: Text("Select the Status"),
            value: requeststatus,
            icon: Icon(Icons.keyboard_arrow_down),
            items: categoryItemlist.map((Category) {
              return DropdownMenuItem(
                  value: Category['requeststatus'],
                  child: Text(Category['requeststatus']));
            }).toList(),
            onChanged: (Value) {
              setState(() {
                requeststatus = Value;
              });
            },
          ), */
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    DateTime dateToday = new DateTime.now();
                    String statuschangetime =
                        dateToday.toString().substring(0, 10);
                    editData("approved", statuschangetime);

                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  JsonParseDemo()),
                        )
                        .then((users) => setState(() {
                              _users = users;
                              _loading = false;
                            }));
                  },

                  text: 'Approved',
                  //  icon: Icon(Icons.thumb_up_alt),
                  options: FFButtonOptions(
                    width: 85,
                    height: 40,
                    color: Color(0xFF7FD48A),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    DateTime dateToday = new DateTime.now();
                    String statuschangetime =
                        dateToday.toString().substring(0, 10);
                    editData("denied", statuschangetime);
                    // denied();
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  JsonParseDemo()),
                        )
                        .then((users) => setState(() {
                              _users = users;
                              _loading = true;
                            }));

                    print('Button pressed ...');
                  },
                  text: 'Denied',
                  options: FFButtonOptions(
                    width: 85,
                    height: 40,
                    color: Color(0xFFE98282),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    /*     print('Button pressed ...');
                    DateTime dateToday = new DateTime.now();
                    String statuschangetime =
                        dateToday.toString().substring(0, 10);
                    editData("revised", statuschangetime); */
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => Revised()),
                        )
                        .then((users) => setState(() {
                              _users = users;
                              _loading = false;
                            }));
                  },
                  text: 'Revised',
                  options: FFButtonOptions(
                    width: 85,
                    height: 40,
                    color: Color(0xFFEAA74A),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                    DateTime dateToday = new DateTime.now();
                    String statuschangetime =
                        dateToday.toString().substring(0, 10);
                    editData("forward", statuschangetime);
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  JsonParseDemo()),
                        )
                        .then((users) => setState(() {
                              _users = users;
                              _loading = true;
                            }));
                    // sendmail();
                  },
                  text: 'Forward',
                  options: FFButtonOptions(
                    width: 85,
                    height: 40,
                    color: Color(0xFFE98282),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
            ],
          ),
          /*   MaterialButton(
            child: Text("Approved"),
            onPressed: () {
              //approve();
              DateTime dateToday = new DateTime.now();
              String statuschangetime = dateToday.toString().substring(0, 10);
              editData("approved", statuschangetime);

              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => JsonParseDemo()),
              );
            },
          ), */
          /*  MaterialButton(
            child: Text("Denied"),
            onPressed: () {
              DateTime dateToday = new DateTime.now();
              String statuschangetime = dateToday.toString().substring(0, 10);
              editData("denied", statuschangetime);
              // denied();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => JsonParseDemo()),
              );
            },
          ), */
          /*   MaterialButton(
            child: Text("Revised"),
            onPressed: () {
              DateTime dateToday = new DateTime.now();
              String statuschangetime = dateToday.toString().substring(0, 10);
              editData("revised", statuschangetime);
              //reviseed();
              //denied();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => JsonParseDemo()),
              );
            },
          ), */
          /* MaterialButton(
            child: Text("Delete"),
            onPressed: () {
              DateTime dateToday = new DateTime.now();
              String statuschangetime = dateToday.toString().substring(0, 10);
              editData("delete", statuschangetime);
              //reviseed();
              //denied();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => JsonParseDemo()),
              );
            },
          ),
          MaterialButton(
            child: Text("Forward"),
            onPressed: () {
              DateTime dateToday = new DateTime.now();
              String statuschangetime = dateToday.toString().substring(0, 10);
              editData("forward", statuschangetime);
              //reviseed();
              //denied();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => JsonParseDemo()),
              );
            },
          ), */
          /*  MaterialButton(
            child: Text("Denied"),
            onPressed: () {
              editData();
        ///      sendmail();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => adminDash()),
              );
            },
          ), */
          /*  MaterialButton(
            child: Text("Denied"),
            onPressed: () {
              editData();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => adminDash()),
              );
            },
          ), */
        ],
      ),
    );
  }
}
