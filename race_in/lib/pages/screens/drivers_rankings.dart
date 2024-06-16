import 'package:flutter/material.dart';
import 'package:race_in/constants/clean_team_name.dart';
//import 'package:race_in/constants/custom_colors.dart';
import 'package:race_in/constants/teams_colors.dart';
//import 'package:country_flags/country_flags.dart';

class DriversRankingPage extends StatelessWidget {
  final List<Map<String, dynamic>> drivers;

  DriversRankingPage({required this.drivers});

  @override
  Widget build(BuildContext context) {
    return drivers.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              final name = driver['driver']['name'];
              int teamId =
                  driver['team']['id'] == 8 ? 18 : driver['team']['id'];
              final teamColor = getTeamColor(teamId);
              final teamName = cleanTeamName(driver['team']['name']);
              final points = driver['points'] ?? 0;
              return Card(
                margin:
                    const EdgeInsets.only(bottom: 4, top: 2, left: 3, right: 3),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(int.parse(teamColor)).withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: ListTile(
                    minLeadingWidth: 15,
                    title: Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          teamName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                    trailing: Text(
                      '${points}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
