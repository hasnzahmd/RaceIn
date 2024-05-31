// import 'package:flutter/material.dart';
// import '../../data/data_service.dart';
// import '../detail_pages/team_standing_detail.dart';

// class TeamsStandings extends StatefulWidget {
//   @override
//   _TeamsStandingsState createState() => _TeamsStandingsState();
// }

// class _TeamsStandingsState extends State<TeamsStandings> {
//   final DataService _dataService = DataService();
//   List<String> seasons = [
//     '2011',
//     '2012',
//     '2013',
//     '2024'
//   ]; // Add your seasons (years) here
//   Map<String, Map<String, dynamic>> teamRankingsData = {};

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllTeamRankings();
//   }

//   Future<void> _fetchAllTeamRankings() async {
//     for (String season in seasons) {
//       var data = await _dataService.getTeamRanking(season);
//       setState(() {
//         teamRankingsData[season] = data;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Team Rankings')),
//       body: ListView.builder(
//         itemCount: seasons.length,
//         itemBuilder: (context, index) {
//           String season = seasons[index];
//           Map<String, dynamic>? teamRankingData = teamRankingsData[season];

//           if (teamRankingData == null) {
//             return ListTile(title: Text(season), subtitle: Text('Loading...'));
//           } else {
//             return ListTile(
//               title: Text(season),
//               subtitle: Text(
//                   'Points: ${teamRankingData['points'] ?? 'N/A'}'), // Example field
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TeamStandingDetails(
//                         season: season, teamRankingData: teamRankingData),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
