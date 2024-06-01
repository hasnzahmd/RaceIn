import 'package:hive/hive.dart';
import 'firestore_service.dart';
import '../constants/team_details.dart';

class DataService {
  final FirestoreService _firestoreService = FirestoreService();
  final Box cacheBox = Hive.box('cacheBox');

  final Duration cacheDuration = Duration(hours: 24);

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

  void _setCacheData(String key, dynamic data) {
    final cacheTime = DateTime.now().toIso8601String();
    cacheBox.put(key, {'cacheTime': cacheTime, 'data': data});
  }
}
