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

          String dateTimeISO = race['date'];
          DateTime utcDateTime = DateTime.parse(dateTimeISO);
          DateTime localDateTime = utcDateTime.toLocal();
          DateFormat dayFormat = DateFormat('EEE');
          DateFormat dateFormat = DateFormat('MMM d');
          DateFormat timeFormat = DateFormat('h:mm a');

          String day = dayFormat.format(localDateTime);
          String date = dateFormat.format(localDateTime);
          String time = timeFormat.format(localDateTime);

          String competition = race['competition']['name'];
          String raceCountry = race['competition']['location']['country'];
          String countryCode = '';
          for (var country in f1Countries) {
            if (country['name'] == raceCountry) {
              countryCode = country['code'];
              break;
            }
          }

          var round = 0;
          if (race['status'] == 'Completed') {
            round = startIndex - index;
          } else {
            round = startIndex + index;
          }

          final bool comingRace =
              (index == 0) && (race['status'] == 'Scheduled');

          return comingRace
              ? ComingRaceCard(race: race, round: round)
              : Card(
                  margin: const EdgeInsets.only(
                      bottom: 2, top: 2, left: 3, right: 3),
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColors.f1red.withOpacity(0.2),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                day,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                date,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                time,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Round $round',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.f1red),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        raceCountry,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    competition,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    'https://flagsapi.com/$countryCode/shiny/64.png',
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
        });
  }
}
