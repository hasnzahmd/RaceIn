import 'package:flutter/material.dart';

class DriverDetailsPage extends StatelessWidget {
  final Map<String, dynamic> driverData;

  DriverDetailsPage({required this.driverData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(driverData['name'] ?? 'Driver Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${driverData['name'] ?? 'N/A'}'),
            Text('Team: ${driverData['team'] ?? 'N/A'}'),
            Text('Points: ${driverData['points'] ?? 'N/A'}'),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
