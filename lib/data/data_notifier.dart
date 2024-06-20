import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:race_in/constants/driver_details.dart';
import 'package:race_in/constants/team_details.dart';
import 'data_service.dart';

class DataNotifier extends ChangeNotifier {
  final DataService _dataService = DataService();
  Map<String, List<Map<String, dynamic>>> _dataCache = {};
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  DataNotifier();

  Future<void> initializeData(BuildContext context) async {
    await _dataService.initializeData();
    await _updateDataCache();
    _isLoading = false;
    notifyListeners();
    await _precacheImages(context);
  }

  Future<void> _updateDataCache() async {
    final List<Future<void>> futures = [
      _fetchAndCacheData('teams', _dataService.getTeams),
      _fetchAndCacheData('races', _dataService.getRaces),
      _fetchAndCacheData('circuits', _dataService.getCircuits),
      _fetchAndCacheData('competitions', _dataService.getCompetitions),
      _fetchAndCacheData('drivers', _dataService.getAllDrivers),
    ];

    for (int year = 2017; year <= _dataService.currentYear; year++) {
      futures.addAll([
        _fetchAndCacheData('teamsRanking_$year',
            () => _dataService.getTeamsRankings(year.toString())),
        _fetchAndCacheData('driversRanking_$year',
            () => _dataService.getDriversRankings(year.toString())),
      ]);
    }

    await Future.wait(futures);
  }

  Future<void> _fetchAndCacheData(String key,
      Future<List<Map<String, dynamic>>> Function() fetchFunction) async {
    _dataCache[key] = await fetchFunction();
  }

  Future<void> _precacheImages(BuildContext context) async {
    List<String> imageUrls = [];

    // Collect all image URLs to be precached
    imageUrls.addAll(
        _dataCache['teams']?.map((team) => team['logo']).whereType<String>() ??
            []);
    imageUrls.addAll(
        driverDetails.map((driver) => driver['url']).whereType<String>());
    imageUrls.addAll(_dataCache['drivers']?.map((driver) {
          return 'https://flagsapi.com/${driver['data'][0]['country']['code']}/shiny/64.png';
        }).whereType<String>() ??
        []);
    imageUrls.addAll(teamDetails.map((team) {
      return 'https://flagsapi.com/${team['countryCode']}/shiny/64.png';
    }).whereType<String>());

    const int batchSize = 10;
    for (int i = 0; i < imageUrls.length; i += batchSize) {
      final batch = imageUrls.sublist(i,
          i + batchSize > imageUrls.length ? imageUrls.length : i + batchSize);
      await Future.wait(batch.map(
          (url) => precacheImage(CachedNetworkImageProvider(url), context)));
    }
  }

  List<Map<String, dynamic>> getData(String key) {
    return _dataCache[key] ?? [];
  }
}
