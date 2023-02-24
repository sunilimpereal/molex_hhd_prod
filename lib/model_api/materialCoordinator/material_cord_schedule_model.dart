// To parse this JSON data, do
//
//     final getMaterialCordSchedule = getMaterialCordScheduleFromJson(jsonString);

import 'dart:convert';

GetMaterialCordSchedule getMaterialCordScheduleFromJson(String str) => GetMaterialCordSchedule.fromJson(json.decode(str));

String getMaterialCordScheduleToJson(GetMaterialCordSchedule data) => json.encode(data.toJson());

class GetMaterialCordSchedule {
    GetMaterialCordSchedule({
      required  this.status,
      required  this.statusMsg,
      required  this.errorCode,
      required  this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetMaterialCordSchedule.fromJson(Map<String, dynamic> json) => GetMaterialCordSchedule(
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
      required  this.materialCodinatorSchedulerData,
    });

    List<MaterialCodinatorScheduler> materialCodinatorSchedulerData;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        materialCodinatorSchedulerData: List<MaterialCodinatorScheduler>.from(json["  Material Codinator Scheduler Data "].map((x) => MaterialCodinatorScheduler.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "  Material Codinator Scheduler Data ": List<dynamic>.from(materialCodinatorSchedulerData.map((x) => x.toJson())),
    };
}

class MaterialCodinatorScheduler {
    MaterialCodinatorScheduler({
      required  this.orderId,
      required  this.fgNo,
      required  this.location,
      required  this.totalBundle,
      required  this.routeId,
      required  this.status,
      required  this.binId,
      required  this.scheduleId,
    });

    String orderId;
    String fgNo;
    String location;
    String totalBundle;
    String routeId;
    String status;
    String binId;
    String scheduleId;

    factory MaterialCodinatorScheduler.fromJson(Map<String, dynamic> json) => MaterialCodinatorScheduler(
        orderId: json["orderID"],
        fgNo: json["fgNo"],
        location: json["location"],
        totalBundle: json["totalBundle"],
        routeId: json["routeId"],
        status: json["status"],
        binId: json["binId"],
        scheduleId: json["scheduleId"],
    );

    Map<String, dynamic> toJson() => {
        "orderID": orderId,
        "fgNo": fgNo,
        "location": location,
        "totalBundle": totalBundle,
        "routeId": routeId,
        "status": status,
        "binId": binId,
        "scheduleId": scheduleId,
    };
}






