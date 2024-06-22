import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/teams_colors.dart';
import '../constants/team_details.dart';
import '../components/custom_app_bar.dart';
import '../data/data_notifier.dart';
import '../constants/clean_team_name.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Teams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Teams'),
      body: Consumer<DataNotifier>(
        builder: (context, dataNotifier, child) {
          if (dataNotifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final teams = dataNotifier.getData('teams');
            if (teams.isEmpty) {
              return const Center(child: Text('No teams found.'));
            }

            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                final teamName = cleanTeamName(team['name']);
                int teamId = team['id'];
                if (teamId == 8) teamId = 18;
                final teamColor = getTeamColor(teamId);

                var teamEngine = '';
                //var countryCode = '';
                for (var detail in teamDetails) {
                  if (detail['id'] == teamId) {
                    // countryCode = detail['countryCode'];
                    teamEngine = '${team['engine']}${detail['engine']}';
                    break;
                  }
                }

                return Card(
                  margin: const EdgeInsets.only(
                      bottom: 1, top: 1, left: 3, right: 3),
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color(int.parse(teamColor)).withOpacity(0.6),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 7, right: 5),
                      textColor: const Color(0xBE000000),
                      minLeadingWidth: 3,
                      title: Text(
                        teamEngine,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      subtitle: Text(
                        teamName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      leading: VerticalDivider(
                        color: Color(int.parse(teamColor)),
                        thickness: 5,
                        width: 0,
                      ),
                      trailing: CachedNetworkImage(
                        imageUrl: team['logo'],
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.image, size: 50);
                        },
                      ),
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
