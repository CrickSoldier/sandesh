import 'package:Sandesh/views/login.dart';
import 'package:flutter/material.dart';
// import 'package:Sandesh/helper/authenticate.dart';
import 'package:Sandesh/services/auth.dart';
// import 'package:Sandesh/views/welcome.dart';

import 'homePage.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  final formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController =
      new TextEditingController();

  forgetPassword() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods.resetPass(emailTextEditingController.text);

      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              )),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/sandesh.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 26),
                            child: TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Please Enter Correct Email";
                              },
                              controller: emailTextEditingController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.mail,
                                    color: Colors.green,
                                  ),
                                  hintText: "Enter your Email",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    GestureDetector(
                      onTap: () {
                        forgetPassword();
                      },
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.green, Colors.green])),
                            child: Text(
                              "Reset Password",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
