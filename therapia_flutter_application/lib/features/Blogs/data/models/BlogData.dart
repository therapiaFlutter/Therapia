import 'package:therapia_flutter_application/features/Blogs/domain/entities/blog.dart';
import 'package:therapia_flutter_application/features/psychotherapist/data/models/PsychotherapistData.dart';

class BlogtData {
  static final List<Blog> Blogs = [
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[0],
      blogImg: "https://picsum.photos/id/1001/960/540",
    ),
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[1],
      blogImg: "https://picsum.photos/id/1001/960/540",
    ),
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[0],
      content:
          "How many programmers does it take to change a light bulb? None, that’s a hardware problem.",
    ),
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[1],
      content:
          "Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the Universe trying to produce bigger and better idiots. So far, the Universe is winning.",
      blogImg: "https://picsum.photos/id/1002/960/540",
    ),
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[2],
      content: "Good morning!",
      blogImg: "https://picsum.photos/id/1003/960/540",
    ),
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[1],
      blogImg: "https://picsum.photos/id/1004/960/540",
    ),
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[3],
      blogImg: "https://picsum.photos/id/1005/960/540",
    ),
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[0],
      blogImg: "https://picsum.photos/id/1006/960/540",
    ),
  ];
}
