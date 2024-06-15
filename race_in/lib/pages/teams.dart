import 'package:flutter/material.dart';
import '../constants/teams_colors.dart';
import '../constants/team_details.dart';
import '../components/custom_app_bar.dart';
import '../constants/clean_team_name.dart';
import '../data/data_service.dart';

class Teams extends StatefulWidget {
  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  final DataService _dataService = DataService();
  Future<List<Map<String, dynamic>>>? _teamsFuture;

  @override
  void initState() {
    super.initState();
    _teamsFuture = _dataService.getTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Teams'),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _teamsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No teams found.'));
          }

          var teams = snapshot.data!;

          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              final teamName = cleanTeamName(team['name']);
              int teamId = team['id'];
              if (teamId == 8) teamId = 18;
              final teamColor = getTeamColor(teamId);
              final teamEngine =
                  '${team['engine']}${teamDetails[index]['engine']}';
              return Card(
                margin:
                    const EdgeInsets.only(bottom: 1, top: 5, left: 3, right: 3),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(int.parse(teamColor)),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 7, right: 5),
                    textColor: const Color(0xBE000000),
                    minLeadingWidth: 4,
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
                    trailing: Image.network(
                      team['logo'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
