import 'dart:io';

import 'package:cupid_knot/Home.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class Register_Details extends StatefulWidget {
  const Register_Details({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
      ),
      body: Form_state(),
    );
  }
}

enum Gender { Male, Female, Others }

class Form_state extends StatefulWidget {
  const Form_state({Key key}) : super(key: key);

  @override
  _Form_stateState createState() => _Form_stateState();
}

class _Form_stateState extends State<Form_state> {
  @override
  DateTime selectedDate = DateTime.now();
  DateTime _NowDate = null;
  File _image;

  final _key = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Gender gender = Gender.Male;

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _key,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.blue,
              child: _image == null
                  ? InkWell(
                      child: Container(
                        child: Icon(Icons.camera_alt_outlined),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      onTap: () async {
                        _showPicker(context);
                      },
                    )
                  : InkWell(
                      child: ClipRRect(
                        child: Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onTap: () async {
                        _showPicker(context);
                      },
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Profile Photo"),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter First Name ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "First Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Last Name ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            _NowDate == null
                ? InkWell(
                    child: Container(
                      child: Center(
                        child: Text(
                          "Click here to enter date of birth",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue[200],
                      ),
                    ),
                    onTap: () async {
                      selectDate(context);
                    },
                  )
                : Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          child: Container(
                            child: Center(
                              child: Text(
                                "Date of Birth",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue[200],
                            ),
                          ),
                          onDoubleTap: () async {
                            selectDate(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: InkWell(
                              child: Container(
                                height: 50,
                                width: 200,
                                child: Center(
                                  child: Text(
                                    "${_NowDate.day}/${_NowDate.month}/${_NowDate.year}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue)),
                              ),
                              onTap: () async {
                                selectDate(context);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    child: Center(child: Text("Gender :")),
                    width: 75,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Male",
                      style: TextStyle(fontSize: 15),
                    ),
                    leading: Radio(
                        value: Gender.Male,
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        }),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Female",
                      style: TextStyle(fontSize: 15),
                    ),
                    leading: Radio(
                        value: Gender.Female,
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                child: Text("Submit"),
                color: Colors.blue,
                onPressed: () async {
                  if (_NowDate == null) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Enter Your Date of birth"),
                        backgroundColor: Colors.red[400],
                      ),
                    );
                  } else {
                    try {
                      post(
                          Uri.parse(
                              "https://cupidknot.kuldip.dev/api/register"),
                          body: {
                            "first_name": _firstNameController.toString(),
                            "password": _lastNameController.toString(),
                            "birth_date":
                                "${_NowDate.day}/${_NowDate.month}/${_NowDate.year}",
                            "gender": gender,
                          }).whenComplete(() {
                        post(
                            Uri.parse(
                                "https://cupidknot.kuldip.dev/api/user_images"),
                            body: {"original_photo[]": _image});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        print("success");
                      });
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _NowDate = selectedDate;
      });
  }

  _imagefromGallary() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  _imagefromCamera() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imagefromGallary();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imagefromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
