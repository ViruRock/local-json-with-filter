import 'dart:convert';

TrainingModel trainingModelFromJson(String str) =>
    TrainingModel.fromJson(json.decode(str));

class TrainingModel {
  TrainingModel({this.trainings});

  List<Training>? trainings;

  factory TrainingModel.fromJson(Map<String, dynamic> json) => TrainingModel(
        trainings: List<Training>.from(
            json["trainings"].map((x) => Training.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trainings": List<dynamic>.from(trainings!.map((x) => x.toJson())),
      };
}

class Training {
  Training({
    this.name,
    this.image,
    this.deadline,
    this.price,
    this.currency,
    this.newPrice,
    this.status,
    this.ratings,
    this.speaker,
  });

  String? name;
  String? image;
  Deadline? deadline;
  String? price;
  String? currency;
  String? newPrice;
  String? status;
  String? ratings;
  Speaker? speaker;

  factory Training.fromJson(Map<String, dynamic> json) => Training(
        name: json["name"],
        image: json["image"],
        deadline: Deadline.fromJson(json["deadline"]),
        price: json["price"],
        currency: json["currency"],
        newPrice: json["new_price"],
        status: json["status"],
        ratings: json["ratings"],
        speaker: Speaker.fromJson(json["speaker"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "deadline": deadline!.toJson(),
        "price": price,
        "currency": currency,
        "new_price": newPrice,
        "status": status,
        "ratings": ratings,
        "speaker": speaker!.toJson(),
      };
}

class Deadline {
  Deadline({
    this.timings,
    this.dates,
    this.place,
    this.location,
  });

  String? timings;
  String? dates;
  String? place;
  String? location;

  factory Deadline.fromJson(Map<String, dynamic> json) => Deadline(
        timings: json["timings"],
        dates: json["dates"],
        place: json["place"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "timings": timings,
        "dates": dates,
        "place": place,
        "location": location,
      };
}

class Speaker {
  Speaker({
    this.name,
    this.image,
    this.language,
    this.langImage,
  });

  String? name;
  String? image;
  String? language;
  String? langImage;

  factory Speaker.fromJson(Map<String, dynamic> json) => Speaker(
        name: json["name"],
        image: json["image"],
        language: json["language"],
        langImage: json["lang_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "language": language,
        "lang_image": langImage,
      };
}
