import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:strap/main.dart';
import './user.dart';
import 'package:http/http.dart' as http;

class MyForm extends StatefulWidget {
  int id;
  MyForm(this.id);

  @override
  State<MyForm> createState() => _MyFormState(this.id);
}

class _MyFormState extends State<MyForm> {
  int id;
  _MyFormState(this.id);
  User user = User(0, '', '', '');
  var url = 'http://10.0.2.2:1337/apis/';

  Future save() async {
    if (user.id == 0) {
      await http.post(Uri.parse(url), headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      }, body: <String, String>{
        'name': user.name,
        'email': user.email,
        'password': user.password
      });
    } else {
      await http.put(Uri.parse(url), headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      }, body: <String, String>{
        'name': user.name,
        'email': user.email,
        'password': user.password
      });
    }
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Home(1, 0)));
  }

  @override
  void initState() {
    super.initState();
    if (this.id != 0) {
      getOne();
    }
  }

  void getOne() async {
    var data =
        await http.get(Uri.parse("http://10.0.2.2:1337/apis/${this.id}"));

    var u = json.decode(data.body);
    setState(() {});
    user = User(u['id'], u['name'], u['email'], u['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      child: Padding(
        padding: EdgeInsets.all(
          20,
        ),
        child: Column(
          children: [
            Visibility(
              visible: false,
              child: TextField(
                controller: TextEditingController(
                  text: user.id.toString(),
                ),
              ),
            ),
            TextField(
              controller: TextEditingController(text: user.name),
              onChanged: (val) {
                user.name = val;
              },
              decoration: InputDecoration(
                labelText: 'Name',
                icon: Icon(
                  Icons.person,
                ),
              ),
            ),
            TextField(
              controller: TextEditingController(text: user.email),
              onChanged: (val) {
                user.email = val;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                icon: Icon(
                  Icons.email,
                ),
              ),
            ),
            TextField(
              controller: TextEditingController(text: user.password),
              onChanged: (val) {
                user.password = val;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.vpn_key),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: double.infinity,
                onPressed: save,
                child: Text('Save'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
