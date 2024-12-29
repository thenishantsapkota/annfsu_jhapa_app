// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  bool success;
  Data data;
  String message;

  Profile({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  int id;
  String email;
  String fullName;
  String gender;
  String bloodGroup;
  String contactNumber;
  String address;
  String collegeName;
  String position;
  ProfilePicture profilePicture;

  Data({
    required this.id,
    required this.email,
    required this.fullName,
    required this.gender,
    required this.bloodGroup,
    required this.contactNumber,
    required this.address,
    required this.collegeName,
    required this.position,
    required this.profilePicture,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        contactNumber: json["contact_number"],
        address: json["address"],
        collegeName: json["college_name"],
        position: json["position"],
        profilePicture: ProfilePicture.fromJson(json["profile_picture"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "gender": gender,
        "blood_group": bloodGroup,
        "contact_number": contactNumber,
        "address": address,
        "college_name": collegeName,
        "position": position,
        "profile_picture": profilePicture.toJson(),
      };
}

class ProfilePicture {
  String smallSquareCrop;
  String fullSize;
  String thumbnail;
  String mediumSquareCrop;

  ProfilePicture({
    required this.smallSquareCrop,
    required this.fullSize,
    required this.thumbnail,
    required this.mediumSquareCrop,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
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
