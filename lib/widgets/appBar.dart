import 'package:Sandesh/helper/constants.dart';
import 'package:Sandesh/views/profilePage.dart';
import 'package:flutter/material.dart';
// import 'package:leadindia/helper/constants.dart';
// import 'package:leadindia/views/profilePageView.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text("Sandesh"),
    // title: Image.asset(
    //   "assets/images/LEADIndia.png",
    //   height: 40,
    // ),
    backgroundColor: Colors.orangeAccent,
    elevation: 0.0,
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(Constants.myProfileImage),
                  fit: BoxFit.cover)),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePageView()));
        },
      )
    ],
  );
}
