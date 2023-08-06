import 'package:chat_app/providers/authentication_provider.dart';
import 'package:chat_app/views/chat_screen_page/chat_screen_page_widget.dart';
import 'package:chat_app/views/home_page/home_page_widgets/chat_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageScreenWidget extends StatefulWidget {
  const HomePageScreenWidget({super.key});

  @override
  State<HomePageScreenWidget> createState() => _HomePageScreenWidgetState();
}

class _HomePageScreenWidgetState extends State<HomePageScreenWidget> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthenticationProvier>(context, listen: false).loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Consumer<AuthenticationProvier>(
        builder: (context, provider, child) {
          return ListView.separated(
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
                return const Divider(
                  thickness: 2,
                );
              },
              itemCount: provider.users.length);
        },
      ),
    );
  }
}
