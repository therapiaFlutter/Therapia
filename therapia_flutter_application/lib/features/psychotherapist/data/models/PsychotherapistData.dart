import 'package:therapia_flutter_application/features/psychotherapist/domain/entities/Psychotherapist.dart';

class PsychotherapistData {
  static final List<Psychotherapist> psychotherapists = [
    Psychotherapist(
      name: "Mme Manel ALBOUCHI",
      image: "lib/core/assets/images/manel.jpg",
      location: "La Marsa Tunis Tunisie  ",
    ),
    Psychotherapist(
      name: "Kamel ABDELHAK",
      image: "lib/core/assets/images/psyImg.jpg",
      location: "Hammam Lif Ben arous Tunisie  ",
    ),
    Psychotherapist(
      name: "Mme Nedia BEN SLAMA",
      image: "lib/core/assets/images/psyImg.jpg",
      location: "Tunis Belvédère Tunis Tunisie ",
    ),
    Psychotherapist(
      name: "Mr Aymen KHALSI",
      image: "lib/core/assets/images/psyImg.jpg",
      location: "Tunis Belvédère Tunis Tunisie  ",
    ),
    Psychotherapist(
      name: "Mme Sawsen GHRAIRI",
      image: "lib/core/assets/images/psyImg.jpg",
      location: "El Mourouj 1 Ben arous Tunisie  ",
    ),
  ];
}
