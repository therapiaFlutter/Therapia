import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final int id;
  final String title;
  final String body;

    Blog({required this.id, required this.title, required this.body});

  
  @override
  List<Object?> get props => [id,title,body];
}
