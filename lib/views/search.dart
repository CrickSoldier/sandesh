import 'package:Sandesh/views/showProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Sandesh/services/database.dart';
// import 'package:Sandesh/views/showProfilePage.dart';

class InstantSearch extends StatefulWidget {
  @override
  _InstantSearchState createState() => _InstantSearchState();
}

class _InstantSearchState extends State<InstantSearch> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    if (queryResultSet.length == 0 && value.length == 1) {
      databaseMethods.instantSearch(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
          setState(() {
            tempSearchStore.add(queryResultSet[i]);
          });
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].toLowerCase().contains(value.toLowerCase()) ==
            true) {
          if (element['name'].toLowerCase().indexOf(value.toLowerCase()) == 0) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        }
      });
    }
    if (tempSearchStore.length == 0 && value.length > 1) {
      setState(() {});
    }
  }

  showProfile(Map data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowProfile(
                name: data['name'],
                username: data['username'],
                email: data['email'],
                phoneNumber: data['phoneNumber'],
                profileImage: data['profileImage'],
                profileBio: data['profileBio'],
                uId: data['userId'])));
  }

  Widget buildResultCard(Map data) {
    return Container(
        width: double.infinity,
        child: Column(children: <Widget>[
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 2.0,
              child: Column(children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            data['profileImage'],
                          )),
                    ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          data['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    ]),
                SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "Show Profile",
                        textAlign: TextAlign.center,
                      )),
                      IconButton(
                        icon: Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        onPressed: () => showProfile(data),
                      ),
                    ]),
              ])),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (val) {
            initiateSearch(val);
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 25.0),
              hintText: 'Search by Username',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
        ),
      ),
      SizedBox(height: 10.0),
      GridView.count(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          primary: false,
          shrinkWrap: true,
          children: tempSearchStore.map((element) {
            return buildResultCard(element);
          }).toList())
    ]));
  }
}
