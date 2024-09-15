import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:music_player/pages/settings.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // logo
          DrawerHeader(
              child: Icon(
            Iconsax.musicnote,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 40,
          )),
          // home tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Iconsax.home_2,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 20,
              ),
              title: Text(
                "HOME",
                style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    letterSpacing: 6),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
          // settings tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 0),
            child: ListTile(
              leading: Icon(
                Iconsax.setting_2,
                size: 20,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                "SETTINGS",
                style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    letterSpacing: 6),
              ),
              onTap: () {
                // pop the drawer
                Navigator.pop(context);
                // navigate to the settings page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
          )
        ],
      ),
    );
  }
}
