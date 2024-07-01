import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:race_in/constants/clean_team_name.dart';
import 'package:race_in/constants/teams_colors.dart';
import '../../data/data_notifier.dart';

class DriversRankingPage extends StatelessWidget {
  final List<Map<String, dynamic>> drivers;
  final DataNotifier dataNotifier;

  const DriversRankingPage(
      {super.key, required this.drivers, required this.dataNotifier});

  @override
  Widget build(BuildContext context) {
    return drivers.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driversAll = dataNotifier.getData('drivers');
              final driver = drivers[index];
              final name = driver['driver']['name'];
              final id = driver['driver']['id'];
              int teamId =
                  driver['team']['id'] == 8 ? 18 : driver['team']['id'];
              var teamColor = getTeamColor(teamId);
              final teamName = cleanTeamName(driver['team']['name']);
              if (teamName == 'Force India') teamColor = '0xFFFF8000';
              final points = driver['points'] ?? 0;

              String countryCode = '';
              for (var eachDriver in driversAll) {
                if (eachDriver['data'][0]['id'] == id) {
                  countryCode =
                      eachDriver['data'][0]['country']['code'].toString();
                  break;
                }
              }
              return Card(
                margin:
                    const EdgeInsets.only(bottom: 2, top: 2, left: 3, right: 3),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(int.parse(teamColor)).withOpacity(0.6),
                      width: 1.5,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        countryCode == ''
                            ? const SizedBox()
                            : CachedNetworkImage(
                                imageUrl:
                                    'https://flagsapi.com/$countryCode/shiny/64.png',
                                height: 30,
                                width: 30,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                        countryCode == ''
                            ? const SizedBox()
                            : const SizedBox(width: 10),
                        Text(
                          teamName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 7),
                      ],
                    ),
                    leading: Text(
                      '${index + 1}.',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$points',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Text(
                          'PTS',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
