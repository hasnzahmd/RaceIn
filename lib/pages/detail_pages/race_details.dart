import 'package:flutter/material.dart';

class RaceDetails extends StatelessWidget {
  final Map<String, dynamic> race;

  const RaceDetails({super.key, required this.race});

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
            Text('Date: ${race['date']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
                'Location: ${race['circuit']['location']['city']}, ${race['circuit']['location']['country']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Circuit: ${race['circuit']['name']}',
                style: const TextStyle(fontSize: 18)),
            // Add more race details here
          ],
        ),
      ),
    );
  }
}
