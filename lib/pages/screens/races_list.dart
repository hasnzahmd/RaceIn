import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../constants/custom_colors.dart';
import '../../constants/f1_countries.dart';
import '../../components/coming_race_card.dart';

class RacesList extends StatelessWidget {
  final List races;
  final int startIndex;

  const RacesList({required this.races, required this.startIndex});

  @override
  Widget build(BuildContext context) {
    if (races.isEmpty) {
      return const Center(child: Text('No races found.'));
    }

    return ListView.builder(
      itemCount: races.length,
      itemBuilder: (context, index) {
        final race = races[index];
        final localDateTime = DateTime.parse(race['date']).toLocal();
        final day = DateFormat('EEE').format(localDateTime);
        final date = DateFormat('MMM d').format(localDateTime);
        final time = DateFormat('h:mm a').format(localDateTime);
        final raceCountry = race['competition']['location']['country'];
        final countryCode = _getCountryCode(raceCountry);
        raceCountry == 'United Arab Emirates' ? 'UAE' : raceCountry;

        final competition = race['competition']['name'];
        final round = race['status'] == 'Completed'
            ? startIndex - index
            : startIndex + index;
        final isComingRace = (index == 0) && (race['status'] == 'Scheduled');

        return isComingRace
            ? ComingRaceCard(race: race, round: round)
            : RaceCard(
                day: day,
                date: date,
                time: time,
                competition: competition,
                raceCountry: raceCountry,
                countryCode: countryCode,
                round: round,
              );
      },
    );
  }

  String _getCountryCode(String country) {
    for (var item in f1Countries) {
      if (item['name'] == country) {
        return item['code'];
      }
    }
    return '';
  }
}

class RaceCard extends StatelessWidget {
  final String day;
  final String date;
  final String time;
  final String competition;
  final String raceCountry;
  final String countryCode;
  final int round;

  const RaceCard({
    required this.day,
    required this.date,
    required this.time,
    required this.competition,
    required this.raceCountry,
    required this.countryCode,
    required this.round,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.f1red.withOpacity(0.2),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(day,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 1),
                  Text(date,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 1),
                  Text(time,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Round $round',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.f1red,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            raceCountry,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        competition,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  CachedNetworkImage(
                    imageUrl: 'https://flagsapi.com/$countryCode/shiny/64.png',
                    height: 40,
                    width: 40,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
