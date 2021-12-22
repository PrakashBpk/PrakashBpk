import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/JsonParseDemo.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'Users.dart';

class Revised extends StatefulWidget {
  final List list;
  final int index;

  Revised({this.list, this.index});

  @override
  _RevisedState createState() => _RevisedState();
}

class _RevisedState extends State<Revised> {
  List<User> _users;
  bool _loading;
  String dropdownvalue = 'Revised';
  var items = [
    'Revised',
  ];

  String revisedd() {
    return 'approved';
  }

  //String reviseddate = DateTime.now();
  DateTime date;
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
  TextEditingController requeststatus = new TextEditingController();
  TextEditingController revised = new TextEditingController();
  TextEditingController commants = new TextEditingController();
  //String Approvedbutton = 'Approved';
  void editData(String requeststatus, statuschangetime) {
    //reviseddate=DateTime.now();
    var url = "http://14.141.213.116:861/revised.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
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
      "revised": revised.text,
      "commants": commants.text,
      "statuschangetime": statuschangetime
      // "approveddate": date
    });
  }

  @override
  void initState() {
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
    requeststatus =
        TextEditingController(text: widget.list[widget.index]['requeststatus']);
    revised =
        TextEditingController(text: widget.list[widget.index]['revisedvalue']);
    commants =
        TextEditingController(text: widget.list[widget.index]['commants']);
    super.initState();
    revisedd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBA889),
        title: Text("Revised Request ${widget.list[widget.index]['name']}"),
      ),
      body: ListView(
        children: [
          //Text('salesexcutivename'),
          TextField(
            controller: cname,
            readOnly: true,
            decoration: InputDecoration(
                hintText: "Customer Name", labelText: "Customer Name"),
          ),
          TextField(
            controller: cmobile,
            readOnly: true,
            decoration: InputDecoration(
                hintText: "Field Sales excutive name",
                labelText: "Field Sales excutive name"),
          ),
          TextField(
            controller: branch,
            readOnly: true,
            decoration:
                InputDecoration(hintText: "Enter Branch", labelText: "Branch"),
          ),
          TextField(
            controller: carmodel,
            readOnly: true,
            decoration: InputDecoration(
                hintText: "Enter Car Model", labelText: "Car Model"),
          ),
          TextField(
            controller: yearmake,
            decoration: InputDecoration(
                hintText: "Enter Year Make", labelText: "Year Make"),
          ),
          TextField(
            controller: currentoffer,
            decoration: InputDecoration(
                hintText: "Enter Current Offer", labelText: "Current Offer"),
            readOnly: true,
          ),
          TextField(
            controller: discountvalue,
            readOnly: true,
            decoration: InputDecoration(
                hintText: "Enter Discount Value", labelText: "Discount Value"),
          ),
          TextField(
            controller: revised,
            decoration: InputDecoration(
                hintText: "Enter the New Revised value",
                labelText: "Enter the New Revised value"),
          ),
          TextField(
            controller: commants,
            decoration: InputDecoration(
                hintText: "Enter The Commants",
                labelText: "Enter The Commants"),
          ),
          /*       TextField(
            controller: referrername,
            decoration: InputDecoration(
                hintText: "Enter Referrer Name", labelText: "Referrer Name"),
          ), */
          /* DropdownButton(
            //controller:requeststatus,
            value: dropdownvalue,

            icon: Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                dropdownvalue = newValue;
              });
            },
          ), */
          MaterialButton(
            child: Text("Move to Approved"),
            onPressed: () {
              DateTime dateToday = new DateTime.now();
              String statuschangetime = dateToday.toString().substring(0, 10);
              editData("approved", statuschangetime);
              // date = DateTime.now();
              //revisedd();
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => JsonParseDemo()),
                  )
                  .then((users) => setState(() {
                        _users = users;
                        _loading = true;
                      }));
            },
          ),
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
