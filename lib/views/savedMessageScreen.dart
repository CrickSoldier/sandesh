import 'package:Sandesh/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Sandesh/helper/constants.dart';
import 'package:Sandesh/services/database.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:Sandesh/views/videoPlayer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class SavedMessages extends StatefulWidget {
  final String userName;
  final String chatRoomId;
  // final List usersId;
  SavedMessages({Key key, @required this.userName, this.chatRoomId})
      : super(key: key);

  @override
  _SavedMessagesState createState() => _SavedMessagesState();
}

class _SavedMessagesState extends State<SavedMessages> {
  // ScrollController _scrollController =
  //     new ScrollController(); // set controller on scrolling
  // bool _show = false;
  // String date = "today";
  bool isLoading = false;
  final db = Firestore.instance;
  CollectionReference chatReference;
  QuerySnapshot receiverSnapshot;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final TextEditingController _textController = new TextEditingController();
  bool _isWritting = false;

  String readDate(String time, String date) {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    // String formattedTime = DateFormat('hh:mm:a').format(now);
    String formattedDate = formatter.format(now);
    if (formattedDate == date) {
      date = "Today";
      return date + " " + time;
    } else {
      return date + " " + time;
    }
  }

  // getReceiverDetails() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   List usersId = widget.usersId;
  //   String receiverUserId;
  //   for (int i = 0; i < usersId.length; i++) {
  //     if (usersId[i] != Constants.myDocId) {
  //       receiverUserId = usersId[i];
  //     }
  //   }

  //   // Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
  //   await databaseMethods.getReceiverData(receiverUserId).then((result) {
  //     receiverSnapshot = result;
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // handleScroll();
    // getReceiverDetails();
    chatReference = db
        .collection("SavedMessages")
        .document(widget.chatRoomId)
        .collection('chats');
  }

  // void showFloationButton() {
  //   setState(() {
  //     _show = true;
  //   });
  // }

  // void hideFloationButton() {
  //   setState(() {
  //     _show = false;
  //   });
  // }

  // _scrollToBottom() {
  //   _scrollController.animateTo(_scrollController.position.minScrollExtent,
  //       duration: Duration(milliseconds: 200), curve: Curves.linear);
  //   setState(() {
  //     _show = false;
  //   });
  // }

  // void handleScroll() async {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       hideFloationButton();
  //       Fluttertoast.showToast(
  //           msg: date,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.TOP,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.blueGrey[800],
  //           textColor: Colors.white,
  //           fontSize: 14.0);
  //     }
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       showFloationButton();
  //     }
  //   });
  // }

  displayData(documentSnapshot) {
    if (documentSnapshot.data['message'] != '') {
      return new Text(
        documentSnapshot.data['message'],
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    } else if (documentSnapshot.data['image'] != '') {
      return InkWell(
        child: new Container(
          margin: const EdgeInsets.only(bottom: 2.0),
          child: GestureDetector(
            child: Image.network(
              documentSnapshot.data['image'],
              fit: BoxFit.fitWidth,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(image: documentSnapshot.data['image'])));
            },
          ),
          height: 200,
          width: 200.0,
          color: Color.fromRGBO(0, 0, 0, 0.2),
        ),
      );
    } else if (documentSnapshot.data['video'] != '') {
      return GestureDetector(
          child: Image.asset('assets/images/video.png'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => VideoPLayer(
                          url: documentSnapshot.data['video'],
                        )));
          });
    } else if (documentSnapshot.data['file'] != '') {
      Future<void> _launched;
      String _launchUrl = documentSnapshot.data['file'];

      Future<void> _launchInBrowser(String url) async {
        if (await canLaunch(url)) {
          await launch(
            url,
            forceSafariVC: false,
            forceWebView: false,
            headers: <String, String>{'header_key': 'header_value'},
          );
        } else {
          throw 'Could not launch $url';
        }
      }

      return GestureDetector(
          child: Image.asset('assets/images/file2_96.png'),
          onTap: () {
            setState(() {
              _launched = _launchInBrowser(_launchUrl);
            });
          });
    }
  }

  List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
    // setState(() {
    //   date = documentSnapshot.data['date'];
    // });
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.fromLTRB(30, 0, 10, 0),
              padding: EdgeInsets.only(top: 5, bottom: 3, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23)),
                  gradient: LinearGradient(
                    colors: [Colors.green[800], Colors.green[500]],
                  )),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // new Text(documentSnapshot.data['sendBy'],
                  //     style: new TextStyle(
                  //         fontSize: 14.0,
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.bold)),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: displayData(documentSnapshot),
                  ),
                  new Text(
                    readDate(documentSnapshot.data['time'],
                        documentSnapshot.data['date']),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 10,
                    ),
                  ),
                  // new Icon(
                  //   Icons.check,
                  //   size: 12,
                  //   color: documentSnapshot.data['seen']
                  //       ? Colors.blue
                  //       : Colors.grey,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      // new Column(
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: <Widget>[
      //     new Container(
      //         margin: const EdgeInsets.only(left: 8.0),
      //         child: new CircleAvatar(
      //           backgroundImage:
      //               new NetworkImage(documentSnapshot.data['profile_photo']),
      //         )),
      //   ],
      // ),
    ];
  }

  List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
    // setState(() {
    //   date = documentSnapshot.data['date'];
    // });
    return <Widget>[
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: new CircleAvatar(
                backgroundImage:
                    new NetworkImage(documentSnapshot.data['profile_photo']),
              )),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
              padding: EdgeInsets.only(top: 5, bottom: 3, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
                  gradient: LinearGradient(
                    colors: [Colors.orange[500], Colors.orange[800]],
                  )),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // new Text(documentSnapshot.data['sendBy'],
                  //     style: new TextStyle(
                  //         fontSize: 14.0,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold)),
                  new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: displayData(documentSnapshot)),
                  new Text(
                    readDate(documentSnapshot.data['time'],
                        documentSnapshot.data['date']),
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  generateMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map<Widget>((doc) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: new Row(
                children: doc.data['sender_email'] != Constants.myEmail
                    ? generateReceiverLayout(doc)
                    : generateSenderLayout(doc),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      // floatingActionButton: Visibility(
      //     visible: _show,
      //     child: FloatingActionButton(
      //         backgroundColor: Colors.blueGrey[800],
      //         child: Icon(
      //           Icons.arrow_downward,
      //         ),
      //         onPressed: _scrollToBottom)),
      body: Container(
        padding: EdgeInsets.all(0),
        child: new Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: chatReference
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Center(
                    child: Text("Start your chat"),
                  );
                return Expanded(
                  child: new ListView(
                    // controller: _scrollController,
                    reverse: true,
                    children: generateMessages(snapshot),
                  ),
                );
              },
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Colors.green),
              child: _buildTextComposer(),
            ),
            new Builder(builder: (BuildContext context) {
              return new Container(width: 0.0, height: 0.0);
            })
          ],
        ),
      ),
    );
  }

  messageBar() {
    return _isWritting ? getDefaultSendButton() : getDefaultAttachmentButton();
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send, color: Colors.orange),
      onPressed: _isWritting ? () => _sendText(_textController.text) : null,
    );
  }

  pickVideoFromGallery() async {
    Navigator.pop(context);
    File file = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: [
          'mp4',
          'avi',
          'mov',
          'fly',
          'wmv',
          'm4v',
          'webm',
          'mkv'
        ]);
    uploadStatusVideo(file);
  }

  pickFileFromGallery() async {
    Navigator.pop(context);
    File file = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'docx',
          'doc',
          'txt',
          'xls',
          'csv',
          'zip',
          'rar',
          'tar'
        ]);
    uploadStatusFile(file);
  }

  void uploadStatusVideo(file) async {
    if (file != null) {
      String email = Constants.myEmail;
      int timestamp = new DateTime.now().millisecondsSinceEpoch;
      StorageReference storageReference = FirebaseStorage.instance.ref().child(
          '$email Storage Data/Saved Messages/video_' + timestamp.toString());
      StorageUploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.onComplete;
      String fileUrl = await storageReference.getDownloadURL();
      saveVideoToDatabase(fileUrl);
    }
  }

  void uploadStatusFile(file) async {
    if (file != null) {
      String email = Constants.myEmail;
      int timestamp = new DateTime.now().millisecondsSinceEpoch;
      StorageReference storageReference = FirebaseStorage.instance.ref().child(
          '$email Storage Data/Saved Messages/file_' + timestamp.toString());
      StorageUploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.onComplete;
      String fileUrl = await storageReference.getDownloadURL();
      saveFileToDatabase(fileUrl);
    }
  }

  attachment(context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Send Attachment",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Send Video ",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: pickVideoFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Send File",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: pickFileFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  IconButton getDefaultAttachmentButton() {
    return new IconButton(
        icon: new Icon(
          Icons.attach_file,
          color: Colors.orange,
        ),
        onPressed: () => attachment(context));
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color:
              _isWritting ? Color(0xff1D3C51) : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.photo_camera, color: Colors.orange),
                    onPressed: () async {
                      String chatroom = widget.chatRoomId;
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      String email = Constants.myEmail;
                      int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      StorageReference storageReference = FirebaseStorage
                          .instance
                          .ref()
                          .child('$email Storage Data/Saved Messages/img_' +
                              timestamp.toString() +
                              '.jpg');
                      StorageUploadTask uploadTask =
                          storageReference.putFile(image);
                      await uploadTask.onComplete;
                      String fileUrl = await storageReference.getDownloadURL();
                      _sendImage(messageText: '', imageUrl: fileUrl);
                    }),
              ),
              new Flexible(
                child: new TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: _textController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isWritting = messageText.length > 0;
                    });
                  },
                  onSubmitted: _sendText,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: messageBar(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _sendText(String text) async {
    _textController.clear();
    // List usersId = widget.usersId;
    // String receiverUserId;
    // for (int i = 0; i < usersId.length; i++) {
    //   if (usersId[i] != Constants.myDocId) {
    //     receiverUserId = usersId[i];
    //   }
    // }
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('hh:mm:a').format(now);
    String formattedDate = formatter.format(now);
    bool seen = false;
    db.collection("SavedMessages").document(widget.chatRoomId).updateData(
        {"last_msg": text, "timestamp": FieldValue.serverTimestamp()});
    chatReference.add({
      'message': text,
      "video": '',
      "file": '',
      'sender_email': Constants.myEmail,
      'sendBy': Constants.myName,
      // "receiverUserId": receiverUserId,
      'profile_photo': Constants.myProfileImage,
      'image': '',
      'timestamp': FieldValue.serverTimestamp(),
      'timeInNumber': DateTime.now().millisecondsSinceEpoch,
      'time': formattedTime.toString(),
      'date': formattedDate.toString(),
      'seen': seen
    }).then((documentReference) {
      setState(() {
        _isWritting = false;
      });
    }).catchError((e) {});
  }

  void _sendImage({String messageText, String imageUrl}) {
    // List usersId = widget.usersId;
    // String receiverUserId;
    // for (int i = 0; i < usersId.length; i++) {
    //   if (usersId[i] != Constants.myDocId) {
    //     receiverUserId = usersId[i];
    //   }
    // }
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('hh:mm:a').format(now);
    String formattedDate = formatter.format(now);
    bool seen = false;
    chatReference.add({
      'message': messageText,
      "video": '',
      "file": '',
      'image': imageUrl,
      'sender_email': Constants.myEmail,
      'sendBy': Constants.myName,
      // "receiverUserId": receiverUserId,
      'profile_photo': Constants.myProfileImage,
      'timestamp': FieldValue.serverTimestamp(),
      'timeInNumber': DateTime.now().millisecondsSinceEpoch,
      'time': formattedTime.toString(),
      'date': formattedDate.toString(),
      'seen': seen
    });
  }

  void saveVideoToDatabase(url) {
    // List usersId = widget.usersId;
    // String receiveruserId;
    // for (int i = 0; i < usersId.length; i++) {
    //   if (usersId[i] != Constants.myDocId) {
    //     receiveruserId = usersId[i];
    //   }
    // }
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('hh:mm:a').format(now);
    String formattedDate = formatter.format(now);
    bool seen = false;
    chatReference.add({
      'message': '',
      "video": url,
      "file": '',
      'sender_email': Constants.myEmail,
      'sendBy': Constants.myName,
      // "receiveruserId": receiveruserId,
      'profile_photo': Constants.myProfileImage,
      'image': '',
      'timestamp': FieldValue.serverTimestamp(),
      'timeInNumber': DateTime.now().millisecondsSinceEpoch,
      'time': formattedTime.toString(),
      'date': formattedDate.toString(),
      'seen': seen
    });
  }

  void saveFileToDatabase(url) {
    // List usersId = widget.usersId;
    // String receiverUserId;
    // for (int i = 0; i < usersId.length; i++) {
    //   if (usersId[i] != Constants.myDocId) {
    //     receiverUserId = usersId[i];
    //   }
    // }
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('hh:mm:a').format(now);
    String formattedDate = formatter.format(now);
    bool seen = false;
    chatReference.add({
      'message': '',
      "video": '',
      "file": url,
      'sender_email': Constants.myEmail,
      'sendBy': Constants.myName,
      // "receiverUserId": receiverUserId,
      'profile_photo': Constants.myProfileImage,
      'image': '',
      'timestamp': FieldValue.serverTimestamp(),
      'timeInNumber': DateTime.now().millisecondsSinceEpoch,
      'time': formattedTime.toString(),
      'date': formattedDate.toString(),
      'seen': seen
    });
  }
}

class DetailScreen extends StatelessWidget {
  final String image;
  DetailScreen({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
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
