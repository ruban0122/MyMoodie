import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mood_model.dart';

abstract class MoodRemoteDataSource {
  Future<void> addMood(MoodModel mood);
  Future<List<MoodModel>> getMoods(String userId);
  Future<void> updateMood(MoodModel mood);
  Future<void> deleteMood(String id);
}

class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  final FirebaseFirestore firestore;

  MoodRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addMood(MoodModel mood) async {
    await firestore.collection('moods').doc(mood.id).set(mood.toJson());
  }

  @override
  Future<List<MoodModel>> getMoods(String userId) async {
    final snapshot = await firestore
        .collection('moods')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => MoodModel.fromJson(doc.data()))
        .toList();
  }

    @override
  Future<void> updateMood(MoodModel mood) async {
    await firestore.collection('moods').doc(mood.id).update(mood.toMap());
  }

  @override
  Future<void> deleteMood(String id) async {
    await firestore.collection('moods').doc(id).delete();
  }
}
