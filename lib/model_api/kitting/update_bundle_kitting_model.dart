// To parse this JSON data, do
//
//     final updateBundleKitting = updateBundleKittingFromJson(jsonString);

import 'dart:convert';

List<UpdateBundleKitting> updateBundleKittingFromJson(String str) =>
    List<UpdateBundleKitting>.from(json.decode(str).map((x) => UpdateBundleKitting.fromJson(x)));

String updateBundleKittingToJson(List<UpdateBundleKitting> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateBundleKitting {
  UpdateBundleKitting({
    required this.binIdentification,
    required this.bundleId,
    required this.userId,
    required this.locationId,
    this.quantity = "",
  });

  String binIdentification;
  String bundleId;
  String userId;
  String locationId;
  String quantity;

  factory UpdateBundleKitting.fromJson(Map<String, dynamic> json) => UpdateBundleKitting(
        binIdentification: json["binIdentification"],
        bundleId: json["bundleId"],
        userId: json["userId"],
        locationId: json["locationId"],
      );

  Map<String, dynamic> toJson() => {
        "binIdentification": binIdentification,
        "bundleId": bundleId,
        "userId": userId,
        "locationId": locationId,
      };
}
