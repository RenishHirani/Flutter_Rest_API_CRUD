import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ad extends StatelessWidget {
  String? id;
  String? name;

  Ad({super.key, this.id, this.name});

  TextEditingController nameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      nameC.clear();
    } else {
      nameC.text = name.toString();
    }

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: nameC,
          decoration: InputDecoration(labelText: 'Fac_Name'),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Map<String, dynamic> m = {};
              m['Fac_Name'] = nameC.text;

              if (id == null) {
                ins(m).then((value) => Navigator.pop(context));
              } else {
                up(m).then((value) => Navigator.pop(context));
              }
            },
            child: id == null ? Text('Add') : Text('Update'))
      ]),
    );
  }

  Future<void> ins(map) async {
    var res = await http.post(
        Uri.parse("https://649d8b5f9bac4a8e669dea25.mockapi.io/arrayofobject"),
        body: map);
  }

  Future<void> up(map) async {
    var res = await http.put(
        Uri.parse(
            'https://649d8b5f9bac4a8e669dea25.mockapi.io/arrayofobject/$id'),
        body: map);
  }
}
