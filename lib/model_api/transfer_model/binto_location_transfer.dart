// To parse this JSON data, do
//
//     final transferBinToLocation = transferBinToLocationFromJson(jsonString);

import 'dart:convert';

List<TransferBinToLocation> transferBinToLocationFromJson(String str) => List<TransferBinToLocation>.from(json.decode(str).map((x) => TransferBinToLocation.fromJson(x)));

String transferBinToLocationToJson(List<TransferBinToLocation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferBinToLocation {
    TransferBinToLocation({
         required this.binIdentification,
         required this.bundleId,
         required this.userId,
         required this.locationId,
    });

    String binIdentification;
    String bundleId;
    String userId;
    String locationId;

    factory TransferBinToLocation.fromJson(Map<String, dynamic> json) => TransferBinToLocation(
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
// To parse this JSON data, do
//
//     final responseTransferBinToLocation = responseTransferBinToLocationFromJson(jsonString);


ResponseTransferBinToLocation responseTransferBinToLocationFromJson(String str) => ResponseTransferBinToLocation.fromJson(json.decode(str));

String responseTransferBinToLocationToJson(ResponseTransferBinToLocation data) => json.encode(data.toJson());

class ResponseTransferBinToLocation {
    ResponseTransferBinToLocation({
       required this.status,
       required this.statusMsg,
       required this.errorCode,
       required this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory ResponseTransferBinToLocation.fromJson(Map<String, dynamic> json) => ResponseTransferBinToLocation(
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
       required this.bundleTransferToBinTracking,
    });

    List<BundleTransferToBinTracking> bundleTransferToBinTracking;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bundleTransferToBinTracking: List<BundleTransferToBinTracking>.from(json[" Bundle Transfer to Bin Tracking "].map((x) => BundleTransferToBinTracking.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " Bundle Transfer to Bin Tracking ": List<dynamic>.from(bundleTransferToBinTracking.map((x) => x.toJson())),
    };
}

class BundleTransferToBinTracking {
    BundleTransferToBinTracking({
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
       required  this.crimpFromSchId,
       required  this.crimpToSchId,
       required  this.preparationCompleteFlag,
       required  this.viCompleted,
    });

    int id;
    String bundleIdentification;
    int scheduledId;
    DateTime bundleCreationTime;
    dynamic bundleUpdateTime;
    int bundleQuantity;
    String machineIdentification;
    String operatorIdentification;
    int finishedGoodsPart;
    int cablePartNumber;
    dynamic cablePartDescription;
    int cutLengthSpecificationInmm;
    String color;
    String bundleStatus;
    int binId;
    String locationId;
    String orderId;
    String updateFromProcess;
    String awg;
    String crimpFromSchId;
    String crimpToSchId;
    String preparationCompleteFlag;
    String viCompleted;

    factory BundleTransferToBinTracking.fromJson(Map<String, dynamic> json) => BundleTransferToBinTracking(
        id: json["id"],
        bundleIdentification: json["bundleIdentification"].toString(),
        scheduledId: json["scheduledId"],
        bundleCreationTime: DateTime.parse(json["bundleCreationTime"]),
        bundleUpdateTime: json["bundleUpdateTime"],
        bundleQuantity: json["bundleQuantity"],
        machineIdentification: json["machineIdentification"],
        operatorIdentification: json["operatorIdentification"],
        finishedGoodsPart: json["finishedGoodsPart"],
        cablePartNumber: json["cablePartNumber"],
        cablePartDescription: json["cablePartDescription"],
        cutLengthSpecificationInmm: json["cutLengthSpecificationInmm"],
        color: json["color"],
        bundleStatus: json["bundleStatus"],
        binId: json["binId"],
        locationId: json["locationId"],
        orderId: json["orderId"],
        updateFromProcess: json["updateFromProcess"],
        awg: json["awg"],
        crimpFromSchId: json["crimpFromSchId"],
        crimpToSchId: json["crimpToSchId"],
        preparationCompleteFlag: json["preparationCompleteFlag"],
        viCompleted: json["viCompleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bundleIdentification": bundleIdentification,
        "scheduledId": scheduledId,
        "bundleCreationTime": bundleCreationTime.toIso8601String(),
        "bundleUpdateTime": bundleUpdateTime,
        "bundleQuantity": bundleQuantity,
        "machineIdentification": machineIdentification,
        "operatorIdentification": operatorIdentification,
        "finishedGoodsPart": finishedGoodsPart,
        "cablePartNumber": cablePartNumber,
        "cablePartDescription": cablePartDescription,
        "cutLengthSpecificationInmm": cutLengthSpecificationInmm,
        "color": color,
        "bundleStatus": bundleStatus,
        "binId": binId,
        "locationId": locationId,
        "orderId": orderId,
        "updateFromProcess": updateFromProcess,
        "awg": awg,
        "crimpFromSchId": crimpFromSchId,
        "crimpToSchId": crimpToSchId,
        "preparationCompleteFlag": preparationCompleteFlag,
        "viCompleted": viCompleted,
    };
}


// To parse this JSON data, do
//
//     final errorTransferBinToLocation = errorTransferBinToLocationFromJson(jsonString);



ErrorTransferBinToLocation errorTransferBinToLocationFromJson(String str) => ErrorTransferBinToLocation.fromJson(json.decode(str));

String errorTransferBinToLocationToJson(ErrorTransferBinToLocation data) => json.encode(data.toJson());

class ErrorTransferBinToLocation {
    ErrorTransferBinToLocation({
      required  this.status,
      required  this.statusMsg,
      required  this.errorCode,
      required  this.data,
    });

    String status;
    String statusMsg;
    String errorCode;
    Data1 data;

    factory ErrorTransferBinToLocation.fromJson(Map<String, dynamic> json) => ErrorTransferBinToLocation(
        status: json["status"],
        statusMsg: json["statusMsg"],
        errorCode: json["errorCode"],
        data: Data1.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusMsg": statusMsg,
        "errorCode": errorCode,
        "data": data.toJson(),
    };
}

class Data1 {
    Data1();

    factory Data1.fromJson(Map<String, dynamic> json) => Data1(
    );

    Map<String, dynamic> toJson() => {
    };
}
