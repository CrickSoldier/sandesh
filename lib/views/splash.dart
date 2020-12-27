import 'package:flutter/material.dart';
import 'package:Sandesh/helper/helperfunctions.dart';
import 'package:Sandesh/views/homePage.dart';
import 'package:Sandesh/views/login.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isUserLoggedIn;

  void _moveToHome() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => isUserLoggedIn != null
                ? isUserLoggedIn ? HomePage() : Login()
                : Login()),
        (Route<dynamic> _) => false);
  }

  getLoggedInState() async {
    isUserLoggedIn = false;

    await HelperFunctions.getUserLoggedInSharedPreference().then((result) {
      setState(() {
        isUserLoggedIn = result;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToHome();
    getLoggedInState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'San',
                    style: GoogleFonts.portLligatSans(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: 69,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffe46b10),
                    ),
                    children: [
                      TextSpan(
                        text: 'd',
                        style: TextStyle(color: Colors.blue, fontSize: 69),
                      ),
                      TextSpan(
                        text: 'esh',
                        style: TextStyle(color: Colors.green, fontSize: 69),
                      ),
                    ]),
              ),
              Text(
                "India's Chatting App",
                style: TextStyle(
//                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              SizedBox(
                height: 155,
              )
            ],
          ),
        ),
      ),
    );
  }
}
