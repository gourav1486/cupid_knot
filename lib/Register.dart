import 'package:cupid_knot/LoginPage.dart';
import 'package:cupid_knot/Register_Details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
  final _Confirmcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 70,
                    child: Center(
                      child: Text(
                        "Confirm :",
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
                        obscureText: false,
                        controller: _Confirmcontroller,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
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
                    if (_Confirmcontroller.text == _PassWordlcontroller.text) {
                      try {
                        post(
                            Uri.parse(
                                "https://cupidknot.kuldip.dev/api/register"),
                            body: {
                              "email": _emailcontroller.toString(),
                              "password": _PassWordlcontroller.toString(),
                              "password_confirmation":
                                  _Confirmcontroller.toString(),
                            }).whenComplete(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register_Details()));
                          print("success");
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter Confirm Password ")));
                      _Confirmcontroller.clear();
                    }
                  }
                },
                child: Text('Register'),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text("Already have an Account? Login"))
          ],
        ));
  }
}
