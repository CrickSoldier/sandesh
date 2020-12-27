import 'package:Sandesh/helper/helperfunctions.dart';
import 'package:Sandesh/views/appInfo.dart';
import 'package:Sandesh/views/contacts.dart';
import 'package:Sandesh/views/login.dart';
import 'package:Sandesh/views/profilePage.dart';
import 'package:Sandesh/views/savedMessageScreen.dart';
import 'package:Sandesh/widgets/thought.dart';
// import 'package:Sandesh/views/showProfile.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Sandesh/services/auth.dart';
import 'package:Sandesh/helper/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';

class DrawerMain extends StatefulWidget {
  @override
  _DrawerMainState createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  AuthMethods authMethods = new AuthMethods();

  String name = "Saved Messages";
  String chatroom = Constants.myEmail;

  signOut() async {
    setState(() {
      authMethods.signOut();
    });
  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Colors.orangeAccent,
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(Constants.myProfileImage),
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePageView())),
                              },
                            )),
                      ),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(14),
                            margin: EdgeInsets.only(top: 30),
                            child: Text(Constants.myName,
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   child: ListTile(
          //       leading: Icon(
          //         FontAwesomeIcons.linkedin,
          //         color: Colors.green,
          //       ),
          //       title: Text(
          //         'LinkedIn',
          //         style: TextStyle(fontSize: 16),
          //       ),
          //       onTap: () => {
          //             launch(
          //                 ''),
          //           }),
          // ),
          // GestureDetector(
          //   child: ListTile(
          //       leading: Icon(
          //         FontAwesomeIcons.facebook,
          //         color: Colors.green,
          //       ),
          //       title: Text(
          //         'Facebook',
          //         style: TextStyle(fontSize: 16),
          //       ),
          //       onTap: () => {
          //             launch(
          //                 ''),
          //           }),
          // ),
          // GestureDetector(
          //   child: ListTile(
          //       leading: Icon(
          //         FontAwesomeIcons.twitter,
          //         color: Colors.green,
          //       ),
          //       title: Text(
          //         'Twitter',
          //         style: TextStyle(fontSize: 16),
          //       ),
          //       onTap: () => {
          //             launch(''),
          //           }),
          // ),
          // GestureDetector(
          //   child: ListTile(
          //       leading: Icon(
          //         FontAwesomeIcons.instagram,
          //         color: Colors.green,
          //       ),
          //       title: Text(
          //         'Instagram',
          //         style: TextStyle(fontSize: 16),
          //       ),
          //       onTap: () => {
          //             launch(''),
          //           }),
          // ),
          // GestureDetector(
          //   child: ListTile(
          //       leading: Icon(
          //         FontAwesomeIcons.globe,
          //         color: Colors.green,
          //       ),
          //       title: Text(
          //         'Website',
          //         style: TextStyle(fontSize: 16),
          //       ),
          //       onTap: () => {
          //             launch(''),
          //           }),
          // ),
          GestureDetector(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePageView())),
            },
            child: ListTile(
              leading: Icon(
                Icons.photo,
                color: Colors.green,
              ),
              title: Text(
                'Your Profile',
                style: TextStyle(fontSize: 16),
              ),
              // onTap: () => {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => AppInfo())),
              // },
            ),
          ),
          // GestureDetector(
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.contacts,
          //       color: Colors.green,
          //     ),
          //     title: Text(
          //       'Contacts',
          //       style: TextStyle(fontSize: 16),
          //     ),
          //     onTap: () async {
          //       final PermissionStatus permissionStatus =
          //           await _getPermission();
          //       if (permissionStatus == PermissionStatus.granted) {
          //         //We can now access our contacts here
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => ContactsPage()));
          //       } else {
          //         //If permissions have been denied show standard cupertino alert dialog
          //         showDialog(
          //             context: context,
          //             builder: (BuildContext context) => CupertinoAlertDialog(
          //                   title: Text('Permissions error'),
          //                   content: Text('Please enable contacts access '
          //                       'permission in system settings'),
          //                   actions: <Widget>[
          //                     CupertinoDialogAction(
          //                       child: Text('OK'),
          //                       onPressed: () => Navigator.of(context).pop(),
          //                     )
          //                   ],
          //                 ));
          //       }
          //     },
          //   ),
          // ),
          GestureDetector(
            child: ListTile(
              leading: Icon(
                Icons.save,
                color: Colors.green,
              ),
              title: Text(
                'Saved Messages',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SavedMessages(
                              userName: name,
                              chatRoomId: chatroom,
                            ))),
              },
            ),
          ),
          // GestureDetector(
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.save,
          //       color: Colors.green,
          //     ),
          //     title: Text(
          //       'Today\'s Thought',
          //       style: TextStyle(fontSize: 16),
          //     ),
          //     onTap: () => {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => Thought())),
          //     },
          //   ),
          // ),
          Divider(),
          GestureDetector(
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.green,
              ),
              title: Text(
                'AppInfo',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppInfo())),
              },
            ),
          ),
          ListTile(
              title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: GestureDetector(
              onTap: () {
                authMethods.signOut();
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                HelperFunctions.saveUserAvatarSharedPreference(null);
                HelperFunctions.saveUserEmailSharedPreference(null);
                HelperFunctions.saveUserNameSharedPreference(null);
                HelperFunctions.saveNameSharedPreference(null);
                HelperFunctions.saveUserPhoneNoSharedPreference(null);
                HelperFunctions.saveUserBioSharedPreference(null);
                HelperFunctions.saveUserLocationSharedPreference(null);
                HelperFunctions.saveUserUuidSharedPreference(null);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.green,
                  Colors.green,
                ])),
                child: Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

// mEKV13bBs0M3NFKp7K6Z1RbUQz63

// xo8tJVQxuPZPD0fp2F2lPHcWP7q2
