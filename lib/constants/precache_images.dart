import 'package:flutter/material.dart';

Future<void> precacheTeamLogos(
    BuildContext context, List<Map<String, dynamic>> teams) async {
  for (var team in teams) {
    if (team['logo'] != null) {
      await precacheImage(NetworkImage(team['logo']), context);
    }
  }
}

// Future<void> precacheDriverImages(BuildContext context, List imageUrls) async {
//   for (String url in imageUrls) {
//     await precacheImage(NetworkImage(url), context);
//   }
// }
