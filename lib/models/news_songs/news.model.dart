// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  bool success;
  List<Datum> data;
  String message;

  News({
    required this.success,
    required this.data,
    required this.message,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int id;
  String title;
  String body;
  Image image;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        image: Image.fromJson(json["image"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "image": image.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Image {
  String smallSquareCrop;
  String fullSize;
  String thumbnail;
  String mediumSquareCrop;

  Image({
    required this.smallSquareCrop,
    required this.fullSize,
    required this.thumbnail,
    required this.mediumSquareCrop,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        smallSquareCrop: json["small_square_crop"],
        fullSize: json["full_size"],
        thumbnail: json["thumbnail"],
        mediumSquareCrop: json["medium_square_crop"],
      );

  Map<String, dynamic> toJson() => {
        "small_square_crop": smallSquareCrop,
        "full_size": fullSize,
        "thumbnail": thumbnail,
        "medium_square_crop": mediumSquareCrop,
      };
}
