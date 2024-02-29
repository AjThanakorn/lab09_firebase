import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class FirestoreService{
  //CRUD operation
  //get collection of notes
  final CollectionReference notes=FirebaseFirestore.instance.collection('notes');
  //create
Future<void> addNote(String note){
  return notes.add({
    'note': note,
    'timestamp':Timestamp.now()
  }
  );
}
  //read
  //update
  //delete
}