// To parse this JSON data, do
//
//     final bundlesResponseModel = bundlesResponseModelFromJson(jsonString);

import 'dart:convert';

BundlesResponseModel bundlesResponseModelFromJson(String str) => BundlesResponseModel.fromJson(json.decode(str));

String bundlesResponseModelToJson(BundlesResponseModel data) => json.encode(data.toJson());

class BundlesResponseModel {
  BundlesResponseModel({
    required this.status,
    required this.statusMsg,
    this.errorCode,
    required this.data,
  });

  String status;
  String statusMsg;
  dynamic errorCode;
  Data data;

  factory BundlesResponseModel.fromJson(Map<String, dynamic> json) => BundlesResponseModel(
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

  List<BundleModel> bundlesRetrieved;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bundlesRetrieved: List<BundleModel>.from(json[" Bundles Retrieved "].map((x) => BundleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        " Bundles Retrieved ": List<dynamic>.from(bundlesRetrieved.map((x) => x.toJson())),
      };
}

class BundleModel {
  BundleModel({
    required this.bundleIdentification,
    required this.scheduledId,
    required this.bundleCreationTime,
    this.bundleUpdateTime,
    required this.bundleQuantity,
    required this.machineIdentification,
    required this.operatorIdentification,
    required this.finishedGoodsPart,
    required this.cablePartNumber,
    this.cablePartDescription,
    required this.cutLengthSpecificationInmm,
    required this.color,
    required this.bundleStatus,
    required this.binId,
    required this.locationId,
    required this.orderId,
    required this.updateFromProcess,
    required this.awg,
    required this.crimpFromSchId,
    required this.crimpToSchId,
    required this.preparationCompleteFlag,
    required this.viCompleted,
  });

  int bundleIdentification;
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

  factory BundleModel.fromJson(Map<String, dynamic> json) => BundleModel(
        bundleIdentification: json["bundleIdentification"],
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
//     final postgetBundleMaster = postgetBundleMasterFromJson(jsonString);

PostgetBundleMaster postgetBundleMasterFromJson(String str) => PostgetBundleMaster.fromJson(json.decode(str));

String postgetBundleMasterToJson(PostgetBundleMaster data) => json.encode(data.toJson());

class PostgetBundleMaster {
  PostgetBundleMaster({
    required this.binId,
    required this.status,
    required this.bundleId,
    required this.location,
    required this.finishedGoods,
    required this.cablePartNumber,
    required this.orderId,
    required this.scheduleId,
  });

  int binId;
  String status;
  String bundleId;
  String location;
  int finishedGoods;
  int cablePartNumber;
  String orderId;
  int scheduleId;

  factory PostgetBundleMaster.fromJson(Map<String, dynamic> json) => PostgetBundleMaster(
        binId: json["binId"],
        status: json["status"],
        bundleId: json["bundleId"],
        location: json["location"],
        finishedGoods: json["finishedGoods"],
        cablePartNumber: json["cablePartNumber"],
        orderId: json["orderId"],
        scheduleId: json["scheduleId"],
      );

  Map<String, dynamic> toJson() => {
        "binId": binId,
        "status": status,
        "bundleId": bundleId,
        "location": location,
        "finishedGoods": finishedGoods,
        "cablePartNumber": cablePartNumber,
        "orderId": orderId,
        "scheduleId": scheduleId,
      };
}
