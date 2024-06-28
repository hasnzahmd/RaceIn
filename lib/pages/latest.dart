import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:race_in/components/coming_race_card.dart';
import 'package:race_in/constants/driver_details.dart';
import '../components/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../constants/custom_colors.dart';
import '../data/data_notifier.dart';

class Latest extends StatelessWidget {
  const Latest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Latest'),
      body: Consumer<DataNotifier>(builder: (context, dataNotifier, child) {
        if (dataNotifier.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final currentYear = DateTime.now().year;
          final races = dataNotifier.getData('races');
          final races2 = dataNotifier.getData('races2');
          final topDrivers = dataNotifier
              .getData('driversRanking_$currentYear')
              .take(3)
              .toList();

          List topDriverDetails = [];
          for (var driver in driverDetails) {
            for (var topDriver in topDrivers) {
              if (driver['name'] == topDriver['driver']['name']) {
                topDriverDetails.add({
                  'name': topDriver['driver']['name'],
                  'url': driver['url'],
                  'points': topDriver['points'] ?? 0
                });
              }
            }
          }
          topDriverDetails.sort((a, b) => b['points'].compareTo(a['points']));

          if (races.isEmpty) {
            return const Center(child: Text('No races found.'));
          }
          for (var i = 0; i < races.length; i++) {
            races[i]['competition']['name'] = races2[i]['value']['gPrx'];
          }

          var raceIndex = races.indexWhere((race) {
            return race['status'] == 'Scheduled';
          });
          var comingRace = races[raceIndex];

          return SingleChildScrollView(
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: const Text(
                      'Next Race',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.f1red,
                      ),
                    ),
                  ),
                  ComingRaceCard(race: comingRace, round: raceIndex + 1),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 3, 0, 10),
                    child: const Text(
                      'Top Drivers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.f1red,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (var driver in topDriverDetails)
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundColor:
                                    const Color(0xFF073153).withOpacity(0.12),
                                backgroundImage: CachedNetworkImageProvider(
                                  driver['url'],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                driver['name'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF073153),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${driver['points']} ',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF073153)),
                                  ),
                                  const Text(
                                    'PTS',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF073153)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: const Text(
                      'Latest News',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.f1red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
