import 'package:Sandesh/helper/constants.dart';
import 'package:Sandesh/services/database.dart';
import 'package:Sandesh/views/chatScreen.dart';
import 'package:Sandesh/views/messageTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'chat_dummy_model.dart';

class MessagePage extends StatefulWidget {
  @override
  MessagePageState createState() {
    return new MessagePageState();
  }
}

class MessagePageState extends State<MessagePage> {
  bool isLoading = false;
  TextEditingController searchTextEditingController =
      new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatStream;
  // QuerySnapshot receiverSnapshot;

  getChats() async {
    // Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    await databaseMethods.getMyAllChats(Constants.myUserId).then((result) {
      chatStream = result;
      setState(() {});
    });
  }

  @override
  void initState() {
    getChats();
    super.initState();
  }

  Widget chatList() {
    return StreamBuilder(
      stream: chatStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatTile(
                    snapshot.data.documents[index].data["usersName"],
                    snapshot.data.documents[index].data["usersProfileImage"],
                    snapshot.data.documents[index].data["chatRoomId"],
                    snapshot.data.documents[index].data["usersId"],
                    snapshot.data.documents[index].data["last_msg"],
                    snapshot.data.documents[index].data["unseen_msg_count"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return chatList();
    // new ListView.builder(
    //   itemCount: dummyData.length,
    //   itemBuilder: (context, i) => new Column(
    //     children: <Widget>[
    //       new Divider(
    //         height: 10.0,
    //       ),
    //       new ListTile(
    //         leading: new CircleAvatar(
    //           foregroundColor: Theme.of(context).primaryColor,
    //           backgroundColor: Colors.grey,
    //           backgroundImage: new NetworkImage("https://firebasestorage.googleapis.com/v0/b/leadindia-1b339.appspot.com/o/defaultAvatar%2F052-man-4.png?alt=media&token=7c558f31-e748-4ed7-988e-db3cbdae31a6"),
    //         ),
    //         title: new Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             new Text(
    //               dummyData[i].name,
    //               style: new TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             new Text(
    //               dummyData[i].time,
    //               style: new TextStyle(color: Colors.grey, fontSize: 14.0),
    //             ),
    //           ],
    //         ),
    //         subtitle: new Container(
    //           padding: const EdgeInsets.only(top: 5.0),
    //           child: new Text(
    //             dummyData[i].message,
    //             style: new TextStyle(color: Colors.grey, fontSize: 15.0),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
