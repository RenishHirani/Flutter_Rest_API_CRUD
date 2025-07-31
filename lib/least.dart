import 'dart:convert';
import 'package:eval_22/Ad.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Least extends StatefulWidget {
  const Least({super.key});

  @override
  State<Least> createState() => _LeastState();
}

class _LeastState extends State<Least> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Api Crud"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Ad(),
                  ));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder<List<dynamic>>(
          future: al(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(snapshot.data![index]['Fac_Name'])),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            del(snapshot.data![index]['id']).then(
                              (value) {
                                setState(() {});
                              },
                            );
                          },
                          child: Icon(Icons.delete),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ad(
                                  id: snapshot.data![index]['id'],
                                  name: snapshot.data![index]['Fac_Name'],
                                ),
                              ));
                            },
                            child: Icon(Icons.edit))
                      ],
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<List<dynamic>> al() async {
    var res = await http.get(
        Uri.parse("https://649d8b5f9bac4a8e669dea25.mockapi.io/arrayofobject"));
    return jsonDecode(res.body);
  }

  Future<dynamic> del(id) async {
    var res = await http.delete(Uri.parse(
        "https://649d8b5f9bac4a8e669dea25.mockapi.io/arrayofobject/$id"));
    return res;
  }
}
