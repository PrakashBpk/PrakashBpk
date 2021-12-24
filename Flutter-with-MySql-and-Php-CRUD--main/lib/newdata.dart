import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/main.dart';
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

class NewData extends StatefulWidget {
  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  String branch, carmodel;
  List branchItemlist = List();
  List carItemlist = List();
  List<User> _users;
  bool _loading;
  //branch list api
  Future getBranch() async {
    //http://192.168.68.105/API_FOlder/
    var url = "http://14.141.213.116:861/branchlist.php";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        branchItemlist = jsonData;
      });
    }
    print(branchItemlist);
  }

  Future getCarmodel() async {
    //http://192.168.68.105/API_FOlder/
    var url = "http://14.141.213.116:861/carmodel.php";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        carItemlist = jsonData;
      });
    }
    print(carItemlist);
  }

  TextEditingController bookingId = new TextEditingController();
  TextEditingController cname = new TextEditingController();
  TextEditingController cmobile = new TextEditingController();
  //TextEditingController branch = new TextEditingController();
  //TextEditingController carmodel = new TextEditingController();
  TextEditingController yearmake = new TextEditingController();
  TextEditingController currentoffer = new TextEditingController();
  TextEditingController discountvalue = new TextEditingController();
  TextEditingController existingornew = new TextEditingController();
  TextEditingController referredcustomer = new TextEditingController();
  TextEditingController referrername = new TextEditingController();
  Future sendmail(String requeststatus) async {
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

  /* void addData() {
    var url = "http://192.168.225.93/API_Folder/adddata.php";
    http.post(url, body: {
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
  } */
  void clearText() {
    bookingId.clear();
    cname.clear();
    cmobile.clear();
    //branch.clear();
    yearmake.clear();
    currentoffer.clear();
    discountvalue.clear();
    existingornew.clear();
    referredcustomer.clear();
    referrername.clear();
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getBranch();
    getCarmodel();
    setState(() {
      _users = _users;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discount Request form"),
        backgroundColor: Color(0xFFEBA889),
      ),
      body: ListView(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: bookingId,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Booking ID',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: cname,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: cmobile,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Sales Executive Name',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: DropdownButton(
                //controller:requeststatus,
                isExpanded: true,
                hint: Text("Select the Branch"),
                value: branch,
                icon: Icon(Icons.keyboard_arrow_down),
                items: branchItemlist.map((branch) {
                  return DropdownMenuItem(
                      value: branch['branch'], child: Text(branch['branch']));
                }).toList(),
                onChanged: (Value) {
                  setState(() {
                    branch = Value;
                  });
                },
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: DropdownButton(
                //controller:requeststatus,
                isExpanded: true,
                hint: Text("Select the Car Model"),
                value: carmodel,
                icon: Icon(Icons.keyboard_arrow_down),
                items: carItemlist.map((carmodel) {
                  return DropdownMenuItem(
                      value: carmodel['carmodel'],
                      child: Text(carmodel['carmodel']));
                }).toList(),
                onChanged: (Value) {
                  setState(() {
                    carmodel = Value;
                  });
                },
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: yearmake,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Year Of making',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: currentoffer,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Current Offer',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: discountvalue,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Discount Value',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: existingornew,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Are you Existing Customer or New',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: referredcustomer,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Are you Referred Customer ',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                controller: referrername,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Referrer Name',
                  labelStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Roboto',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(150, 0, 0, 0),
              child: FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                  sendmail("pending");
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => NewData()),
                      )
                      .then((users) => setState(() {
                            _users = users;
                            _loading = false;
                          }));
                  // clearText();
                },
                text: 'Submit',
                options: FFButtonOptions(
                  width: 85,
                  height: 40,
                  color: Color(0xFFEBA889),
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              ),
            ),
            /* Padding(
              padding: EdgeInsetsDirectional.fromSTEB(85, 0, 0, 0),
              child: FFButtonWidget(
                onPressed: () {
                  /* print('Button pressed ...');
                  sendmail("pending"); */
                  clearText();
                },
                text: 'Clear',
                options: FFButtonOptions(
                  width: 85,
                  height: 40,
                  color: Color(0xFFEBA889),
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              ),
            ) */
          ],
        )

        /*    TextField(
          controller: bookingId,
          decoration: InputDecoration(
              hintText: "Enter the BookingID", labelText: "BookingID"),
        ),
        TextField(
          controller: cname,
          decoration: InputDecoration(
              hintText: "Enter Name", labelText: "Customer Name"),
        ),
        TextField(
          controller: cmobile,
          decoration: InputDecoration(
              hintText: "Field Sales excutive name",
              labelText: "Field Sales excutive name"),
        ),
        /*  TextField(
            controller: branch,
            decoration:
                InputDecoration(hintText: "Enter Branch", labelText: "Branch"),
          ), */
        DropdownButton(
          //controller:requeststatus,
          isExpanded: true,
          hint: Text("Select the Branch"),
          value: branch,
          icon: Icon(Icons.keyboard_arrow_down),
          items: branchItemlist.map((branch) {
            return DropdownMenuItem(
                value: branch['branch'], child: Text(branch['branch']));
          }).toList(),
          onChanged: (Value) {
            setState(() {
              branch = Value;
            });
          },
        ),
        DropdownButton(
          //controller:requeststatus,
          isExpanded: true,
          hint: Text("Select the Car Model"),
          value: carmodel,
          icon: Icon(Icons.keyboard_arrow_down),
          items: carItemlist.map((carmodel) {
            return DropdownMenuItem(
                value: carmodel['carmodel'], child: Text(carmodel['carmodel']));
          }).toList(),
          onChanged: (Value) {
            setState(() {
              carmodel = Value;
            });
          },
        ),
        /* TextField(
            controller: carmodel,
            decoration: InputDecoration(
                hintText: "Enter Car Model", labelText: "Car Model"),
          ), */
        TextField(
          controller: yearmake,
          decoration: InputDecoration(
              hintText: "Enter Year Make", labelText: "Year Make"),
        ),
        TextField(
          controller: currentoffer,
          decoration: InputDecoration(
              hintText: "Enter Current Offer", labelText: "Current Offer"),
        ),
        TextField(
          controller: discountvalue,
          decoration: InputDecoration(
              hintText: "Enter Discount Value", labelText: "Discount Value"),
        ),
        TextField(
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
        ),
        FFButtonWidget(
          onPressed: () {
            // addData();
            sendmail("pending");
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => adminDash()),
            );
          },
          text: 'Click to Submit ',
          options: FFButtonOptions(
            width: 20,
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
        ), */
        /*  MaterialButton(
            child: Text("Submit"),
            color: Colors.red,
            onPressed: () {
              // addData();
              sendmail("pending");
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => adminDash()),
              );
            },
          ), */
      ]),
    );
  }
}
