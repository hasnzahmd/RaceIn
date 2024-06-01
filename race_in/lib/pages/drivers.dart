import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import '../components/custom_app_bar.dart';
import '../components/glowing_dot.dart';
import '../data/data_service.dart';
import '../constants/driver_details.dart';
import '../constants/team_details.dart';

class DriversPage extends StatefulWidget {
  @override
  _DriversPageState createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  final DataService _dataService = DataService();
  Future<List<Map<String, dynamic>>>? _driversFuture;

  @override
  void initState() {
    super.initState();
    _driversFuture = _dataService.getAllDrivers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Drivers'),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _driversFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No drivers found'));
          } else {
            final drivers = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 160,
                mainAxisSpacing: 5.0,
              ),
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers[index]['data'][0];
                final driverName = driver['name'];

                int teamId = driver['teams'][0]['team']['id'];
                if (teamId == 8) teamId = 18;

                String teamName = '';
                for (var team in teamDetails) {
                  if (team['id'] == teamId) {
                    teamName = team['name'];
                  }
                }

                String imageUrl = '';
                for (var driverDetail in driverDetails) {
                  if (driverDetail['name'] == driverName) {
                    imageUrl = driverDetail['url'];
                  }
                }

                var teamColor = getTeamColor(teamId);

                return Card(
                  margin: const EdgeInsets.only(
                    top: 2,
                    left: 5,
                    right: 5,
                  ),
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(int.parse(teamColor)),
                          width: 2,
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
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 0.5),
                                    ),
                                  ],
                                ),
                                child: CountryFlag.fromCountryCode(
                                  driver['country']['code'],
                                  height: 40,
                                  width: 40,
                                ),
                              )
                            ],
                          ),
                        ),
                        Image.network(
                          imageUrl,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
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

  getTeamColor(teamId) {
    switch (teamId) {
      case 13:
        return teamDetails[0]['color'];

      case 17:
        return teamDetails[1]['color'];

      case 3:
        return teamDetails[2]['color'];

      case 14:
        return teamDetails[3]['color'];

      case 18:
        return teamDetails[4]['color'];

      case 2:
        return teamDetails[5]['color'];

      case 5:
        return teamDetails[6]['color'];

      case 1:
        return teamDetails[7]['color'];

      case 7:
        return teamDetails[8]['color'];

      case 12:
        return teamDetails[9]['color'];

      default:
        return '0xFF000000';
    }
  }
}
