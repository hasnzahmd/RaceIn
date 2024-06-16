import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchCollectionData(
      String collection, String doc) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(collection).doc(doc).get();

      if (snapshot.exists) {
        List<dynamic> data = snapshot.data()!['data'];
        return List<Map<String, dynamic>>.from(data);
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(
          'Error fetching $doc data from $collection collection: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchTeams() async {
    return _fetchCollectionData('F1Data', 'teams');
  }

  Future<List<Map<String, dynamic>>> fetchRaces() async {
    return _fetchCollectionData('F1Data', 'races');
  }

  Future<List<Map<String, dynamic>>> fetchCircuits() async {
    return _fetchCollectionData('F1Data', 'circuits');
  }

  Future<List<Map<String, dynamic>>> fetchCompetitions() async {
    return _fetchCollectionData('F1Data', 'competitions');
  }

  Future<List<Map<String, dynamic>>> fetchAllDrivers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('F1Drivers').get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching drivers data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchTeamsRankings(String season) async {
    return _fetchCollectionData('TeamsRanking', season);
  }

  Future<List<Map<String, dynamic>>> fetchDriversRankings(String season) async {
    return _fetchCollectionData('DriversRanking', season);
  }
}
