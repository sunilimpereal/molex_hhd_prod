// To parse this JSON data, do
//
//     final locationTransfer = locationTransferFromJson(jsonString);

import 'dart:convert';

LocationTransfer locationTransferFromJson(String str) => LocationTransfer.fromJson(json.decode(str));

String locationTransferToJson(LocationTransfer data) => json.encode(data.toJson());

class LocationTransfer {
    LocationTransfer({
        required this.binIdentification,
        required this.binLocation,
        required this.bundleQuantity,
        required this.numberOfBundles,
        required this.finishedGoods,
        required this.lastUseDate,
        required this.binRoute,
        required this.binStatus,
        required this.materialCoordinatorIdentification,
        required this.binHistory,
        required this.binTime,
        required this.scheduledId,
        required this.bundleCreationTime,
        required this.machineIdentification,
        required this.operatorIdentification,
        required this.cablePartNumber,
        required this.cablePartDescription,
        required this.color,
        required this.bundleLocation,
        required this.bundleRoute,
        required this.purchaseOrder,
        required this.orderIdentification,
        required this.cutLength,
        required this.scheduledQuantity,
        required this.bundleRejectedQuantity,
    });

    String binIdentification;
    String binLocation;
    int bundleQuantity;
    int numberOfBundles;
    int finishedGoods;
    DateTime lastUseDate;
    int binRoute;
    String binStatus;
    String materialCoordinatorIdentification;
    DateTime binHistory;
    String binTime;
    int scheduledId;
    DateTime bundleCreationTime;
    String machineIdentification;
    String operatorIdentification;
    int cablePartNumber;
    String cablePartDescription;
    String color;
    String bundleLocation;
    String bundleRoute;
    String purchaseOrder;
    int orderIdentification;
    int cutLength;
    int scheduledQuantity;
    int bundleRejectedQuantity;

    factory LocationTransfer.fromJson(Map<String, dynamic> json) => LocationTransfer(
        binIdentification: json["binIdentification"],
        binLocation: json["binLocation"],
        bundleQuantity: json["bundleQuantity"],
        numberOfBundles: json["numberOfBundles"],
        finishedGoods: json["finishedGoods"],
        lastUseDate: DateTime.parse(json["lastUseDate"]),
        binRoute: json["binRoute"],
        binStatus: json["binStatus"],
        materialCoordinatorIdentification: json["materialCoordinatorIdentification"],
        binHistory: DateTime.parse(json["binHistory"]),
        binTime: json["binTime"],
        scheduledId: json["scheduledId"],
        bundleCreationTime: DateTime.parse(json["bundleCreationTime"]),
        machineIdentification: json["machineIdentification"],
        operatorIdentification: json["operatorIdentification"],
        cablePartNumber: json["cablePartNumber"],
        cablePartDescription: json["cablePartDescription"],
        color: json["color"],
        bundleLocation: json["bundleLocation"],
        bundleRoute: json["bundleRoute"],
        purchaseOrder: json["purchaseOrder"],
        orderIdentification: json["orderIdentification"],
        cutLength: json["cutLength"],
        scheduledQuantity: json["scheduledQuantity"],
        bundleRejectedQuantity: json["bundleRejectedQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "binIdentification": binIdentification,
        "binLocation": binLocation,
        "bundleQuantity": bundleQuantity,
        "numberOfBundles": numberOfBundles,
        "finishedGoods": finishedGoods,
        "lastUseDate": "${lastUseDate.year.toString().padLeft(4, '0')}-${lastUseDate.month.toString().padLeft(2, '0')}-${lastUseDate.day.toString().padLeft(2, '0')}",
        "binRoute": binRoute,
        "binStatus": binStatus,
        "materialCoordinatorIdentification": materialCoordinatorIdentification,
        "binHistory": "${binHistory.year.toString().padLeft(4, '0')}-${binHistory.month.toString().padLeft(2, '0')}-${binHistory.day.toString().padLeft(2, '0')}",
        "binTime": binTime,
        "scheduledId": scheduledId,
        "bundleCreationTime": "${bundleCreationTime.year.toString().padLeft(4, '0')}-${bundleCreationTime.month.toString().padLeft(2, '0')}-${bundleCreationTime.day.toString().padLeft(2, '0')}",
        "machineIdentification": machineIdentification,
        "operatorIdentification": operatorIdentification,
        "cablePartNumber": cablePartNumber,
        "cablePartDescription": cablePartDescription,
        "color": color,
        "bundleLocation": bundleLocation,
        "bundleRoute": bundleRoute,
        "purchaseOrder": purchaseOrder,
        "orderIdentification": orderIdentification,
        "cutLength": cutLength,
        "scheduledQuantity": scheduledQuantity,
        "bundleRejectedQuantity": bundleRejectedQuantity,
    };
}