import 'package:chat_app/providers/authentication_provider.dart';
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
                return ListTile(
                  title: Text(provider.users[index].name),
                  subtitle: Text(provider.users[index].phoneNumber),
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
