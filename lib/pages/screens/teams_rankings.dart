import 'package:flutter/material.dart';
import '../../data/data_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:race_in/constants/clean_team_name.dart';
import 'package:race_in/constants/teams_colors.dart';
import '../../constants/team_details.dart';

class TeamsRankingPage extends StatelessWidget {
  final List<Map<String, dynamic>> teams;
  final DataNotifier dataNotifier;

  TeamsRankingPage({required this.teams, required this.dataNotifier});

  @override
  Widget build(BuildContext context) {
    return teams.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final teamsAll = dataNotifier.getData('teams');
              final team = teams[index];
              final teamName = cleanTeamName(team['team']['name']);
              int teamId = team['team']['id'] == 8 ? 18 : team['team']['id'];
              var teamColor = getTeamColor(teamId);
              final points = team['points'] ?? 0;

              String teamEngine = '';
              String countryCode = '';
              for (var eachTeam in teamsAll) {
                if (eachTeam['id'] == teamId) {
                  for (var detail in teamDetails) {
                    if (detail['id'] == teamId) {
                      teamEngine = eachTeam['engine'] + detail['engine'];
                      countryCode = detail['countryCode'];
                      break;
                    }
                  }
                  break;
                }
              }
              if (teamName == 'Force India') {
                countryCode = 'IN';
                teamEngine = 'Mercedes V6 turbo';
                teamColor = '0xFFFF8000';
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
                      teamName == 'Sauber' ? 'Kick Sauber' : teamName,
                      style: TextStyle(
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
                                    Icon(Icons.error),
                              ),
                        countryCode == ''
                            ? const SizedBox()
                            : const SizedBox(width: 10),
                        Text(
                          teamEngine,
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
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${points}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          'PTS',
                          style: const TextStyle(
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
