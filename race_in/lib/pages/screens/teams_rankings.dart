import 'package:flutter/material.dart';
//import 'package:race_in/constants/teams_colors.dart';
import '../../data/data_notifier.dart';

class TeamsRankingPage extends StatelessWidget {
  final List<Map<String, dynamic>> teams;
  final DataNotifier dataNotifier;

  TeamsRankingPage({required this.teams, required this.dataNotifier});

  @override
  Widget build(BuildContext context) {
    return teams.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              return Card(
                child: ListTile(
                  title: Text(team['team']['name']),
                  subtitle: Text('Points: ${team['points']}'),
                ),
              );
            },
          );
  }
}
