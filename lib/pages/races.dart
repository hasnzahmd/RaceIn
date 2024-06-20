import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
// import 'detail_pages/race_details.dart';

class Races extends StatefulWidget {
  const Races({super.key});

  @override
  State<Races> createState() => _RacesState();
}

class _RacesState extends State<Races> {
  List<dynamic> racesData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Races',
      ),
      // body: racesData.isEmpty
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemCount: racesData.length,
      //         itemBuilder: (context, index) {
      //           final race = racesData[index];
      //           return Card(
      //             child: ListTile(
      //               title: Text(race['competition']['name']),
      //               subtitle: Text(race['date']),
      //               onTap: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => RaceDetails(race: race),
      //                   ),
      //                 );
      //               },
      //             ),
      //           );
      //         },
      //       ),
      body: Center(
        child: Text('Races page'),
      ),
    );
  }
}
