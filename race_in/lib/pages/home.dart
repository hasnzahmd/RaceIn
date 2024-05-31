import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:race_in/constants/colors.dart';
import 'package:race_in/pages/latest.dart';
import 'teams.dart';
import 'races.dart';
import 'drivers.dart';
import 'standings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    Latest(),
    Races(),
    Teams(),
    DriversPage(),
    Standings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: const <Widget>[
          FaIcon(
            FontAwesomeIcons.newspaper,
            color: Colors.white,
            size: 27,
          ),
          FaIcon(
            FontAwesomeIcons.flagCheckered,
            color: Colors.white,
          ),
          ImageIcon(
            AssetImage(
              'assets/images/cars.png',
            ),
            color: Colors.white,
            size: 30,
          ),
          ImageIcon(
            AssetImage(
              'assets/images/driver.png',
            ),
            color: Colors.white,
            size: 30,
          ),
          FaIcon(
            FontAwesomeIcons.trophy,
            color: Colors.white,
          ),
        ],
        height: 50,
        color: CustomColors.f1red,
        buttonBackgroundColor: CustomColors.f1red,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
