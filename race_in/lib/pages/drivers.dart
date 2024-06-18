import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../components/custom_app_bar.dart';
import '../components/glowing_dot.dart';
import '../data/data_notifier.dart';
import '../constants/driver_details.dart';
import '../constants/team_details.dart';
import '../constants/teams_colors.dart';

class DriversPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Drivers'),
      body: Consumer<DataNotifier>(
        builder: (context, dataNotifier, child) {
          if (dataNotifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final drivers = dataNotifier.getData('drivers');
            if (drivers.isEmpty) {
              return const Center(child: Text('No drivers found'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 160,
                mainAxisSpacing: 3.0,
              ),
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers[index]['data'][0];
                final driverName = driver['name'] == 'Carlos Sainz Jr'
                    ? 'Carlos Sainz'
                    : driver['name'];

                int teamId = driver['teams'][0]['team']['id'];
                if (teamId == 8) teamId = 18;

                String teamName = '';
                for (var team in teamDetails) {
                  if (team['id'] == teamId) {
                    teamName = team['name'];
                    break;
                  }
                }

                String imageUrl = '';
                for (var driverDetail in driverDetails) {
                  if (driverDetail['name'] == driverName) {
                    imageUrl = driverDetail['url'];
                    break;
                  }
                }

                var teamColor = getTeamColor(teamId);

                var driverNumber = driver['number'] ?? '38';

                return Card(
                  margin: const EdgeInsets.only(
                    top: 2,
                    left: 3,
                    right: 3,
                  ),
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(int.parse(teamColor)),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                driverName,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    teamName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GlowingDot(dotColor: teamColor)
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        'https://flagsapi.com/${driver['country']['code']}/shiny/64.png',
                                    height: 50,
                                    width: 50,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  const SizedBox(width: 80),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: 100,
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
                                        colors: [
                                          Color(int.parse(teamColor))
                                              .withOpacity(0.9),
                                          Color(int.parse(teamColor))
                                              .withOpacity(0.2),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(Rect.fromLTWH(0, 0,
                                              bounds.width, bounds.height)),
                                      child: Text(
                                        '$driverNumber',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                          height: 150,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.person_rounded, size: 50);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
