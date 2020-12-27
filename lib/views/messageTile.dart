import 'package:flutter/material.dart';
import 'package:Sandesh/views/chatScreen.dart';
import 'package:Sandesh/helper/constants.dart';
import 'package:Sandesh/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatTile extends StatefulWidget {
  final List usersName;
  final List usersProfileImage;

  final String chatRoomId;
  List usersId;
  String last_msg;
  int unseen_msg_count;
  ChatTile(this.usersName, this.usersProfileImage, this.chatRoomId,
      this.usersId, this.last_msg, this.unseen_msg_count);
  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  String userName;
  String image;
  String userImage;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.usersName.length; i++) {
      if (widget.usersName[i] != Constants.myName) {
        userName = widget.usersName[i];
      }
    }

    for (int i = 0; i < widget.usersProfileImage.length; i++) {
      if (widget.usersProfileImage[i] != Constants.myProfileImage) {
        userImage = widget.usersProfileImage[i];
      }
    }
    return new Column(
      children: <Widget>[
        new Divider(
          height: 10.0,
        ),
        new ListTile(
          leading: new CircleAvatar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
            backgroundImage: new NetworkImage(userImage),
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                          userName: userName.toUpperCase(),
                          chatRoomId: widget.chatRoomId,
                          usersId: widget.usersId)));
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  userName,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  "",
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          subtitle: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                          userName: userName.toUpperCase(),
                          chatRoomId: widget.chatRoomId,
                          usersId: widget.usersId)));
            },
            child: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                widget.last_msg,
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          ),
        )
      ],
    );
    // return Card(
    //     elevation: 5,
    //     color: Colors.white,
    //     child: Padding(
    //       padding: const EdgeInsets.all(20.0),
    //       child: Column(
    //         children: <Widget>[
    //           Container(
    //             height: 40,
    //             width: 40,
    //             alignment: Alignment.center,
    //             decoration: BoxDecoration(
    //                 color: Colors.green,
    //                 borderRadius: BorderRadius.circular(50)),
    //             child: Text(
    //               userName.substring(0, 1).toUpperCase(),
    //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Flexible(
    //             child: Text(
    //               userName.toUpperCase(),
    //               style: TextStyle(
    //                 fontSize: 16.0,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => ChatScreen(
    //                           userName: userName.toUpperCase(),
    //                           chatRoomId: chatRoomId,
    //                           usersId: usersId)));
    //             },
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Icon(
    //                   Icons.chat,
    //                   color: Colors.green,
    //                 ),
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text('Chat Now')
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ));
  }
}
