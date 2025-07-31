import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Adduser.dart';

class apiDemo extends StatefulWidget {
  const apiDemo({super.key});

  @override
  State<apiDemo> createState() => _apiDemoState();
}

class _apiDemoState extends State<apiDemo> {
  @override
  void initState() {
    super.initState();
    getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api CRUD Demo"),
        actions: [
          InkWell(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AddUser(null);
                },
              )).then((value) {
                if (value == true) {
                  setState(() {});
                }
              });
            },
            child: Container(
              child: Icon(Icons.add),
              margin: EdgeInsets.only(right: 10),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getDetail(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(snapshot.data![index]['Fac_Name']),
                        SizedBox(
                          width: 45,
                        ),
                        Expanded(
                            child:
                                Text(snapshot.data![index]['Fac_Phn_Number'])),
                        Container(
                          child: TextButton(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Are You Sure???"),
                                    actions: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: TextButton(
                                                onPressed: () async {
                                                  await deleteUser(snapshot
                                                          .data![index]["id"])
                                                      .then((value) {
                                                    setState(() {});
                                                  }).then((value) =>
                                                          Navigator.of(context)
                                                              .pop());
                                                },
                                                child: Text("Yes"),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text("No"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          child: TextButton(
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return AddUser(snapshot.data![index]);
                                },
                              )).then((value) {
                                setState(() {});
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<List<dynamic>> getDetail() async {
  var res = await http.get(
    Uri.parse("https://649d8b5f9bac4a8e669dea25.mockapi.io/arrayofobject"),
  );
  return jsonDecode(res.body);
}

Future<void> deleteUser(String id) async {
  var res = await http.delete(Uri.parse(
      'https://649d8b5f9bac4a8e669dea25.mockapi.io/arrayofobject/$id'));
}
