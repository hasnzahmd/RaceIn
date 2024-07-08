import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/rankings_notifier.dart';
import '../constants/custom_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int selectedIndex;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final rankingsNotifier = Provider.of<RankingsNotifier>(context);
    List<Widget> actions = [
      if (selectedIndex == 4)
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
      if (selectedIndex == 3)
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.arrowDownAZ,
              color: Colors.white,
              size: 17,
            ),
            onPressed: () {},
          ),
        ),
      IconButton(
        icon: const Icon(Icons.menu_rounded, size: 30, color: Colors.white),
        onPressed: () {},
      ),
    ];

    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Image.asset('assets/images/f1w.png'),
      ),
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
