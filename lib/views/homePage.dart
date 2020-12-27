import 'package:Sandesh/helper/constants.dart';
import 'package:Sandesh/helper/helperfunctions.dart';
import 'package:Sandesh/views/messagePage.dart';
// import 'package:Sandesh/views/messagePagee.dart';
import 'package:Sandesh/views/search.dart';
import 'package:Sandesh/widgets/appBar.dart';
import 'package:Sandesh/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:Sandesh/services/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  PageController pageController = new PageController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  int getPageIndex = 0;

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    setState(() {
      isLoading = true;
    });
    Constants.myUserName = await HelperFunctions.getUserNameSharedPreference();
    Constants.myName = await HelperFunctions.getNameSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    Constants.myProfileImage =
        await HelperFunctions.getUserAvatarSharedPreference();
    Constants.myPhoneNumber =
        await HelperFunctions.getUserPhoneNoSharedPreference();
    Constants.myBio = await HelperFunctions.getUserBioSharedPreference();
    Constants.myCurrentLocation =
        await HelperFunctions.getUserLocationSharedPreference();
    Constants.myUserId = await HelperFunctions.getUserUuidSharedPreference();

    setState(() {
      isLoading = false;
    });
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return buildHomeScreen();
  }

  Scaffold buildHomeScreen() {
    return Scaffold(
      appBar: appBarMain(context),
      drawer: DrawerMain(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : PageView(
              children: <Widget>[
                MessagePage(),
                InstantSearch(),
              ],
              controller: pageController,
              onPageChanged: whenPageChanges,
              physics: NeverScrollableScrollPhysics(),
            ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.green),
        child: BottomNavigationBar(
          currentIndex: getPageIndex,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Chats'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Search')),
          ],
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orangeAccent,
          showUnselectedLabels: true,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: onTapChangePage,
        ),
      ),
    );
  }
}
