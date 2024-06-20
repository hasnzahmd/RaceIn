import 'package:flutter/material.dart';

class DriverStandingDetail extends StatelessWidget {
  final String season;
  final Map<String, dynamic> driverRankingData;

  DriverStandingDetail({required this.season, required this.driverRankingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Driver Ranking Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Season: $season'),
            Text('Driver: ${driverRankingData['driverName'] ?? 'N/A'}'),
            Text('Team: ${driverRankingData['team'] ?? 'N/A'}'),
            Text('Points: ${driverRankingData['points'] ?? 'N/A'}'),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
