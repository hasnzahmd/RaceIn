import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../data/firestore_service.dart';
import 'package:provider/provider.dart';
import '../data/data_notifier.dart';

class Latest extends StatelessWidget {
  const Latest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Latest'),
        body: Consumer<DataNotifier>(builder: (context, dataNotifier, child) {
          if (dataNotifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final races = dataNotifier.getData('races2');
            if (races.isEmpty) {
              return const Center(child: Text('No races found.'));
            }

            //Text('${races[0]['value'][0]['gPrx']}');
            return ListView.builder(
              itemCount: races.length,
              itemBuilder: (context, index) {
                final race = races[index];
                final gprx = race['value']['gPrx'].toString();
                return ListTile(
                  title: Text('${index + 1}    $gprx'),
                );
              },
            );
          }
        }));
  }
}



// class Latest extends StatefulWidget {
//   Latest({super.key});

//   @override
//   State<Latest> createState() => _LatestState();
// }

// class _LatestState extends State<Latest> {
//   FirestoreService dataService = FirestoreService();
//   Future<dynamic>? races;

//   @override
//   void initState() {
//     super.initState();
//     races = dataService.fetchRaces2();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Latest'),
//       body: FutureBuilder<dynamic>(
//         future: races,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final races = snapshot.data;
//             return SingleChildScrollView(
//                 child: Text('${races[0]['value'][0]['gPrx']}')
//                 // Column(
//                 //   children: races.entries.map((entry) {
//                 //     String key = entry.key;
//                 //     List<dynamic> values = entry.value;
//                 //     return Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         Text('${values[0]}'),
//                 //         // ...values.map((value) => Text(value.toString())).toList(),
//                 //       ],
//                 //     );
//                 //   }).toList(),
//                 // ),
//                 );
//           } else {
//             return const Center(child: Text('No races found.'));
//           }
//         },
//       ),
//     );
//   }
// }
