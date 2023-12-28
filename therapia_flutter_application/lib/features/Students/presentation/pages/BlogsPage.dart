// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';



class BlogsPage extends StatelessWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: SimpleProject(),
    );
  }
}

class SimpleProject extends StatelessWidget {
  const SimpleProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Text(
              "Using Lorem ipsum to focus attention on graphic elements in a webpage design proposal · One of the earliest examples of the Lorem ipsum placeholder text on 1960s advertising ·s"),
          margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          decoration : BoxDecoration(
            border: Border.all(color: Colors.cyan,width: 3),
            color: Color.fromARGB(255, 7, 187, 61),
            borderRadius: BorderRadius.circular(5),
          ),
        ));
  }
}
