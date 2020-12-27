// import 'dart:io';
import 'package:Sandesh/views/chatScreen.dart';
import 'package:Sandesh/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:Sandesh/helper/constants.dart';
// import 'package:leadindia/views/editProfilePage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:Sandesh/helper/helperfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sandesh/services/database.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:geolocator/geolocator.dart';

class ShowProfile extends StatefulWidget {
  final String name,
      username,
      email,
      phoneNumber,
      profileImage,
      profileBio,
      uId;
  ShowProfile(
      {Key key,
      this.name,
      this.username,
      this.email,
      this.phoneNumber,
      this.profileImage,
      this.profileBio,
      this.uId})
      : super(key: key);

  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isLoading = false;
  QuerySnapshot userInfoSnapshot;

  sendMessage() {
    if (widget.uId != Constants.myUserId) {
      List<String> usersName = [Constants.myName, widget.name];
      List<String> usersProfileImage = [
        Constants.myProfileImage,
        widget.profileImage
      ];
      List<String> users = [Constants.myEmail, widget.email];
      List<String> usersId = [Constants.myUserId, widget.uId];
      String chatRoomId = getChatRoomId(Constants.myUserId, widget.uId);
      Map<String, dynamic> chatRoom = {
        "usersName": usersName,
        "usersProfileImage": usersProfileImage,
        "users": users,
        "usersId": usersId,
        "chatRoomId": chatRoomId,
      };
      databaseMethods.addChatRoom(chatRoom, chatRoomId);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    userName: widget.name,
                    chatRoomId: chatRoomId,
                    usersId: usersId,
                  )));
    } else {
      print("You cannot send Message to Yourself!");

      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Hey! We cought you',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'You cannot send message to yourself.',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Text('Ok', style: TextStyle(fontSize: 15)),
                    SizedBox(width: 2),
                  ],
                ),
                color: Colors.green[700],
                elevation: 4,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.message),
            onPressed: () {
              sendMessage();
            }),
        appBar: appBarMain(context),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(widget.name,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(height: 20),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Icon(
                                                Icons.email,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: Text(widget.email,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Icon(
                                                Icons.phone,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text(widget.phoneNumber,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  )),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text("@ ",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19)),
                                              SizedBox(width: 5),
                                              Text(widget.username,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailScreen(
                                                  image: widget.profileImage,
                                                )));
                                  },
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.profileImage),
                                            fit: BoxFit.cover)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.description,
                            color: Colors.green,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.profileBio,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Divider(
                        height: 60,
                        color: Colors.grey,
                      ),
                      //   SizedBox(height: 10),
                      //   Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[
                      //       Icon(
                      //         Icons.add_location,
                      //         color: Colors.blue,
                      //       ),
                      //       SizedBox(width: 15),
                      //       Expanded(
                      //         child: new Column(
                      //           mainAxisSize: MainAxisSize.max,
                      //           children: <Widget>[
                      //             Text("widget.currentLocation",
                      //                 style: TextStyle(
                      //                   color: Colors.grey[800],
                      //                   height: 1.4,
                      //                 )),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   SizedBox(height: 50),
                      //   GestureDetector(
                      //     onTap: () {
                      //       sendMessage("widget.name", "widget.email");
                      //     },
                      //     child: Container(
                      //       width: 150.0,
                      //       height: 50.0,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //           color: Colors.green,
                      //           borderRadius: BorderRadius.circular(30)),
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 16, vertical: 10),
                      //       child: Text(
                      //         "Send Message",
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                )
              ],
            )));
  }
}

class DetailScreen extends StatelessWidget {
  final String image;
  DetailScreen({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              image,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
