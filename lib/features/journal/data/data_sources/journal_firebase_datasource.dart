import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/journal_entity.dart';

class JournalFirebaseDataSource {
  final FirebaseFirestore firestore;

  JournalFirebaseDataSource(this.firestore);

  Future<void> addJournal(JournalEntity journal) async {
    await firestore.collection('journals').doc(journal.id).set(journal.toMap());
  }

  Future<List<JournalEntity>> getJournals(String userId) async {
    final snapshot = await firestore
        .collection('journals')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => JournalEntity.fromMap(doc.data()))
        .toList();
  }

  Future<void> deleteJournal(String journalId) async {
    await firestore.collection('journals').doc(journalId).delete();
  }
}
