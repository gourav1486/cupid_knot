import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:cupid_knot/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url;
  void initState() {
    super.initState();
    Get_details();
  }

  @override
  Widget build(BuildContext context) {
    ShowSnackbar(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                "LogOut",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: Logout,
            ),
          ],
        ),
      ),
    );
  }

  Logout() async {
    post(Uri.parse("https://cupidknot.kuldip.dev/api/logout"));

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  var _jsonInfo = [];
  Get_details() async {
    try {
      final _response =
          await get(Uri.parse("https://cupidknot.kuldip.dev/api/user"));
      final _jsonData = jsonDecode(_response.body) as List;
      setState(() {
        _jsonInfo = _jsonData;
      });
      print(_jsonInfo);
    } catch (e) {}
  }
}

void ShowSnackbar(context) async {
  final snack_message = SnackBar(
    content: Text(
      "no network connection",
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 50),
    backgroundColor: Colors.orange,
  );
  if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
    Scaffold.of(context).showSnackBar(snack_message);
  }
}
