//dataservice.dart
import 'package:hive/hive.dart';
import 'firestore_service.dart';
import '../constants/team_details.dart';

class DataService {
  final FirestoreService _firestoreService = FirestoreService();
  final Box cacheBox = Hive.box('cacheBox');

  final Duration cacheDuration = Duration(seconds: 30);

  Future<List<Map<String, dynamic>>> getTeams() async {
    const cacheKey = 'teamsData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return _getCacheData(cacheKey);
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
      return _getCacheData(cacheKey);
    } else {
      final data = await _firestoreService.fetchRaces();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getCircuits() async {
    const cacheKey = 'circuitsData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return _getCacheData(cacheKey);
    } else {
      final data = await _firestoreService.fetchCircuits();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getCompetitions() async {
    const cacheKey = 'competitionsData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return _getCacheData(cacheKey);
    } else {
      final data = await _firestoreService.fetchCompetitions();
      _setCacheData(cacheKey, data);
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> getAllDrivers() async {
    const cacheKey = 'driversData';

    if (_isCacheValid(cacheKey, cacheDuration)) {
      return _getCacheData(cacheKey);
    } else {
      final data = await _firestoreService.fetchAllDrivers();
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

  dynamic _getCacheData(String key) {
    final cache = cacheBox.get(key);
    return cache['data'];
  }

  void _setCacheData(String key, dynamic data) {
    final cacheTime = DateTime.now().toIso8601String();
    cacheBox.put(key, {'cacheTime': cacheTime, 'data': data});
  }
}


// Future<Map<String, dynamic>> getDriver(String driverName) async {
//   final cacheKey = 'driverData_$driverName';

//   if (_isCacheValid(cacheKey, cacheDuration)) {
//     return _getCacheData(cacheKey);
//   } else {
//     final data = await _firestoreService.fetchDriver(driverName);
//     _setCacheData(cacheKey, data);
//     return data;
//   }
// }

// Future<Map<String, dynamic>> getAllDriversData(List<String> driverNames) async {
//   Map<String, dynamic> drivers = {};
//   for (String name in driverNames) {
//     final driverData = await getDriver(name);
//     if (driverData.isNotEmpty) {
//       drivers[name] = driverData;
//     }
//   }
//   return drivers;
// }


// Future<Map<String, dynamic>> getTeamRanking(String season) async {
//   final cacheKey = 'teamRankingData_$season';

//   if (_isCacheValid(cacheKey, cacheDuration)) {
//     return _getCacheData(cacheKey);
//   } else {
//     final data = await _firestoreService.fetchTeamRanking(season);
//     _setCacheData(cacheKey, data);
//     return data;
//   }
// }

// Future<Map<String, dynamic>> getDriverRanking(String season) async {
//   final cacheKey = 'driverRankingData_$season';

//   if (_isCacheValid(cacheKey, cacheDuration)) {
//     return _getCacheData(cacheKey);
//   } else {
//     final data = await _firestoreService.fetchDriverRanking(season);
//     _setCacheData(cacheKey, data);
//     return data;
//   }
// }
