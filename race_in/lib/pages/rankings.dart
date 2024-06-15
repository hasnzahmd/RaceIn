import 'package:flutter/material.dart';
import 'package:race_in/constants/custom_colors.dart';
import './screens/teams_rankings.dart';
import './screens/drivers_rankings.dart';
import '../data/data_service.dart';

class RankingsPage extends StatefulWidget {
  @override
  _RankingsPageState createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage>
    with SingleTickerProviderStateMixin {
  final DataService _dataService = DataService();
  TabController? _tabController;
  String selectedSeason = '2024';
  List<String> seasons = List.generate(8, (index) => (2024 - index).toString());
  List<Map<String, dynamic>> teamsRankings = [];
  List<Map<String, dynamic>> driversRankings = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchRankings();
  }

  Future<void> _fetchRankings() async {
    final teamsData = await _dataService.getTeamsRankings(selectedSeason);
    final driversData = await _dataService.getDriversRankings(selectedSeason);
    setState(() {
      teamsRankings = teamsData;
      driversRankings = driversData;
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 8),
          child: Image.asset(
            'assets/images/f1w.png',
          ),
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
                  _fetchRankings();
                });
              },
              items: seasons.map<DropdownMenuItem<String>>((String season) {
                return DropdownMenuItem<String>(
                  value: season,
                  child: Text(season,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700)),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.settings, size: 25, color: Colors.white),
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
                DriversRankingPage(drivers: driversRankings),
                TeamsRankingPage(teams: teamsRankings),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
