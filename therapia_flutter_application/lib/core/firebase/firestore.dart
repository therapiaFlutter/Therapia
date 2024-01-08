// firestore.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');

  Future<void> addNote({
    required String title,
    required String description,
    required DateTime date,
    required TimeOfDay time,
  }) {
    return appointments.add({
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      )),
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> updateNote({
    required String docID,
    required String title,
    required String description,
    required DateTime date,
    required TimeOfDay time,
  }) {
    return appointments.doc(docID).update({
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      )),
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        appointments.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  Future<void> deleteNote(String docID) {
    return appointments.doc(docID).delete();
  }

  Future<DocumentSnapshot> getNoteById(String docID) {
    return appointments.doc(docID).get();
  }
}
