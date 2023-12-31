// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:therapia_flutter_application/features/Blogs/data/models/BlogData.dart';
import 'package:therapia_flutter_application/features/Blogs/domain/entities/blog.dart';
import 'package:therapia_flutter_application/features/psychotherapist/data/models/PsychotherapistData.dart';
import 'package:therapia_flutter_application/features/psychotherapist/domain/entities/Psychotherapist.dart';
import 'dart:math';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DateTime> selectedDays = _generateRandomDays();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        backgroundColor: Color(0xFFEEEDF5),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              //header section
SizedBox(height: 8),
              Row(
                children: [
                  Image.asset(
                    "lib/core/assets/images/logo-no-background.png",
                    width: 230,
                    height: 200,
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "lib/core/assets/images/psyImg.jpg",
                    ),
                    radius: 20,
                  ),
                ],
              ),

              // Add a smaller SizedBox here
              SizedBox(height: 8),
              Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: Color(0xFF734BFB),
      width: 2.0,
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFC2BEFF).withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
    borderRadius: BorderRadius.circular(10),
  ),
  child: TableCalendar(
    firstDay: DateTime.utc(2024, 1, 1),
    lastDay: DateTime.utc(2024, 12, 31),
    focusedDay: DateTime.utc(2024, 1, 1),
    calendarFormat: CalendarFormat.week,
    headerStyle: HeaderStyle(
      formatButtonVisible: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w900,
        fontSize: 16, // Adjust the font size as needed
        color: Color(0xFF734BFB), // Set your desired font color
      ),
    ),
    daysOfWeekStyle: DaysOfWeekStyle(
      weekdayStyle: TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
        fontSize: 14, 
    
      ),
      weekendStyle: TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
        fontSize: 14, // Adjust the font size as needed
         
      ),
    ),
    calendarStyle: CalendarStyle(
      todayDecoration: BoxDecoration(
        color: Colors.blueAccent,
        shape: BoxShape.circle,
      ),
      selectedDecoration: BoxDecoration(
        color: Colors.pinkAccent,
        shape: BoxShape.circle,
      ),
    ),
    selectedDayPredicate: (day) => generateRandomDates().contains(day),
  ),
),

              // SizedBox with flexible height
              SizedBox(height: 26),

              ListTile(
                title: Text(
                  'Our Psychotherapists',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Color(0xFF734BFB),
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: PsychotherapistData.psychotherapists.length,
                        itemBuilder: (context, index) {
                          Psychotherapist therapist =
                              PsychotherapistData.psychotherapists[index];

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    therapist.image ?? '',
                                  ),
                                  radius: 50,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  therapist.name ?? '',
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              ListTile(
                title: Text(
                  'Our Educational Content',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF734BFB),
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: BlogtData.Blogs.length,
                        itemBuilder: (context, index) {
                          Blog blog = BlogtData.Blogs[index];

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(blog.blogImg ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DateTime> _generateRandomDays() {
    final Random random = Random();
    final List<DateTime> selectedDays = [];

    for (int i = 0; i < 3; i++) {
      final randomDay =
          DateTime.utc(2023, 1 + random.nextInt(11), 1 + random.nextInt(27));
      selectedDays.add(randomDay);
    }

    return selectedDays;
  }

  List<DateTime> generateRandomDates() {
    var rng = Random();
    var startDate = DateTime.utc(2024, 1, 1);
    var endDate = DateTime.utc(2024, 12, 31);
    var weeks = (endDate.difference(startDate).inDays / 7).floor();

    List<DateTime> selectedDays = [];

    for (var i = 0; i < weeks; i++) {
      var weekStart = startDate.add(Duration(days: i * 7));
      var weekEnd = weekStart.add(Duration(days: 6));

      var randomDay1 = weekStart.add(Duration(days: rng.nextInt(7)));
      var randomDay2 = weekStart.add(Duration(days: rng.nextInt(7)));

      while (randomDay1 == randomDay2) {
        randomDay2 = weekStart.add(Duration(days: rng.nextInt(7)));
      }

      selectedDays.addAll([randomDay1, randomDay2]);
    }

    return selectedDays;
  }
}
