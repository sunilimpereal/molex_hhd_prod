// To parse this JSON data, do
//
//     final getKittingAll = getKittingAllFromJson(jsonString);

import 'dart:convert';

GetKittingAll getKittingAllFromJson(String str) => GetKittingAll.fromJson(json.decode(str));

String getKittingAllToJson(GetKittingAll data) => json.encode(data.toJson());

class GetKittingAll {
  GetKittingAll({
    required this.status,
    required this.statusMsg,
    required this.errorCode,
    required this.data,
  });

  String status;
  String statusMsg;
  dynamic errorCode;
  Data data;

  factory GetKittingAll.fromJson(Map<String, dynamic> json) => GetKittingAll(
        status: json["status"],
        statusMsg: json["statusMsg"],
        errorCode: json["errorCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusMsg": statusMsg,
        "errorCode": errorCode,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.kittingDetail,
  });

  List<KittingDetail> kittingDetail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        kittingDetail:
            List<KittingDetail>.from(json["Kitting Detail"].map((x) => KittingDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Kitting Detail": List<dynamic>.from(kittingDetail.map((x) => x.toJson())),
      };
}

class KittingDetail {
  KittingDetail({
    required this.kittingIssuance,
    required this.bundleList,
  });

  KittingIssuance kittingIssuance;
  List<BundleList> bundleList;

  factory KittingDetail.fromJson(Map<String, dynamic> json) => KittingDetail(
        kittingIssuance: KittingIssuance.fromJson(json["kittingIssuance"]),
        bundleList:json["bundleList"]==null? [] : List<BundleList>.from(json["bundleList"].map((x) => BundleList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kittingIssuance": kittingIssuance.toJson(),
        "bundleList": List<dynamic>.from(bundleList.map((x) => x.toJson())),
      };
}

class BundleList {
  BundleList(
      {required this.id,
      required this.fgPartNumber,
      required this.orderId,
      required this.cablePartNumber,
      required this.cableType,
      required this.length,
      required this.wireCuttingColor,
      required this.average,
      required this.bundleId,
      required this.binId,
      required this.binLocation,
      
      this.bundleQuantity});

  int id;
  int fgPartNumber;
  String orderId;
  String cablePartNumber;
  String cableType;
  int length;
  String wireCuttingColor;
  int average;
  String bundleId;
  String binId;
  String binLocation;
  int? bundleQuantity = 0;

  factory BundleList.fromJson(Map<String, dynamic> json) => BundleList(
        id: json["id"],
        fgPartNumber: json["fgPartNumber"],
        orderId: json["orderId"],
        cablePartNumber: json["cablePartNumber"],
        cableType: json["cableType"],
        length: json["length"],
        wireCuttingColor: json["wireCuttingColor"],
        average: json["average"],
        bundleId: json["bundleId"],
        binId: json["binId"],
        binLocation: json["binLocation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fgPartNumber": fgPartNumber,
        "orderId": orderId,
        "cablePartNumber": cablePartNumber,
        "cableType": cableType,
        "length": length,
        "wireCuttingColor": wireCuttingColor,
        "average": average,
        "bundleId": bundleId,
        "binId": binId,
        "binLocation": binLocation,
      };
}

class KittingIssuance {
  KittingIssuance({
    required this.id,
    required this.fgPartNumber,
    required this.orderId,
    required this.cablePartNumber,
    required this.cableType,
    required this.length,
    required this.wireCuttingColor,
    required this.average,
    required this.customerName,
    required this.routeMaster,
    required this.scheduledQty,
    required this.actualQty,
    required this.binId,
    required this.binLocation,
    required this.bundleId,
    required this.bundleQty,
    required this.suggestedActualQty,
    required this.suggestedBundleId,
    required this.suggestedBundleQty,
    required this.status,
    required this.suggetedScheduledQty,
    required this.suggestedBinLocation,
    this.cutLength,
  });

  int id;
  int fgPartNumber;
  String orderId;
  String cablePartNumber;
  String cableType;
  int length;
  String wireCuttingColor;
  int average;
  String customerName;
  String routeMaster;
  int scheduledQty;
  int actualQty;
  String binId;
  String binLocation;
  String bundleId;
  int bundleQty;
  dynamic suggestedActualQty;
  dynamic suggestedBundleId;
  int suggestedBundleQty;
  String status;
  dynamic suggetedScheduledQty;
  dynamic suggestedBinLocation;
  String? cutLength = "";

  factory KittingIssuance.fromJson(Map<String, dynamic> json) => KittingIssuance(
        id: json["id"],
        fgPartNumber: json["fgPartNumber"],
        orderId: json["orderId"],
        cablePartNumber: json["cablePartNumber"],
        cableType: json["cableType"],
        length: json["length"],
        wireCuttingColor: json["wireCuttingColor"],
        average: json["average"],
        customerName: json["customerName"],
        routeMaster: json["routeMaster"],
        scheduledQty: json["scheduledQty"],
        actualQty: json["actualQty"],
        binId: json["binId"],
        binLocation: json["binLocation"],
        bundleId: json["bundleId"],
        bundleQty: json["bundleQty"],
        suggestedActualQty: json["suggestedActualQty"],
        suggestedBundleId: json["suggestedBundleId"],
        suggestedBundleQty: json["suggestedBundleQty"],
        status: json["status"],
        suggetedScheduledQty: json["suggetedScheduledQty"],
        suggestedBinLocation: json["suggestedBinLocation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fgPartNumber": fgPartNumber,
        "orderId": orderId,
        "cablePartNumber": cablePartNumber,
        "cableType": cableType,
        "length": length,
        "wireCuttingColor": wireCuttingColor,
        "average": average,
        "customerName": customerName,
        "routeMaster": routeMaster,
        "scheduledQty": scheduledQty,
        "actualQty": actualQty,
        "binId": binId,
        "binLocation": binLocation,
        "bundleId": bundleId,
        "bundleQty": bundleQty,
        "suggestedActualQty": suggestedActualQty,
        "suggestedBundleId": suggestedBundleId,
        "suggestedBundleQty": suggestedBundleQty,
        "status": status,
        "suggetedScheduledQty": suggetedScheduledQty,
        "suggestedBinLocation": suggestedBinLocation,
      };
}
