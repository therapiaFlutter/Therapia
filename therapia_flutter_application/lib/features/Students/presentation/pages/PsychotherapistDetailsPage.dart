import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/core/firebase/firestore.dart';
import 'package:therapia_flutter_application/features/Students/presentation/pages/appointments.dart';
import 'package:therapia_flutter_application/features/psychotherapist/domain/entities/Psychotherapist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/features/psychotherapist/domain/entities/Psychotherapist.dart';

class PsychotherapistDetailsPage extends StatefulWidget {
  const PsychotherapistDetailsPage({Key? key, required this.psychotherapist})
      : super(key: key);

  @override
  State<PsychotherapistDetailsPage> createState() =>
      _PsychotherapistDetailsPageState();
  final Psychotherapist psychotherapist;
}

class _PsychotherapistDetailsPageState
    extends State<PsychotherapistDetailsPage> {
  final FirestoreService firestoreService = FirestoreService();

  late Psychotherapist psychotherapist; // Define the psychotherapist variable

  @override
  void initState() {
    super.initState();
    // Initialize the psychotherapist variable in the initState method
    psychotherapist = widget.psychotherapist;
  }

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
        //title: Text("Psychotherapist Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(),
        child: Tooltip(
          message: 'Book an Appointment',
          child: Icon(Icons.calendar_month_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(psychotherapist.image ?? ''),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Name: ${psychotherapist.name ?? 'N/A'}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  "${psychotherapist.location ?? 'N/A'}",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
