// To parse this JSON data, do
//
//     final songs = songsFromJson(jsonString);

import 'dart:convert';

Songs songsFromJson(String str) => Songs.fromJson(json.decode(str));

String songsToJson(Songs data) => json.encode(data.toJson());

class Songs {
  bool success;
  List<Datum> data;
  String message;

  Songs({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Songs.fromJson(Map<String, dynamic> json) => Songs(
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
  String youtubeUrl;
  String audioFile;

  Datum({
    required this.id,
    required this.title,
    required this.youtubeUrl,
    required this.audioFile,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        youtubeUrl: json["youtube_url"],
        audioFile: json["audio_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "youtube_url": youtubeUrl,
        "audio_file": audioFile,
      };
}
