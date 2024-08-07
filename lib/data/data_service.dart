import 'package:hive/hive.dart';
import 'firestore_service.dart';
import '../constants/team_details.dart';

class DataService {
  final FirestoreService _firestoreService = FirestoreService();
  final Box cacheBox = Hive.box('cacheBox');

  final Duration cacheDuration = const Duration(hours: 6);
  final int currentYear = DateTime.now().year;

  Future<void> initializeData() async {
    await Future.wait([
      getTeams(),
      getRaces(),
      getRaces2(),
      getCircuits(),
      getCompetitions(),
      getAllDrivers(),
      for (int year = 2017; year <= currentYear; year++)
        getTeamsRankings(year.toString()),
      for (int year = 2017; year <= currentYear; year++)
        getDriversRankings(year.toString()),
    ]);
  }

  Future<List<Map<String, dynamic>>> getTeams() async {
    const cacheKey = 'teamsData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final allTeams = await _firestoreService.fetchTeams();

      final filteredTeams = allTeams.where((team) {
        final teamId = team['id'];
        return teamDetails.any((teamDetail) => teamDetail['id'] == teamId);
      }).toList();

      _setCacheData(cacheKey, filteredTeams);

      return filteredTeams;
    }
  }

  Future<List<Map<String, dynamic>>> getRaces() async {
    const cacheKey = 'racesData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final data = await _firestoreService.fetchRaces();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getRaces2() async {
    const cacheKey = 'races2Data';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final data = await _firestoreService.fetchRaces2();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getCircuits() async {
    const cacheKey = 'circuitsData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final data = await _firestoreService.fetchCircuits();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getCompetitions() async {
    const cacheKey = 'competitionsData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final data = await _firestoreService.fetchCompetitions();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getNews() async {
    const cacheKey = 'newsData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final data = await _firestoreService.fetchNews();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getAllDrivers() async {
    const cacheKey = 'driversData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final data = await _firestoreService.fetchAllDrivers();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getTeamsRankings(String season) async {
    final cacheKey = 'teamsRankingData_$season';
    final cacheValidDuration = season == currentYear.toString()
        ? cacheDuration
        : const Duration(days: 3650);
    if (_isCacheValid(cacheKey, cacheValidDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final data = await _firestoreService.fetchTeamsRankings(season);
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getDriversRankings(String season) async {
    final cacheKey = 'driversRankingData_$season';
    final cacheValidDuration = season == currentYear.toString()
        ? cacheDuration
        : const Duration(days: 3650);

    if (_isCacheValid(cacheKey, cacheValidDuration)) {
      return Future.value(_getCacheData(cacheKey));
    } else {
      final data = await _firestoreService.fetchDriversRankings(season);
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  bool _isCacheValid(String key, Duration duration) {
    final cache = cacheBox.get(key);
    if (cache == null) return false;

    final cacheTime = DateTime.parse(cache['cacheTime']);
    final currentTime = DateTime.now();
    return currentTime.difference(cacheTime) < duration;
  }

  List<Map<String, dynamic>> _getCacheData(String key) {
    final cache = cacheBox.get(key);
    if (cache == null) return [];
    return List<Map<String, dynamic>>.from(
      (cache['data'] as List).map((e) => Map<String, dynamic>.from(e)),
    );
  }

  void _setCacheData(String key, List<Map<String, dynamic>> data) {
    final cacheTime = DateTime.now().toIso8601String();
    cacheBox.put(key, {'cacheTime': cacheTime, 'data': data});
  }
}

  // void _startPeriodicCacheRefresh() {
  //   Future.delayed(Duration(minutes: 15), () async {
  //     await _refreshCacheIfNeeded();
  //     _startPeriodicCacheRefresh();
  //   });
  // }

  // Future<void> _refreshCacheIfNeeded() async {
  //   await getTeams();
  //   await getRaces();
  //   await getCircuits();
  //   await getCompetitions();
  //   await getAllDrivers();
  //   await getTeamsRankings(currentYear.toString());
  //   await getDriversRankings(currentYear.toString());
  // }
