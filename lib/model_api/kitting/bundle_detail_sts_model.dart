// To parse this JSON data, do
//
//     final bundleDetailSts = bundleDetailStsFromJson(jsonString);

import 'dart:convert';

BundleDetailSts bundleDetailStsFromJson(String str) => BundleDetailSts.fromJson(json.decode(str));

String bundleDetailStsToJson(BundleDetailSts data) => json.encode(data.toJson());

class BundleDetailSts {
    BundleDetailSts({
       required this.status,
       required this.statusMsg,
       required this.errorCode,
       required this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory BundleDetailSts.fromJson(Map<String, dynamic> json) => BundleDetailSts(
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
       required this.bundlesRetrieved,
    });

    List<BundlesRetrieved> bundlesRetrieved;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bundlesRetrieved: List<BundlesRetrieved>.from(json[" Bundles Retrieved "].map((x) => BundlesRetrieved.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " Bundles Retrieved ": List<dynamic>.from(bundlesRetrieved.map((x) => x.toJson())),
    };
}

class BundlesRetrieved {
    BundlesRetrieved({
      required  this.id,
      required  this.bundleIdentification,
      required  this.scheduledId,
      required  this.bundleCreationTime,
      required  this.bundleUpdateTime,
      required  this.bundleQuantity,
      required  this.machineIdentification,
      required  this.operatorIdentification,
      required  this.finishedGoodsPart,
      required  this.cablePartNumber,
      required  this.cablePartDescription,
      required  this.cutLengthSpecificationInmm,
      required  this.color,
      required  this.bundleStatus,
      required  this.binId,
      required  this.locationId,
      required  this.orderId,
      required  this.updateFromProcess,
      required  this.awg,
    });

    int id;
    String bundleIdentification;
    int scheduledId;
    DateTime bundleCreationTime;
    String bundleUpdateTime;
    int bundleQuantity;
    String machineIdentification;
    String operatorIdentification;
    int finishedGoodsPart;
    int cablePartNumber;
    String cablePartDescription;
    int cutLengthSpecificationInmm;
    String color;
    String bundleStatus;
    int binId;
    String locationId;
    String orderId;
    String updateFromProcess;
    String awg;

    factory BundlesRetrieved.fromJson(Map<String, dynamic> json) => BundlesRetrieved(
        id: json["id"],
        bundleIdentification: json["bundleIdentification"].toString(),
        scheduledId: json["scheduledId"] == null ? null : json["scheduledId"],
        bundleCreationTime: DateTime.parse(json["bundleCreationTime"]),
        bundleUpdateTime: json["bundleUpdateTime"],
        bundleQuantity: json["bundleQuantity"],
        machineIdentification: json["machineIdentification"],
        operatorIdentification: json["operatorIdentification"] == null ? null : json["operatorIdentification"],
        finishedGoodsPart: json["finishedGoodsPart"],
        cablePartNumber: json["cablePartNumber"],
        cablePartDescription: json["cablePartDescription"],
        cutLengthSpecificationInmm: json["cutLengthSpecificationInmm"],
        color: json["color"],
        bundleStatus: json["bundleStatus"],
        binId: json["binId"],
        locationId: json["locationId"] == null ? null : json["locationId"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        updateFromProcess: json["updateFromProcess"] == null ? null : json["updateFromProcess"],
        awg: json["awg"] == null ? null : json["awg"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bundleIdentification": bundleIdentification,
        "scheduledId": scheduledId == null ? null : scheduledId,
        "bundleCreationTime": "${bundleCreationTime.year.toString().padLeft(4, '0')}-${bundleCreationTime.month.toString().padLeft(2, '0')}-${bundleCreationTime.day.toString().padLeft(2, '0')}",
        "bundleUpdateTime": bundleUpdateTime,
        "bundleQuantity": bundleQuantity,
        "machineIdentification": machineIdentification,
        "operatorIdentification": operatorIdentification == null ? null : operatorIdentification,
        "finishedGoodsPart": finishedGoodsPart,
        "cablePartNumber": cablePartNumber,
        "cablePartDescription": cablePartDescription,
        "cutLengthSpecificationInmm": cutLengthSpecificationInmm,
        "color": color,
        "bundleStatus": bundleStatus,
        "binId": binId,
        "locationId": locationId == null ? null : locationId,
        "orderId": orderId == null ? null : orderId,
        "updateFromProcess": updateFromProcess == null ? null : updateFromProcess,
        "awg": awg == null ? null : awg,
    };
}

