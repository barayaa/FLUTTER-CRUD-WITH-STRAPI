// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:strap/form.dart';
import 'package:strap/list.dart';

void main() {
  runApp(Home(0, 0));
}

// ignore: must_be_immutable
class Home extends StatefulWidget {
  int state;
  int id;
  Home(this.state, this.id);

  @override
  State<Home> createState() => _HomeState(this.state, this.id);
}

class _HomeState extends State<Home> {
  int state;
  int id;
  int _currentIndex = 1;
  late Widget _body;
  late String _title;
  _HomeState(this.state, this.id);
  @override
  void initState() {
    super.initState();
    changeView(state);
  }

  void onTap(index) {
    changeView(index);
  }

  void changeView(index) {
    _currentIndex = index;
    setState(() {
      switch (index) {
        case 0:
          {
            _title = "Form";
            _body = MyForm(this.id);
            break;
          }
        case 1:
          {
            _title = "List";
            _body = MyList();
            break;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(_title),
        ),
        body: _body,
        // ignore: prefer_const_literals_to_create_immutables
        bottomNavigationBar: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.table_chart,
              ),
              label: 'List',
            ),
          ],
          currentIndex: _currentIndex,
          onTap: changeView,
        ),
      ),
    );
  }
}
