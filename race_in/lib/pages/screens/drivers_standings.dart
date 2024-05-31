// import 'package:flutter/material.dart';
// import '../../data/data_service.dart';
// import '../detail_pages/driver_standing_detail.dart';

// class DriversStandings extends StatefulWidget {
//   @override
//   _DriversStandingsState createState() => _DriversStandingsState();
// }

// class _DriversStandingsState extends State<DriversStandings> {
//   final DataService _dataService = DataService();
//   List<String> seasons = [
//     '2011',
//     '2012',
//     '2013',
//     '2024'
//   ]; // Add your seasons (years) here
//   Map<String, Map<String, dynamic>> driverRankingsData = {};

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllDriverRankings();
//   }

//   Future<void> _fetchAllDriverRankings() async {
//     for (String season in seasons) {
//       var data = await _dataService.getDriverRanking(season);
//       setState(() {
//         driverRankingsData[season] = data;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Driver Rankings')),
//       body: ListView.builder(
//         itemCount: seasons.length,
//         itemBuilder: (context, index) {
//           String season = seasons[index];
//           Map<String, dynamic>? driverRankingData = driverRankingsData[season];

//           if (driverRankingData == null) {
//             return ListTile(title: Text(season), subtitle: Text('Loading...'));
//           } else {
//             return ListTile(
//               title: Text(season),
//               subtitle: Text(
//                   'Points: ${driverRankingData['points'] ?? 'N/A'}'), // Example field
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DriverStandingDetail(
//                         season: season, driverRankingData: driverRankingData),
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
