import 'package:flutter/material.dart';

class RaceDetails extends StatelessWidget {
  final Map<String, dynamic> race;

  const RaceDetails({Key? key, required this.race}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(race['competition']['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${race['date']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
                'Location: ${race['circuit']['location']['city']}, ${race['circuit']['location']['country']}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Circuit: ${race['circuit']['name']}',
                style: TextStyle(fontSize: 18)),
            // Add more race details here
          ],
        ),
      ),
    );
  }
}
