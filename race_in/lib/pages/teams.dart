import 'package:flutter/material.dart';
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

          teams.sort((a, b) {
            final nameA = cleanTeamName(a['name']);
            final nameB = cleanTeamName(b['name']);
            return nameA.compareTo(nameB);
          });

          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              final teamColor = Color(int.parse(teamDetails[index]['color']));
              return Card(
                margin:
                    const EdgeInsets.only(bottom: 1, top: 5, left: 5, right: 5),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: teamColor,
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    textColor: const Color(0xBE000000),
                    minLeadingWidth: 4,
                    title: Text(
                      '${team['engine']}${teamDetails[index]['engine']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: Text(
                      cleanTeamName(team['name']) == 'Mercedes-AMG'
                          ? 'Mercedes'
                          : cleanTeamName(team['name']),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    leading: VerticalDivider(
                      color: teamColor,
                      thickness: 5,
                      width: 5,
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
