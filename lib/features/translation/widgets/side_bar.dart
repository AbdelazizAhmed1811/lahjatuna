import 'package:flutter/material.dart';
import 'package:lahjatuna/themes/colors.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
              decoration: BoxDecoration(
                color: ColorsManager.dartBlue,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png"),
              )),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text("Select Language"),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Select Language Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Translation History"),
            onTap: () {
              Navigator.pop(context);
              // Navigate to History Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Settings Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help & Support"),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Help Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pop(context);
              // Perform Logout
            },
          ),
        ],
      ),
    );
  }
}
