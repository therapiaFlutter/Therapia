import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:therapia_flutter_application/core/firebase/firestore.dart';

class psyHomePage extends StatefulWidget {
  const psyHomePage({Key? key}) : super(key: key);

  @override
  State<psyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<psyHomePage> {
  final FirestoreService firestoreService = FirestoreService();

  void openBlogBox({String? docID}) async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final psyController = TextEditingController();

    if (docID != null) {
      DocumentSnapshot documentSnapshot =
          await firestoreService.getBlogById(docID);

      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      titleController.text = data['title'] ?? '';
      psyController.text = data['psychotherapist'] ?? '';
      descriptionController.text = data['description'] ?? '';

      // Ensure 'note' field is not null
      String blogText = data['blog'] ?? '';
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Blog"), // Add a title to the AlertDialog
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
                      "Psychotherapist",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: psyController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
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
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (docID == null) {
                      await firestoreService.addBlog(
                        title: titleController.text,
                        psychotherapist: psyController.text,
                        description: descriptionController.text,
                      );
                      _showSnackbarAdd("Blog added successfully");
                    } else {
                      await firestoreService.updateBlog(
                        docID: docID,
                        title: titleController.text,
                        psychotherapist: psyController.text,
                        description: descriptionController.text,
                      );
                      _showSnackbarEdit("Blog edited successfully");
                    }
                    titleController.clear();
                    psyController.clear();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => openBlogBox(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getBlogsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List blogsList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: blogsList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = blogsList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String title = data['title'] ?? 'No Title';
                String psychotherapist =
                    data['psychotherapist'] ?? 'No Psychotherapist';
                String description = data['description'] ?? 'No Description';

                // Ensure 'blog' field is not null
                String blogText = data['blog'] ?? '';

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
                          onPressed: () => openBlogBox(docID: docID),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue, // Set the icon color
                          ),
                        ),

                        // Delete
                        IconButton(
                          onPressed: () => _showDeleteConfirmationDialog(docID),
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
            return const Center(child: Text("No blogs."));
          }
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(String docID) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Blog"),
          content: Text("Are you sure you want to delete this Blog?"),
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
              onPressed: () async {
                await firestoreService.deleteBlog(docID);
                Navigator.of(context).pop();
                _showSnackbarDelete("Blog deleted successfully");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbarAdd(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showSnackbarDelete(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSnackbarEdit(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
