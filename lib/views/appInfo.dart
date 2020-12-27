import 'package:flutter/material.dart';
import 'package:Sandesh/widgets/appBar.dart';

class AppInfo extends StatefulWidget {
  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Scaffold(
            body: Center(
                child: Text(
                    'Version 1.0  \n Designed and Developed by \n \"Sandesh\" \n All Rights Reserved \u00a9 2020 \n \"Vocal For Local\"',
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center))));
  }
}
