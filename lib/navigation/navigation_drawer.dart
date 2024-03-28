//keeping the below file link in case the widget link breaks and the below does actually need to be there
//import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/navigation/build_menu_items.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(children: [
            const SizedBox(height: 50),
              Card(
                elevation: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90)),
                child: Image.asset(
                  'assets/diamond_hands_logo.png',
                  height: 115,
                  width: 115,
                ),
              ),
          ]),
          buildMenuItems(context)
        ],
      ),
    ));
  }
}
