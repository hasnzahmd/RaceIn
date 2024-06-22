import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_in/constants/custom_colors.dart';
import './screens/teams_rankings.dart';
import './screens/drivers_rankings.dart';
import '../data/data_notifier.dart';

class RankingsPage extends StatefulWidget {
  @override
  _RankingsPageState createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int currentYear;
  late String selectedSeason;
  late List<String> seasons;

  @override
  void initState() {
    super.initState();
    currentYear = DateTime.now().year;
    selectedSeason = currentYear.toString();
    seasons = List.generate(
        currentYear - 2016, (index) => (currentYear - index).toString());

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataNotifier = Provider.of<DataNotifier>(context);
    final teamsRankings = dataNotifier.getData('teamsRanking_$selectedSeason');
    final driversRankings =
        dataNotifier.getData('driversRanking_$selectedSeason');

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Image.asset('assets/images/f1w.png'),
        ),
        title: const Text('Rankings'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedSeason,
              dropdownColor: CustomColors.f1red,
              onChanged: (value) {
                setState(() {
                  selectedSeason = value!;
                });
              },
              items: seasons.map<DropdownMenuItem<String>>((String season) {
                return DropdownMenuItem<String>(
                  value: season,
                  child: Text(
                    season,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded, size: 30, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: CustomColors.f1red,
            labelColor: CustomColors.f1red,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
            tabs: const [
              Tab(text: 'Drivers'),
              Tab(text: 'Teams'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DriversRankingPage(
                  drivers: driversRankings,
                  dataNotifier: dataNotifier,
                ),
                TeamsRankingPage(
                    teams: teamsRankings, dataNotifier: dataNotifier),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
