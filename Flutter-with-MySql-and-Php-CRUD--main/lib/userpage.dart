//import '../approved_user/approved_user_widget.dart';
//import '../deleted_user/deleted_user_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
//import '../pending_user/pending_user_widget.dart';
//import '../revised_user/revised_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class UserWidget extends StatefulWidget {
  const UserWidget({Key key}) : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  /*  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;
  TextEditingController textController5;
  TextEditingController textController6;
  TextEditingController textController7;
  TextEditingController textController8;
  TextEditingController textController9;
  

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    textController5 = TextEditingController();
    textController6 = TextEditingController();
    textController7 = TextEditingController();
    textController8 = TextEditingController();
    textController9 = TextEditingController();
  } */
  String branch, carmodel;
  List branchItemlist = List();
  List carItemlist = List();

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
    super.initState();
    getBranch();
    getCarmodel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF09A74),
        automaticallyImplyLeading: true,
        title: Text(
          'DAAPP',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Roboto',
            color: FlutterFlowTheme.tertiaryColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFEBA889),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: FlutterFlowTheme.title2.override(
                        fontFamily: 'Roboto',
                      ),
                      indicatorColor: Colors.white,
                      tabs: [
                        Tab(
                          text: 'Request Form',
                        ),
                        Tab(
                          text: 'Dashboard',
                        )
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: bookingId,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Booking ID',
                                            labelStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Roboto',
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
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
                                            labelStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Roboto',
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
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
                                            labelStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Roboto',
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
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
                                                value: branch['branch'],
                                                child: Text(branch['branch']));
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
                                                child:
                                                    Text(carmodel['carmodel']));
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
                                          controller: currentoffer,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Current Offer',
                                            labelStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Roboto',
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
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
                                            labelStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Roboto',
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
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
                                            labelText:
                                                'Are you Existing Customer or New',
                                            labelStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Roboto',
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
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
                                            labelText:
                                                'Are you Referred Customer ',
                                            labelStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Roboto',
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
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
                                            labelStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Roboto',
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            130, 0, 0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                            sendmail("pending");
                                            clearText();
                                          },
                                          text: 'Submit',
                                          options: FFButtonOptions(
                                            width: 130,
                                            height: 40,
                                            color: Color(0xFFEBA889),
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
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
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            ),
                            child: GridView(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 15, 0, 0),
                                  child: InkWell(
                                    /*   onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PendingUserWidget(),
                                        ),
                                      );
                                    }, */
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0xE8E9A6DE),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 30, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.pending_actions,
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                  size: 50,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Pending',
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '3',
                                                  style: FlutterFlowTheme
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 5, 0),
                                  child: InkWell(
                                    /*  onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ApprovedUserWidget(),
                                        ),
                                      );
                                    }, */
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0xE8C5E4CE),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.approval,
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                                size: 50,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Approved',
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '2',
                                                  style: FlutterFlowTheme
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 0, 0),
                                  child: InkWell(
                                    /*   onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DeletedUserWidget(),
                                        ),
                                      );
                                    }, */
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0xE8EEB7A9),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                                size: 50,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Denied',
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '1',
                                                  style: FlutterFlowTheme
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 5, 0),
                                  child: InkWell(
                                    /*   onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RevisedUserWidget(),
                                        ),
                                      );
                                    }, */
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0xFFDDC198),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.update,
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                                size: 50,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 0, 0),
                                                child: Text(
                                                  'Revised',
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 0, 0),
                                                child: Text(
                                                  '2',
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 0, 0),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xE8B8C8E4),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.forward,
                                              color: FlutterFlowTheme
                                                  .tertiaryColor,
                                              size: 50,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Forward',
                                                style: FlutterFlowTheme.title3
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '5',
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 0),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0x69D197E1),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.analytics_outlined,
                                              color: FlutterFlowTheme
                                                  .tertiaryColor,
                                              size: 50,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5, 0, 0),
                                              child: Text(
                                                'Reports',
                                                style: FlutterFlowTheme.title3
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
