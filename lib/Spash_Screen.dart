import 'package:connectivity/connectivity.dart';
import 'package:cupid_knot/Register.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  var result;
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 10,
        navigateAfterSeconds: Register(),
        backgroundColor: Colors.blue[500],
        loaderColor: Colors.red,
        loadingText: loadingText());
  }

  loadingText() {
    check_connection();
    if (result == ConnectivityResult.none) {
      return Text(
        "Check Internet \n Connection",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    } else {
      return Text(
        "Loading \n please wait",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    }
  }

  check_connection() async {
    result = await Connectivity().checkConnectivity();
    setState(() {
      result = this.result;
    });
  }
}
