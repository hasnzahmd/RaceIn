import 'package:flutter/material.dart';

class RankingsNotifier extends ChangeNotifier {
  int currentYear;
  String selectedSeason;
  List<String> seasons;

  RankingsNotifier()
      : currentYear = DateTime.now().year,
        selectedSeason = DateTime.now().year.toString(),
        seasons = List.generate(DateTime.now().year - 2016,
            (index) => (DateTime.now().year - index).toString());

  void setSelectedSeason(String season) {
    selectedSeason = season;
    notifyListeners();
  }
}
