import 'package:cupid_knot/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Register.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Container(
        color: Colors.blue[200],
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(child: Forms()),
            ),
          ),
        ),
      ),
    );
  }
}

class Forms extends StatefulWidget {
  const Forms({Key key}) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _PassWordlcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text(
                      "Email :",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[200]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[200]),
                    height: 50,
                    width: 300,
                    child: TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                          hintText: "Enter Your UserName",
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email Address';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 70,
                  child: Center(
                    child: Text(
                      "Password :",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[200]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[200]),
                    height: 50,
                    width: 280,
                    child: TextFormField(
                      obscureText: true,
                      controller: _PassWordlcontroller,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.blue[200],
            ),
            height: 50,
            width: 100,
            child: FlatButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  post(Uri.parse("https://cupidknot.kuldip.dev/api/login"),
                      body: {
                        "username": _emailcontroller.toString(),
                        "password": _PassWordlcontroller.toString(),
                      }).whenComplete(() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage())));
                }
              },
              child: Text('Login'),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text("Don't have an Account? Register"))
        ],
      ),
    );
  }
}
