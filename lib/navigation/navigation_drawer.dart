import 'package:diamond_hands_crypto_tracker/navigation/build_menu_items.dart';
import 'package:diamond_hands_crypto_tracker/themes/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  
  bool? isOn;

  @override
  void initState() {
    super.initState();
    restorePersistedPreference();
  }

  void restorePersistedPreference() async {
    var preferences = await SharedPreferences.getInstance();
    bool isOn = preferences.getBool('darkMode') ?? false;
    setState(() {
      this.isOn = isOn;
    }); 
  }

  void persistedPreference() {
    setState(() async {
      isOn = isOn;
      var preferences = await SharedPreferences.getInstance();
      preferences.setBool('darkMode', isOn!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(isOn!);
                      setState(() {
                        isOn == true
                            ? isOn = false
                            : isOn = true;
                      });
                    },
                    icon: isOn == true
                        ? const Icon(Icons.light_mode_rounded)
                        : const Icon(Icons.dark_mode_rounded)),
              ],
            ),
            //SizedBox(height: 50),
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
    )));
  }
}
