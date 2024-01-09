import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:therapia_flutter_application/core/firebase/firestore.dart';

class psyAppointment extends StatefulWidget {
  @override
  _psyAppointmentState createState() => _psyAppointmentState();
}

class _psyAppointmentState extends State<psyAppointment> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: PageBackground.getBackgroundColor(),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getNotesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;

                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String title = data['title'] ?? 'No Title';
                  String description = data['description'] ?? 'No Description';

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(title),
                      subtitle: Text(description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Update
                          IconButton(
                            onPressed: () =>
                                _showAcceptConfirmationDialog(context, docID),
                            icon: const Icon(
                              Icons.check,
                              color: Colors.blue,
                            ),
                          ),

                          // Delete
                          IconButton(
                            onPressed: () =>
                                _showDeleteConfirmationDialog(context, docID),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red, // Set the icon color
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No Appointments."));
            }
          },
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String docID) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Appointment"),
          content: Text("Are you sure you want to delete this appointment?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.blue), // Set the text color
              ),
            ),
            ElevatedButton(
              onPressed: () {
                firestoreService.deleteNote(docID);
                Navigator.of(context).pop();
                _showSnackbarDecline("Appointment declined.");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Set the background color
              ),
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white), // Set the text color
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAcceptConfirmationDialog(
      BuildContext context, String docID) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Accept Appointment"),
          content: Text("Are you sure you want to accept this appointment?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackbarAccept(
                    "Appointment accepted, it is now on your schedule.");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text(
                "Accept",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbarAccept(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showSnackbarDecline(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
