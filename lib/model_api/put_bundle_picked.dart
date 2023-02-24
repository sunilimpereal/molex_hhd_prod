// To parse this JSON data, do
//
//     final putBundlePicked = putBundlePickedFromJson(jsonString);

import 'dart:convert';

List<PutBundlePicked> putBundlePickedListFromJson(String str) => List<PutBundlePicked>.from(json.decode(str).map((x) => PutBundlePicked.fromJson(x)));

String putBundlePickedListToJson(List<PutBundlePicked> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PutBundlePicked {
    PutBundlePicked({
       required this.binIdentification,
       required this.bundleId,
       required this.userId,
       required this.locationId,
    });

    String binIdentification;
    String bundleId;
    String userId;
    String locationId;

    factory PutBundlePicked.fromJson(Map<String, dynamic> json) => PutBundlePicked(
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
