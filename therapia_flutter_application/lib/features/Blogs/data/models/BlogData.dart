import 'package:therapia_flutter_application/features/Blogs/domain/entities/blog.dart';
import 'package:therapia_flutter_application/features/psychotherapist/data/models/PsychotherapistData.dart';

class BlogtData {
  static final List<Blog> Blogs = [
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[0],
      blogImg: "lib/core/assets/images/img1.png",
    ),
  
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[1],
      content:
"Anxiety disorders affect millions of people worldwide. This article provides an overview of the various types of anxiety disorders, including generalized anxiety disorder, social anxiety, and panic disorder. It explores common symptoms and discusses evidence-based treatment options such as therapy and medication.",
      
    ),
    Blog(
      psychotherapist: PsychotherapistData.psychotherapists[2],
      content: "In the age of constant connectivity, social media plays a significant role in our lives. This article delves into the impact of social media on mental health, discussing both positive and negative effects. It explores issues like cyberbullying, the fear of missing out (FOMO), and strategies for maintaining a healthy online-offline balance.",
      blogImg: "lib/core/assets/images/img4.png",
    ),
      Blog(
      psychotherapist: PsychotherapistData.psychotherapists[2],
      content: "Self-care is crucial for maintaining good mental health. This article explores the concept of self-care, emphasizing its role in preventing burnout and promoting overall well-being. It provides practical tips for incorporating self-care into daily routines and highlights the positive impact it can have on mental health.",
      blogImg: "lib/core/assets/images/img1.png",
    ),
      Blog(
      psychotherapist: PsychotherapistData.psychotherapists[2],
      content: "Grief is a universal human experience often accompanied by mental health challenges. This article provides insights into the grieving process, discussing common emotions and coping mechanisms. It emphasizes the importance of seeking support from friends, family, or professionals during difficult times and offers guidance on navigating the healing journey.",
      blogImg: "lib/core/assets/images/img4.png",
    ),
    
  
  ];
}
