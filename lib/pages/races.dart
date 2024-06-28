import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/custom_colors.dart';
import '../data/data_notifier.dart';
import '../components/custom_app_bar.dart';
import 'screens/races_list.dart';

class Races extends StatelessWidget {
  const Races({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Races'),
        body: Column(
          children: [
            const TabBar(
              indicatorColor: CustomColors.f1red,
              labelColor: CustomColors.f1red,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
              ],
            ),
            Expanded(
              child: Consumer<DataNotifier>(
                  builder: (context, dataNotifier, child) {
                if (dataNotifier.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final races = dataNotifier.getData('races');
                  if (races.isEmpty) {
                    return const Center(child: Text('No races found.'));
                  }

                  final upcomingRaces = races
                      .where((race) => race['status'] == 'Scheduled')
                      .toList();
                  final completedRaces = races
                      .where((race) => race['status'] == 'Completed')
                      .toList()
                      .reversed
                      .toList();

                  return TabBarView(
                    children: [
                      RacesList(
                          races: upcomingRaces,
                          startIndex: completedRaces.length + 1),
                      RacesList(
                          races: completedRaces,
                          startIndex: completedRaces.length),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
