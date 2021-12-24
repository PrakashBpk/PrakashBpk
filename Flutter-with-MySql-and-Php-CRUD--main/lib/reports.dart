import 'dart:convert';
import 'dart:developer';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mysql_crud/flutter_flow/flutter_flow_drop_down.dart';
import 'package:flutter_mysql_crud/model/report_response_model.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:http/http.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ReportsWidget extends StatefulWidget {
  const ReportsWidget({Key key}) : super(key: key);

  @override
  _ReportsWidgetState createState() => _ReportsWidgetState();
}

class _ReportsWidgetState extends State<ReportsWidget> {
  DateTime datePicked1;
  DateTime datePicked2;
  String dropDownValue1;
  String dropDownValue2;
  String dropDownValue3;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFE9986E),
        automaticallyImplyLeading: true,
        title: Text(
          'Reports',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Roboto',
            color: FlutterFlowTheme.tertiaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFEFE9E8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                          child: Text(
                            'Request Raised',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Container(
                            width: 40,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              border: Border.all(
                                color: Color(0xF50E0E0E),
                              ),
                            ),
                            child: AutoSizeText(
                              '2',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'Value',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                          child: Container(
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              border: Border.all(
                                color: Color(0xF50E0E0E),
                              ),
                            ),
                            child: AutoSizeText(
                              '5000',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'Unique Cars',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                          child: Container(
                            width: 40,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              border: Border.all(
                                color: Color(0xF50E0E0E),
                              ),
                            ),
                            child: AutoSizeText(
                              '2',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Color(0xFFEEDED6),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Date From ',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Roboto',
                          ),
                        ),
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 50,
                          icon: Icon(
                            Icons.date_range_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () async {
                            await DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (date) {
                                setState(() => datePicked1 = date);
                              },
                              currentTime: getCurrentTimestamp,
                            );
                          },
                        ),
                        Text(
                          'To',
                          style: FlutterFlowTheme.bodyText1,
                        ),
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 50,
                          icon: Icon(
                            Icons.date_range_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () async {
                            await DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (date) {
                                setState(() => datePicked2 = date);
                              },
                              currentTime: getCurrentTimestamp,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'Status',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                          child: FlutterFlowDropDown(
                            options: [
                              'Pending',
                              'Approved',
                              'Forwarded',
                              'Revised',
                              'Denied'
                            ].toList(),
                            onChanged: (val) =>
                                setState(() => dropDownValue1 = val),
                            width: 100,
                            height: 25,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            fillColor: Colors.white,
                            elevation: 2,
                            borderColor: Color(0xF50E0E0E),
                            borderWidth: 0,
                            borderRadius: 0,
                            margin:
                                EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            hidesUnderline: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            'Car Model',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: FlutterFlowDropDown(
                            options: [
                              'Maruti Swift ZXI AMT',
                              'Maruti Swift VXI',
                              'Maruti Wagon R LXI CNG 1.0L',
                              'Maruti Wagon R LXI AGS 1.2L',
                              'Maruti New Baleno BS-VI Alpha Automatic Petrol',
                              'Maruti New Baleno BS-VI Alpha Petrol',
                              'Maruti Alto 800 CNG LXI'
                            ].toList(),
                            onChanged: (val) =>
                                setState(() => dropDownValue2 = val),
                            width: 90,
                            height: 25,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            elevation: 2,
                            borderColor: Color(0xF50E0E0E),
                            borderWidth: 0,
                            borderRadius: 0,
                            margin:
                                EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            hidesUnderline: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'User',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: FlutterFlowDropDown(
                            options: ['All User'].toList(),
                            onChanged: (val) =>
                                setState(() => dropDownValue3 = val),
                            width: 100,
                            height: 25,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            elevation: 2,
                            borderColor: Color(0xFF080707),
                            borderWidth: 0,
                            borderRadius: 0,
                            margin:
                                EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            hidesUnderline: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Submit',
                        options: FFButtonOptions(
                          width: 80,
                          height: 30,
                          color: Color(0xFFE9A786),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Export to PDF',
                        options: FFButtonOptions(
                          width: 120,
                          height: 30,
                          color: Color(0xFFE9A786),
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
                  ],
                ),
              ),
              // Align(
              //   alignment: AlignmentDirectional(-1, 1),
              //   child: Padding(
              //     padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
              //     child: Container(
              //       width: 400,
              //       height: 530,
              //       decoration: BoxDecoration(
              //         color: Color(0xFFEEEEEE),
              //         shape: BoxShape.rectangle,
              //       ),
              //       child: Padding(
              //         padding: EdgeInsetsDirectional.fromSTEB(2, 15, 0, 0),
              //         child: GridView(
              //           padding: EdgeInsets.zero,
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 6,
              //             crossAxisSpacing: 5,
              //             mainAxisSpacing: 10,
              //             childAspectRatio: 1,
              //           ),
              //           shrinkWrap: true,
              //           scrollDirection: Axis.vertical,
              //           children: [
              //             Text(
              //               'Booking ID',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //                 fontWeight: FontWeight.w900,
              //               ),
              //             ),
              //             AutoSizeText(
              //               'Customer Name',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.w900,
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
              //               child: Text(
              //                 'Status',
              //                 textAlign: TextAlign.center,
              //                 style: FlutterFlowTheme.bodyText1.override(
              //                   fontFamily: 'Roboto',
              //                   fontWeight: FontWeight.w900,
              //                 ),
              //               ),
              //             ),
              //             Text(
              //               'Car Model',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //                 fontWeight: FontWeight.w900,
              //               ),
              //             ),
              //             Text(
              //               'Year Make',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //                 fontWeight: FontWeight.w900,
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
              //               child: Text(
              //                 'Value of Discount',
              //                 textAlign: TextAlign.center,
              //                 style: FlutterFlowTheme.bodyText1.override(
              //                   fontFamily: 'Roboto',
              //                   fontSize: 13,
              //                   fontWeight: FontWeight.w900,
              //                 ),
              //               ),
              //             ),
              //             Text(
              //               '001',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               'Yazhini',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               'Pending',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               'Swift',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               '2012',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               '2000',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
              //               child: Text(
              //                 '002',
              //                 textAlign: TextAlign.center,
              //                 style: FlutterFlowTheme.bodyText1.override(
              //                   fontFamily: 'Roboto',
              //                 ),
              //               ),
              //             ),
              //             Text(
              //               'Praveen',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               'Pending',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               'Swift',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               '2008',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //             Text(
              //               '3000',
              //               textAlign: TextAlign.center,
              //               style: FlutterFlowTheme.bodyText1.override(
              //                 fontFamily: 'Roboto',
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tableTitleWidget(title: "Booking ID"),
                  _tableTitleWidget(title: "Customer Name"),
                  _tableTitleWidget(title: "Status"),
                  _tableTitleWidget(title: "Car Model"),
                  _tableTitleWidget(title: "Year Make"),
                  _tableTitleWidget(title: "Value of Discount"),
                ],
              ),
              SizedBox(height: 10),
              FutureBuilder<List<ReportResponseModel>>(
                  future: getResponseData(),
                  builder: (context,
                      AsyncSnapshot<List<ReportResponseModel>> snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.connectionState != ConnectionState.done) {
                      return Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ReportResponseModel resportResponse =
                            snapshot.data[index];
                        return Row(
                          children: [
                            _tableBodyWidget(
                                title: resportResponse.bookingId ?? ""),
                            _tableBodyWidget(title: resportResponse.name ?? ""),
                            _tableBodyWidget(
                                title: resportResponse.requeststatus ?? ""),
                            _tableBodyWidget(
                                title: resportResponse.carmodel ?? ""),
                            _tableBodyWidget(
                                title: resportResponse.yearmake ?? ""),
                            _tableBodyWidget(
                                title: resportResponse.discountvalue ?? ""),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableTitleWidget({String title}) {
    return Expanded(
      child: Center(
        child: Text(
          title ?? "",
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _tableBodyWidget({String title}) {
    return Expanded(
      child: Container(
        height: 50,
        child: Text(
          title ?? "",
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text("user.userInfo[index].name"),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Icon(false ? Icons.notifications_off : Icons.notifications_active,
                  color: true ? Colors.red : Colors.green),
              Text(true ? 'Disabled' : 'Active')
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text("user.userInfo[index].phone"),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text("user.userInfo[index].registerDate"),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text("user.userInfo[index].terminationDate"),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Future<List<ReportResponseModel>> getResponseData() async {
    try {
      Response response =
          await http.post(Uri.parse("http://14.141.213.116:861/getdata.php"));
      var res = jsonDecode(response.body);
      print("res ==>  $res");
      return reportResponseModelFromJson(response.body);
    } catch (e) {
      log("message ==>  $e");
      return [];
    }
    return [];
  }
}
