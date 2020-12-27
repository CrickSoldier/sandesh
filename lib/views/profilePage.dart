import 'dart:io';
import 'package:Sandesh/views/editProfile.dart';
import 'package:Sandesh/views/homePage.dart';
import 'package:Sandesh/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:Sandesh/helper/constants.dart';
// import 'package:leadindia/views/editProfilePage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:Sandesh/helper/helperfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sandesh/services/database.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:geolocator/geolocator.dart';

class ProfilePageView extends StatefulWidget {
  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String url;

  void getImage() async {
    // var firebaseUser = await FirebaseAuth.instance.currentUser();
    String email = Constants.myEmail;
    int timestamp = new DateTime.now().millisecondsSinceEpoch;

    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storageReference = FirebaseStorage.instance.ref().child(
        '$email Storage Data/Profile images/avatar_' +
            timestamp.toString() +
            '.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    url = imageUrl.toString();

    print("Image Url = $url");

    QuerySnapshot userInfoSnapshot =
        await databaseMethods.getUserInfo(Constants.myEmail);
    String docId = userInfoSnapshot.documents[0].documentID;

    print("DOCUMENT ID IS $docId");
    await Firestore.instance
        .collection('Users')
        .document(docId)
        .updateData({'profileImage': url});
    Constants.myProfileImage = url;
    HelperFunctions.saveUserAvatarSharedPreference(url);
    setState(() {});
  }

  // getUserCurrentLocation() async {
  //   Position position = await Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   List<Placemark> placeMarks = await Geolocator()
  //       .placemarkFromCoordinates(position.latitude, position.longitude);
  //   Placemark mPlaceMark = placeMarks[0];
  //   String completeAddressInfo =
  //       '${mPlaceMark.subThoroughfare} ${mPlaceMark.thoroughfare}, ${mPlaceMark.subLocality} ${mPlaceMark.locality}, ${mPlaceMark.subAdministrativeArea} ${mPlaceMark.administrativeArea}, ${mPlaceMark.postalCode} ${mPlaceMark.country}';
  //   String specificAddress = '${mPlaceMark.locality}, ${mPlaceMark.country}';
  //   QuerySnapshot userInfoSnapshot =
  //       await databaseMethods.getUserInfo(Constants.myEmail);
  //   String docId = userInfoSnapshot.documents[0].documentID;
  //   await Firestore.instance
  //       .collection('Users')
  //       .document(docId)
  //       .updateData({'currentLocation': completeAddressInfo});
  //   Constants.myCurrentLocation = completeAddressInfo;
  //   HelperFunctions.saveUserLocationSharedPreference(completeAddressInfo);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.edit),
          onPressed: () async {
            var navigationResult = await Navigator.push((context),
                new MaterialPageRoute(builder: (context) => EditProfile()));

            if (navigationResult == true) {
              setState(() {});
            }
          },
        ),
        appBar: AppBar(
            title: Text("Sandesh"),
            backgroundColor: Colors.orangeAccent,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            elevation: 10.0,
            centerTitle: true),
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
                                    Text(Constants.myName,
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
                                                child: Text(Constants.myEmail,
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
                                              Text(Constants.myPhoneNumber,
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
                                              Text(Constants.myUserName,
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
                                                  image:
                                                      Constants.myProfileImage,
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
                                                Constants.myProfileImage),
                                            fit: BoxFit.cover)),
                                    child: Stack(
                                        alignment: Alignment.topCenter,
                                        overflow: Overflow.visible,
                                        children: [
                                          Positioned(
                                              bottom: -5.0,
                                              right: -2.0,
                                              child: GestureDetector(
                                                onTap: getImage,
                                                child: Container(
                                                  height: 32,
                                                  width: 32,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff1D3C51),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.6),
                                                        blurRadius: 30,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                  ),
                                                  child: Icon(
                                                    Icons.camera_enhance,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ))
                                        ]),
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
                                Text(Constants.myBio,
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
                      // SizedBox(height: 10),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     Icon(
                      //       Icons.add_location,
                      //       color: Colors.blue,
                      //     ),
                      //     SizedBox(width: 15),
                      //     Expanded(
                      //       child: new Column(
                      //         mainAxisSize: MainAxisSize.max,
                      //         children: <Widget>[
                      //           Text(Constants.myCurrentLocation,
                      //               style: TextStyle(
                      //                 color: Colors.grey[800],
                      //                 height: 1.4,
                      //               )),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // Container(
                      //   width: 220.0,
                      //   height: 110.0,
                      //   alignment: Alignment.center,
                      //   child: RaisedButton.icon(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(45.0),
                      //     ),
                      //     color: Colors.green,
                      //     onPressed: getUserCurrentLocation,
                      //     icon: Icon(
                      //       Icons.location_on,
                      //       color: Colors.white,
                      //     ),
                      //     label: Text(
                      //       "Update Your Location",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
