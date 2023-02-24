// To parse this JSON data, do
//
//     final updateBundleTransfer = updateBundleTransferFromJson(jsonString);

import 'dart:convert';

List<UpdateBundleTransfer> updateBundleTransferFromJson(String str) => List<UpdateBundleTransfer>.from(json.decode(str).map((x) => UpdateBundleTransfer.fromJson(x)));

String updateBundleTransferToJson(List<UpdateBundleTransfer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateBundleTransfer {
    UpdateBundleTransfer({
        required this.binIdentification,
        required this.bundleId,
        required this.userId,
        required this.locationId,
    });

    String binIdentification;
    String bundleId;
    String userId;
    String locationId;

    factory UpdateBundleTransfer.fromJson(Map<String, dynamic> json) => UpdateBundleTransfer(
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
