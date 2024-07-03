import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_in/constants/custom_colors.dart';
import './screens/teams_rankings.dart';
import './screens/drivers_rankings.dart';
import '../data/data_notifier.dart';
import '../notifiers/rankings_notifier.dart';

class RankingsPage extends StatefulWidget {
  const RankingsPage({super.key});

  @override
  _RankingsPageState createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RankingsNotifier>(
      builder: (context, rankingsNotifier, child) {
        final dataNotifier = Provider.of<DataNotifier>(context);
        final teamsRankings = dataNotifier
            .getData('teamsRanking_${rankingsNotifier.selectedSeason}');
        final driversRankings = dataNotifier
            .getData('driversRanking_${rankingsNotifier.selectedSeason}');

        return Scaffold(
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
      },
    );
  }
}
