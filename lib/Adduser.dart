import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();

  dynamic? map;
  AddUser(this.map);

  GlobalKey<FormState> formkey = GlobalKey();
  var name = new TextEditingController();
  var mobile_no = new TextEditingController();
}

class _AddUserState extends State<AddUser> {
  void initState() {
    widget.name.text = widget.map == null ? '' : widget.map['Fac_Name'];
    widget.mobile_no.text = widget.map == null ? '' : widget.map['Fac_Phn_Number'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TextFormField(
              controller: widget.name,
              decoration: InputDecoration(
                hintText: "Enter Faculty name",
              ),
            ),
          ),
          Container(
            child: TextFormField(
              controller: widget.mobile_no,
              decoration: InputDecoration(
                hintText: "Enter Faculty's mobile no.",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {
                if (widget.map == null) {
                  await addFaculty().then((value) => (value) {});
                } else {
                  await editFaculty(widget.map!["id"].toString())
                      .then((value) => (value) {
                            setState(() {});
                          });
                }

                Navigator.of(context).pop(true);
              },
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 24),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addFaculty() async {
    var map = {};
    map['Fac_Name'] = widget.name.text;
    map['Fac_Phn_Number'] = widget.mobile_no.text;
    var response1 = http.post(
        Uri.parse(
          "https://649d8b5f9bac4a8e669dea25.mockapi.io/arrayofobject",
        ),
        body: map);
  }

  Future<void> editFaculty(String id) async {
    var map = {};
    map['Fac_Name'] = widget.name.text;
    map['Fac_Phn_Number'] = widget.mobile_no.text;
    var response1 = http.put(
      Uri.parse(
        "https://649d8b5f9bac4a8e669dea25.mockapi.io/arrayofobject/$id",
      ),
      body: map,
    );
  }
}