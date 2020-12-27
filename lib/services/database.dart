import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUser(userData, userId) async {
    Firestore.instance
        .collection("Users")
        .document(userId)
        .setData(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("Users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  instantSearch(String searchField) {
    return Firestore.instance
        .collection('Users')
        .where('username',
            isGreaterThanOrEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  getMyAllChats(String userId) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .where("usersId", arrayContains: userId)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  getReceiverData(String receiverUserId) async {
    return await Firestore.instance
        .collection("Users")
        .where("userId", isEqualTo: receiverUserId)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
    ;
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }
}
