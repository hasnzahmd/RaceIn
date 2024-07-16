import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../components/custom_app_bar.dart';
import '../constants/custom_colors.dart';
import '../data/data_notifier.dart';
import '../notifiers/rankings_notifier.dart';
import '../notifiers/sort_notifier.dart';
import 'latest.dart';
import 'teams.dart';
import 'races.dart';
import 'drivers.dart';
import 'rankings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> pages = [
    const Latest(),
    const Races(),
    const Teams(),
    const DriversPage(),
    const RankingsPage(),
  ];

  final List<String> pageTitles = [
    'Latest',
    'Races',
    'Teams',
    'Drivers',
    'Rankings',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RankingsNotifier()),
        ChangeNotifierProvider(create: (_) => SortNotifier()),
      ],
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Consumer<DataNotifier>(
            builder: (context, dataNotifier, child) {
              return CustomAppBar(
                selectedIndex: selectedIndex,
                title: pageTitles[selectedIndex],
              );
            },
          ),
        ),
        body: Consumer<DataNotifier>(
          builder: (context, dataNotifier, child) {
            if (dataNotifier.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: pages,
              );
            }
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: selectedIndex,
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
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
