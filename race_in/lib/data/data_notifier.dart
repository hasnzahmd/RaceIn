import 'package:flutter/material.dart';
import 'data_service.dart';

class DataNotifier extends ChangeNotifier {
  final DataService _dataService = DataService();
  Map<String, List<Map<String, dynamic>>> _dataCache = {};
  bool _isLoading = true;

  DataNotifier() {
    initializeData();
  }

  bool get isLoading => _isLoading;

  Future<void> initializeData() async {
    await _dataService.initializeData();
    await _updateDataCache();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _updateDataCache() async {
    try {
      _isLoading = true;
      notifyListeners();

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

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  List<Map<String, dynamic>> getData(String key) {
    return _dataCache[key] ?? [];
  }
}
