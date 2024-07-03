import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../notifiers/rankings_notifier.dart';
import '../constants/custom_colors.dart';

class SelectAppBar extends StatelessWidget {
  const SelectAppBar({
    super.key,
    required this.selectedIndex,
    required this.pageTitles,
    required this.context,
  });

  final int selectedIndex;
  final List<String> pageTitles;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 4) {
      final rankingsNotifier = Provider.of<RankingsNotifier>(context);
      return AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Image.asset('assets/images/f1w.png'),
        ),
        title: const Text('Rankings'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: rankingsNotifier.selectedSeason,
              dropdownColor: CustomColors.f1red,
              onChanged: (value) {
                rankingsNotifier.setSelectedSeason(value!);
              },
              items: rankingsNotifier.seasons
                  .map<DropdownMenuItem<String>>((String season) {
                return DropdownMenuItem<String>(
                  value: season,
                  child: Text(
                    season,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded, size: 30, color: Colors.white),
            onPressed: () {},
          ),
        ],
      );
    } else {
      return CustomAppBar(title: pageTitles[selectedIndex]);
    }
  }
}
