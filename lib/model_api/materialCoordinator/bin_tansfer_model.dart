// To parse this JSON data, do
//
//     final binTransfer = binTransferFromJson(jsonString);

import 'dart:convert';

BinTransfer binTransferFromJson(String str) => BinTransfer.fromJson(json.decode(str));

String binTransferToJson(BinTransfer data) => json.encode(data.toJson());

class BinTransfer {
    BinTransfer({
      required  this.orderId,
      required  this.binId,
      required  this.scheduleId,
      required  this.bundleId,
      required  this.suggestedLocation,
      required  this.location,
      required  this.status,
    });

    int orderId;
    String binId;
    int scheduleId;
    String bundleId;
    String suggestedLocation;
    String location;
    String status;

    factory BinTransfer.fromJson(Map<String, dynamic> json) => BinTransfer(
        orderId: json["orderId"],
        binId: json["binId"],
        scheduleId: json["scheduleId"],
        bundleId: json["bundleId"],
        suggestedLocation: json["suggestedLocation"],
        location: json["location"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "binId": binId,
        "scheduleId": scheduleId,
        "bundleId": bundleId,
        "suggestedLocation": suggestedLocation,
        "location": location,
        "status": status,
    };
}
