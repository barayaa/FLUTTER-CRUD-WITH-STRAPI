import 'package:flutter/material.dart';
import 'package:strap/main.dart';
import 'package:strap/user.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  User user;
  Detail(this.user);

  @override
  State<Detail> createState() => _DetailState(this.user);
}

class _DetailState extends State<Detail> {
  User user;
  _DetailState(this.user);

  void edit() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Home(0, user.id)));
  }

  void delete() async {
    await http.delete(Uri.parse("http://10.0.2.2:1337/apis/${this.user.id}"));
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Home(1, 0)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            user.name,
          ),
        ),
        body: Container(
            child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Id " + user.id.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Name: " + user.name,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Email: " + user.email,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: edit,
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text(
                        'Edit',
                      ),
                    ),
                    Spacer(),
                    MaterialButton(
                      onPressed: delete,
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text(
                        'Delete',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
