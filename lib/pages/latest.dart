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
