import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql_crud/editdata.dart';
import 'package:flutter_mysql_crud/main.dart';

import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  List list;
  int index;

  Details({this.list, this.index});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
    var url = "http://14.141.213.116:861/deletedata.php";
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
 /*  void delete() {
    var url = "http://14.141.213.116:861/deletedata.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
    });
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Are You Sure?"),
      actions: [
        MaterialButton(
          child: Text("OK DELETE"),
          onPressed: () {
            delete();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()));
          },
        ),
        MaterialButton(
          child: Text("CANCEL"),
          onPressed: () {},
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.list[widget.index]['name']}'),
      ),
      body: Container(
        child: Column(
          children: [
            /* Text(
              widget.list[widget.index]['id'],
              style: TextStyle(fontSize: 20.0),
            ), */
            Text(
              widget.list[widget.index]['name'],
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              widget.list[widget.index]['salesexcutivename'],
            ),
            MaterialButton(
              child: Text("Edit"),
              color: Colors.deepPurpleAccent,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Edit(list: widget.list, index: widget.index)),
              ),
            ),
            MaterialButton(
                child: Text("Delete"),
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  confirm();
                })
          ],
        ),
      ),
    );
  }
} */
