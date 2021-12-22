import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/admin_dash.dart';
import 'package:flutter_mysql_crud/main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Approvedviewdetails extends StatefulWidget {
  final List list;
  final int index;

  Approvedviewdetails({this.list, this.index});

  @override
  _ApprovedviewdetailsState createState() => _ApprovedviewdetailsState();
}

class _ApprovedviewdetailsState extends State<Approvedviewdetails> {
  String dropdownvalue = 'Approved';
  var items = [
    'Approved',
    'Denied',
  ];

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

  void editData() {
    var url = "http://14.141.213.116:861/editdata.php";
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
      "requeststatus": requeststatus.text,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFECA585),
        title: Text("Information About ${widget.list[widget.index]['name']}"),
      ),
      body: ListView(
        children: [
          TextField(
            controller: cname,
            enableInteractiveSelection: true,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Customer Name", labelText: "Customer Name"),
          ),
          TextField(
            controller: cmobile,
            enabled: false,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
                hintText: "Field Sales excutive name",
                labelText: "Field Sales excutive name"),
          ),
          TextField(
            controller: branch,
            enableInteractiveSelection: false,
            enabled: false,
            decoration:
                InputDecoration(hintText: "Enter Branch", labelText: "Branch"),
          ),
          TextField(
            controller: carmodel,
            enableInteractiveSelection: false,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Car Model", labelText: "Car Model"),
          ),
          TextField(
            controller: yearmake,
            enableInteractiveSelection: false,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Year Make", labelText: "Year Make"),
          ),
          TextField(
            controller: currentoffer,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Current Offer", labelText: "Current Offer"),
          ),
          TextField(
            controller: discountvalue,
            enableInteractiveSelection: false,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Discount Value", labelText: "Discount Value"),
          ),
          TextField(
            controller: existingornew,
            enableInteractiveSelection: false,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Existing or new",
                labelText: "Are You Existing Customer or new ?"),
          ),
          TextField(
            controller: referredcustomer,
            enableInteractiveSelection: false,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Yes or No",
                labelText: "Are You Referred Customer?"),
          ),
          TextField(
            controller: referrername,
            enableInteractiveSelection: false,
            enabled: false,
            decoration: InputDecoration(
                hintText: "Enter Referrer Name", labelText: "Referrer Name"),
          ),
          /* dropdown
          DropdownButton(
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
          /*   MaterialButton(
            child: Text("Edit Data"),
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
