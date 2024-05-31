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

  Future<Map<String, dynamic>> fetchTeamRanking(String season) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('TeamsRanking').doc(season).get();

      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        return {};
      }
    } catch (e) {
      throw Exception(
          'Error fetching team ranking data for season $season: $e');
    }
  }

  Future<Map<String, dynamic>> fetchDriverRanking(String season) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('DriversRanking').doc(season).get();

      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        return {};
      }
    } catch (e) {
      throw Exception(
          'Error fetching driver ranking data for season $season: $e');
    }
  }
}

  // Future<Map<String, dynamic>> fetchDriver(String driverName) async {
  //   try {
  //     DocumentSnapshot<Map<String, dynamic>> snapshot =
  //         await _firestore.collection('F1Drivers').doc(driverName).get();

  //     if (snapshot.exists) {
  //       return snapshot.data()!;
  //     } else {
  //       return {};
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching driver data: $e');
  //   }
  // }