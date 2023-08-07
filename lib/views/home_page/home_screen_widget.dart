import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/services/firebase_manager.dart';
import 'package:chat_app/utils/common_functions.dart';
import 'package:chat_app/utils/media_query.dart';
import 'package:chat_app/views/chat_screen_page/chat_screen_page_widget.dart';
import 'package:chat_app/views/home_page/home_page_widgets/chat_tile_view.dart';
import 'package:chat_app/views/home_page/home_page_widgets/custom_home_page_app_bar.dart';
import 'package:chat_app/widgets/custom_sized_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_assets.dart';

class HomePageScreenWidget extends StatefulWidget {
  const HomePageScreenWidget({super.key});

  @override
  State<HomePageScreenWidget> createState() => _HomePageScreenWidgetState();
}

class _HomePageScreenWidgetState extends State<HomePageScreenWidget>
    with WidgetsBindingObserver {
  final int _currentIndex = 1;
  @override
  void initState() {
    Provider.of<AuthenticationProvier>(context, listen: false).loadUserData();
    WidgetsBinding.instance.addObserver(this);
    setStatus(true);
    super.initState();
  }

  void setStatus(bool sataus) async {
    print("User is : ${FirebaseManager.firebaseAuth.currentUser!.uid}");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseManager.firebaseAuth.currentUser!.uid)
        .update({"isOnline": sataus});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus(true);
      AppCommonFunctions.showToast("Hello", context);
    } else {
      setStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        automaticallyImplyLeading: false,
        flexibleSpace: const SafeArea(child: CustomHomePageAppBar()),
      ),
      body: Consumer<AuthenticationProvier>(
        builder: (context, provider, child) {
          return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              itemBuilder: (context, index) {
                return ChatListTileView(
                  user: provider.users[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreenPageWidged(
                                  reciverUser: provider.users[index],
                                )));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const CustomSizedBox(
                  height: 1,
                );
              },
              itemCount: provider.users.length);
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        height: GetScreenSize.getScreenHeight(context) * 0.1,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            selectedFontSize: 12.0,
            unselectedFontSize: 10.0,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.deepPurple,
            elevation: 0,
            // Transparent splash color
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.globe,
                  height: 30,
                  color: _currentIndex == 0
                      ? Colors.deepPurple
                      : Colors.grey, // Set the default icon color
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.chat,
                  height: 30,
                  color: _currentIndex == 1 ? Colors.deepPurple : Colors.grey,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.telephone,
                  height: 30,
                  color: _currentIndex == 2 ? Colors.deepPurple : Colors.grey,
                ),
                label: "",
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                label: "",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
