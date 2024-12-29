// To parse this JSON data, do
//
//     final members = membersFromJson(jsonString);

import 'dart:convert';

Members membersFromJson(String str) => Members.fromJson(json.decode(str));

String membersToJson(Members data) => json.encode(data.toJson());

class Members {
  bool success;
  List<Datum> data;
  String message;

  Members({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Members.fromJson(Map<String, dynamic> json) => Members(
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
  String email;
  String fullName;
  String gender;
  String bloodGroup;
  String contactNumber;
  String address;
  String collegeName;
  String position;
  String? profilePicture;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
