import 'package:flutter/material.dart';
//import 'package:race_in/constants/teams_colors.dart';

class TeamsRankingPage extends StatelessWidget {
  final List<Map<String, dynamic>> teams;

  TeamsRankingPage({required this.teams});

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
