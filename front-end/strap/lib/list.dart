import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import './user.dart';
import './detail.dart';
import 'package:http/http.dart' as http;

class MyList extends StatelessWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<User> users = [];
    var url = 'http://10.0.2.2:1337/apis';

    Future getAll() async {
      // var data = await http.get(Uri.parse(url));
      var data = await http.get(Uri.parse(url));
      var jsonData = json.decode(data.body);
      for (var u in jsonData) {
        users.add(User(u['id'], u['name'], u['email'], u['password']));
      }
      return users;
    }

    return Container(
      child: Container(
        child: FutureBuilder(
          future: getAll(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading....'),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      snapshot.data[index].name,
                    ),
                    subtitle: Text(
                      snapshot.data[index].email,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => Detail(snapshot.data[index]),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
