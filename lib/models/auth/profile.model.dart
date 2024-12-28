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
  dynamic profilePicture;

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
        profilePicture: json["profile_picture"],
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
        "profile_picture": profilePicture,
      };
}
