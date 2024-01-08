// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapia_flutter_application/core/colors/PageBackground.dart';
import 'package:therapia_flutter_application/core/firebase/firestore.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();

  
}

class _AppointmentState extends State<Appointment> {
  final FirestoreService firestoreService = FirestoreService();


    void openNoteBox({String? docID}) async {
    // Text controllers for title and description
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    // Initialize the state for the date and time
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    // Fetch the document from Firestore and populate the fields
    if (docID != null) {
      DocumentSnapshot documentSnapshot =
          await firestoreService.getNoteById(docID);

      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      titleController.text = data['title'] ?? '';
      descriptionController.text = data['description'] ?? '';
      Timestamp dateTimestamp = data['date'] as Timestamp;
      DateTime date = dateTimestamp.toDate();

      // Ensure 'note' field is not null
      String noteText = data['note'] ?? '';

      selectedDate = date;
      selectedTime = TimeOfDay.fromDateTime(date);
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title:
                  Text("Book an Appointment"), // Add a title to the AlertDialog
              contentPadding: const EdgeInsets.all(16),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Enter title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Enter description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text("${selectedDate.toLocal()}".split(' ')[0]),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: Text(selectedTime.format(context)),
                      trailing: Icon(Icons.access_time),
                      onTap: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null && picked != selectedTime) {
                          setState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (docID == null) {
                      firestoreService.addNote(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate,
                        time: selectedTime,
                      );
                    } else {
                      firestoreService.updateNote(
                        docID: docID,
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate,
                        time: selectedTime,
                      );
                    }
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Confirm"),
                ),
              ],
            );
          },
        );
      },
    );
  }



@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
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
                          onPressed: () => openNoteBox(docID: docID),
                          icon: const Icon(
                            Icons.edit,
                            color:  Color(0xFF734afb), // Set the icon color
                          ),
                        ),

                        // Delete
                        IconButton(
                          onPressed: () => _showDeleteConfirmationDialog(context, docID),
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

  Future<void> _showDeleteConfirmationDialog(BuildContext context, String docID) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Appointment"),
          content: Text("Are you sure you want to delete this Appointment?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color:  Color(0xFF734afb)), // Set the text color
              ),
            ),
            ElevatedButton(
              onPressed: () {
                firestoreService.deleteNote(docID);
                Navigator.of(context).pop();
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
}
