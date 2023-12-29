import 'package:therapia_flutter_application/features/psychotherapist/domain/entities/Psychotherapist.dart';

class Blog {
  final String? content;
  final String? blogImg;
  final Psychotherapist psychotherapist;


  Blog(
      {this.content,
      this.blogImg,
      required this.psychotherapist,
      });
}
