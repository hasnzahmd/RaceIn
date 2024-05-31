import 'package:flutter/material.dart';

class TeamStandingDetails extends StatelessWidget {
  final String season;
  final Map<String, dynamic> teamRankingData;

  TeamStandingDetails({required this.season, required this.teamRankingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Ranking Details - $season')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Season: $season'),
            Text('Team: ${teamRankingData['team'] ?? 'N/A'}'),
            Text('Points: ${teamRankingData['points'] ?? 'N/A'}'),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
