import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:race_in/constants/driver_details.dart';
import 'data_service.dart';

class DataNotifier extends ChangeNotifier {
  final DataService _dataService = DataService();
  Map<String, List<Map<String, dynamic>>> _dataCache = {};
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  DataNotifier() {
    // Don't initialize data here to avoid context issues
  }

  Future<void> initializeData(BuildContext context) async {
    await _dataService.initializeData();
    await _updateDataCache();
    _isLoading = false;
    notifyListeners();
    await _precacheImages(context); // Pass context here
  }

  Future<void> _updateDataCache() async {
    _dataCache['teams'] = await _dataService.getTeams();
    _dataCache['races'] = await _dataService.getRaces();
    _dataCache['circuits'] = await _dataService.getCircuits();
    _dataCache['competitions'] = await _dataService.getCompetitions();
    _dataCache['drivers'] = await _dataService.getAllDrivers();
    for (int year = 2017; year <= _dataService.currentYear; year++) {
      _dataCache['teamsRanking_$year'] =
          await _dataService.getTeamsRankings(year.toString());
      _dataCache['driversRanking_$year'] =
          await _dataService.getDriversRankings(year.toString());
    }
  }

  Future<void> _precacheImages(BuildContext context) async {
    // Assuming your data has a 'imageUrl' field
    for (var team in _dataCache['teams'] ?? []) {
      String imageUrl = team['logo'];
      await precacheImage(CachedNetworkImageProvider(imageUrl), context);
    }

    for (var driver in driverDetails) {
      String imageUrl = driver['url'];
      await precacheImage(CachedNetworkImageProvider(imageUrl), context);
    }
  }

  List<Map<String, dynamic>> getData(String key) {
    return _dataCache[key] ?? [];
  }
}
