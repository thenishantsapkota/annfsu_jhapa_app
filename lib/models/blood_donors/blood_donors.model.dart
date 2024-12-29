// To parse this JSON data, do
//
//     final bloodDonors = bloodDonorsFromJson(jsonString);

import 'dart:convert';

BloodDonors bloodDonorsFromJson(String str) =>
    BloodDonors.fromJson(json.decode(str));

String bloodDonorsToJson(BloodDonors data) => json.encode(data.toJson());

class BloodDonors {
  bool success;
  List<Datum> data;
  String message;

  BloodDonors({
    required this.success,
    required this.data,
    required this.message,
  });

  factory BloodDonors.fromJson(Map<String, dynamic> json) => BloodDonors(
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
  String fullName;
  String bloodGroup;
  String district;
  String address;
  String phoneNumber;
  DateTime? dateOfBirth;
  String location;
  String emailAddress;

  Datum({
    required this.id,
    required this.fullName,
    required this.bloodGroup,
    required this.district,
    required this.address,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.location,
    required this.emailAddress,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fullName: json["full_name"],
        bloodGroup: json["blood_group"],
        district: json["district"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        location: json["location"],
        emailAddress: json["email_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "blood_group": bloodGroup,
        "district": district,
        "address": address,
        "phone_number": phoneNumber,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "location": location,
        "email_address": emailAddress,
      };
}
