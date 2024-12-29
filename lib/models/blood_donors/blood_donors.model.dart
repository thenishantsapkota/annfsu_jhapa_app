// To parse this JSON data, do
//
//     final bloodDonors = bloodDonorsFromJson(jsonString);

import 'dart:convert';

BloodDonors bloodDonorsFromJson(String str) =>
    BloodDonors.fromJson(json.decode(str));

String bloodDonorsToJson(BloodDonors data) => json.encode(data.toJson());

class BloodDonors {
  String next;
  dynamic previous;
  Results results;

  BloodDonors({
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BloodDonors.fromJson(Map<String, dynamic> json) => BloodDonors(
        next: json["next"],
        previous: json["previous"],
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
        "results": results.toJson(),
      };
}

class Results {
  List<Datum> data;
  String message;

  Results({
    required this.data,
    required this.message,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int id;
  String fullName;
  BloodGroup bloodGroup;
  String district;
  String address;
  String phoneNumber;
  DateTime? dateOfBirth;
  Location location;
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
        bloodGroup: bloodGroupValues.map[json["blood_group"]]!,
        district: json["district"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        location: locationValues.map[json["location"]]!,
        emailAddress: json["email_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "blood_group": bloodGroupValues.reverse[bloodGroup],
        "district": district,
        "address": address,
        "phone_number": phoneNumber,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "location": locationValues.reverse[location],
        "email_address": emailAddress,
      };
}

enum BloodGroup { O_POS, O_NEG, A_POS, A_NEG, B_POS, B_NEG, AB_POS, AB_NEG }

final bloodGroupValues = EnumValues({
  "O+": BloodGroup.O_POS,
  "O-": BloodGroup.O_NEG,
  "A+": BloodGroup.A_POS,
  "A-": BloodGroup.A_NEG,
  "B+": BloodGroup.B_POS,
  "B-": BloodGroup.B_NEG,
  "AB+": BloodGroup.AB_POS,
  "AB-": BloodGroup.AB_NEG,
});

enum Location { NEPAL, ABROAD }

final locationValues =
    EnumValues({"Nepal": Location.NEPAL, "Abroad": Location.ABROAD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
