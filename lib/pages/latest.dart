import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;

          // final currentYear = DateTime.now().year;
          // final races = dataNotifier.getData('races');
          // final races2 = dataNotifier.getData('races2');
          final newsData = dataNotifier.getData('news');
          // final topDrivers = dataNotifier
          //     .getData('driversRanking_$currentYear')
          //     .take(3)
          //     .toList();

          // List topDriverDetails = [];
          // for (var driver in driverDetails) {
          //   for (var topDriver in topDrivers) {
          //     if (driver['name'] == topDriver['driver']['name']) {
          //       topDriverDetails.add({
          //         'name': topDriver['driver']['name'],
          //         'url': driver['url'],
          //         'points': topDriver['points'] ?? 0
          //       });
          //     }
          //   }
          // }
          // topDriverDetails.sort((a, b) => b['points'].compareTo(a['points']));

          // if (races.isEmpty) {
          //   return const Center(child: Text('No races found.'));
          // }
          // for (var i = 0; i < races.length; i++) {
          //   races[i]['competition']['name'] = races2[i]['value']['gPrx'];
          // }

          // var raceIndex = races.indexWhere((race) {
          //   return race['status'] == 'Scheduled';
          // });
          // var comingRace = races[raceIndex];

          return ListView.builder(
            itemCount: newsData.length,
            itemBuilder: (context, index) {
              final news = newsData[index];
              final imageUrl = news['images'][0]['url'];
              final imgCaption = news['images'][0]['caption'];
              return Card(
                margin: const EdgeInsets.only(
                  top: 2,
                  bottom: 5,
                  right: 3,
                ),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CustomColors.f1red.withOpacity(0.5),
                          width: 3,
                        ),
                        bottom: BorderSide(
                          color: CustomColors.f1red.withOpacity(0.5),
                          width: 3,
                        ),
                        right: BorderSide(
                          color: CustomColors.f1red.withOpacity(0.5),
                          width: 3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: screenHeight * 0.24,
                        width: screenWidth,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      if (imgCaption != null)
                        Container(
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.1),
                          padding: const EdgeInsets.fromLTRB(10, 2, 5, 2),
                          child: Text(
                            imgCaption,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              '${news['headline']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.f1red,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              news['description'],
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [
                                Text('Read More',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColors.f1red,
                                    )),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 13,
                                  color: CustomColors.f1red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          // return SingleChildScrollView(
          //   child: Container(
          //     color: Colors.grey.withOpacity(0.1),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
          //           child: const Text(
          //             'Next Race',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: CustomColors.f1red,
          //             ),
          //           ),
          //         ),
          //         ComingRaceCard(race: comingRace, round: raceIndex + 1),
          //         Container(
          //           padding: const EdgeInsets.fromLTRB(10, 3, 0, 10),
          //           child: const Text(
          //             'Leaderboard',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: CustomColors.f1red,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding:
          //               const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               for (var driver in topDriverDetails)
          //                 Column(
          //                   children: [
          //                     CircleAvatar(
          //                       radius: 45,
          //                       backgroundColor:
          //                           const Color(0xFF073153).withOpacity(0.12),
          //                       backgroundImage: CachedNetworkImageProvider(
          //                         driver['url'],
          //                       ),
          //                     ),
          //                     const SizedBox(height: 5),
          //                     Text(
          //                       driver['name'],
          //                       style: const TextStyle(
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.bold,
          //                         color: Color(0xFF073153),
          //                       ),
          //                     ),
          //                     Row(
          //                       children: [
          //                         Text(
          //                           '${driver['points']} ',
          //                           style: const TextStyle(
          //                               fontSize: 14,
          //                               fontWeight: FontWeight.w600,
          //                               color: Color(0xFF073153)),
          //                         ),
          //                         const Text(
          //                           'PTS',
          //                           style: TextStyle(
          //                               fontSize: 12,
          //                               fontWeight: FontWeight.w600,
          //                               color: Color(0xFF073153)),
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          //           child: const Text(
          //             'Top Stories',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: CustomColors.f1red,
          //             ),
          //           ),
          //         ),
          //         Card(
          //           margin: const EdgeInsets.all(10),
          //           child: Column(
          //             children: [
          //               for (var news in newsData)
          //                 ListTile(
          //                   contentPadding: const EdgeInsets.all(10),
          //                   title: Text(
          //                     news['headline'],
          //                     style: const TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                       color: CustomColors.f1red,
          //                     ),
          //                   ),
          //                   subtitle: Text(
          //                     news['description'],
          //                     style: const TextStyle(
          //                       fontSize: 14,
          //                       color: Colors.black,
          //                     ),
          //                   ),
          //                 ),
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // );
        }
      }),
    );
  }
}
