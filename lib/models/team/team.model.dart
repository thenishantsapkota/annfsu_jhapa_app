import 'dart:convert';

Team teamFromJson(String str) => Team.fromJson(json.decode(str));

String teamToJson(Team data) => json.encode(data.toJson());

class Team {
  bool success;
  TeamData data;
  String message;

  Team({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        success: json["success"],
        data: TeamData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class TeamData {
  String presidentName;
  ImageUrls presidentImage;
  String vicePresidentName;
  ImageUrls vicePresidentImage;
  String secretaryName;
  ImageUrls secretaryImage;
  String? viceSecretaryName1;
  ImageUrls? viceSecretaryImage1;
  String? viceSecretaryName2;
  ImageUrls? viceSecretaryImage2;
  String? viceSecretaryName3;
  ImageUrls? viceSecretaryImage3;
  String treasurerName;
  ImageUrls treasurerImage;

  TeamData({
    required this.presidentName,
    required this.presidentImage,
    required this.vicePresidentName,
    required this.vicePresidentImage,
    required this.secretaryName,
    required this.secretaryImage,
    this.viceSecretaryName1,
    this.viceSecretaryImage1,
    this.viceSecretaryName2,
    this.viceSecretaryImage2,
    this.viceSecretaryName3,
    this.viceSecretaryImage3,
    required this.treasurerName,
    required this.treasurerImage,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) => TeamData(
        presidentName: json["president_name"],
        presidentImage: ImageUrls.fromJson(json["president_image"]),
        vicePresidentName: json["vice_president_name"],
        vicePresidentImage: ImageUrls.fromJson(json["vice_president_image"]),
        secretaryName: json["secretary_name"],
        secretaryImage: ImageUrls.fromJson(json["secretary_image"]),
        viceSecretaryName1: json["vice_secretary_name_1"],
        viceSecretaryImage1: _parseImageUrls(json["vice_secretary_image_1"]),
        viceSecretaryName2: json["vice_secretary_name_2"],
        viceSecretaryImage2: _parseImageUrls(json["vice_secretary_image_2"]),
        viceSecretaryName3: json["vice_secretary_name_3"],
        viceSecretaryImage3: _parseImageUrls(json["vice_secretary_image_3"]),
        treasurerName: json["treasurer_name"],
        treasurerImage: ImageUrls.fromJson(json["treasurer_image"]),
      );

  // Helper function to parse the image data, checking if it's an empty object
  static ImageUrls? _parseImageUrls(dynamic value) {
    if (value != null && value is Map<String, dynamic> && value.isNotEmpty) {
      return ImageUrls.fromJson(value);
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        "president_name": presidentName,
        "president_image": presidentImage.toJson(),
        "vice_president_name": vicePresidentName,
        "vice_president_image": vicePresidentImage.toJson(),
        "secretary_name": secretaryName,
        "secretary_image": secretaryImage.toJson(),
        "vice_secretary_name_1": viceSecretaryName1,
        "vice_secretary_image_1": viceSecretaryImage1?.toJson(),
        "vice_secretary_name_2": viceSecretaryName2,
        "vice_secretary_image_2": viceSecretaryImage2?.toJson(),
        "vice_secretary_name_3": viceSecretaryName3,
        "vice_secretary_image_3": viceSecretaryImage3?.toJson(),
        "treasurer_name": treasurerName,
        "treasurer_image": treasurerImage.toJson(),
      };
}

class ImageUrls {
  String fullSize;
  String smallSquareCrop;
  String mediumSquareCrop;
  String thumbnail;

  ImageUrls({
    required this.fullSize,
    required this.smallSquareCrop,
    required this.mediumSquareCrop,
    required this.thumbnail,
  });

  factory ImageUrls.fromJson(Map<String, dynamic> json) => ImageUrls(
        fullSize: json["full_size"],
        smallSquareCrop: json["small_square_crop"],
        mediumSquareCrop: json["medium_square_crop"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "full_size": fullSize,
        "small_square_crop": smallSquareCrop,
        "medium_square_crop": mediumSquareCrop,
        "thumbnail": thumbnail,
      };
}
