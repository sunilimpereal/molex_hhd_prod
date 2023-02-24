// To parse this JSON data, do
//
//     final postKittingIssuance = postKittingIssuanceFromJson(jsonString);

import 'dart:convert';

List<PostKittingIssuance> postKittingIssuanceFromJson(String str) =>
    List<PostKittingIssuance>.from(json.decode(str).map((x) => PostKittingIssuance.fromJson(x)));

String postKittingIssuanceToJson(List<PostKittingIssuance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostKittingIssuance {
  PostKittingIssuance({
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
    required this.suggetedScheduledQty,
    required this.suggestedActualQty,
    required this.suggestedBinLocation,
    required this.suggestedBundleId,
    required this.suggestedBundleQty,
    required this.status,
    required this.userId,
  });

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
  List<String> bundleId;
  int bundleQty;
  int suggetedScheduledQty;
  int suggestedActualQty;
  String suggestedBinLocation;
  String suggestedBundleId;
  int suggestedBundleQty;
  String status;
  String userId;

  factory PostKittingIssuance.fromJson(Map<String, dynamic> json) => PostKittingIssuance(
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
        bundleId: List<String>.from(json["bundleId"].map((x) => x)),
        bundleQty: json["bundleQty"],
        suggetedScheduledQty: json["SuggetedScheduledQty"],
        suggestedActualQty: json["suggestedActualQty"],
        suggestedBinLocation: json["SuggestedBinLocation"],
        suggestedBundleId: json["suggestedBundleId"],
        suggestedBundleQty: json["suggestedBundleQty"],
        status: json["status"],
        userId: json["dispatchedBy"],
      );

  Map<String, dynamic> toJson() => {
        "fgPartNumber": fgPartNumber,
        "orderId": int.parse(orderId),
        "cablePartNumber": int.parse(cablePartNumber),
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
        "bundleId": List<dynamic>.from(bundleId.map((x) => x)),
        "bundleQty": bundleQty,
        "SuggetedScheduledQty": suggetedScheduledQty,
        "suggestedActualQty": suggestedActualQty,
        "SuggestedBinLocation": suggestedBinLocation,
        "suggestedBundleId": suggestedBundleId,
        "suggestedBundleQty": suggestedBundleQty,
        "status": status,
        "dispatchedBy": userId,
      };
}



// // To parse this JSON data, do
// //
// //     final postKittingIssuance = postKittingIssuanceFromJson(jsonString);

// import 'dart:convert';

// List<PostKittingIssuance> postKittingIssuanceFromJson(String str) => List<PostKittingIssuance>.from(json.decode(str).map((x) => PostKittingIssuance.fromJson(x)));

// String postKittingIssuanceToJson(List<PostKittingIssuance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class PostKittingIssuance {
//     PostKittingIssuance({
//         this.fgPartNumber,
//         this.orderId,
//         this.cablePartNumber,
//         this.cableType,
//         this.length,
//         this.wireCuttingColor,
//         this.average,
//         this.customerName,
//         this.routeMaster,
//         this.scheduledQty,
//         this.actualQty,
//         this.binId,
//         this.binLocation,
//         this.bundleId,
//         this.bundleQty,
//         this.suggetedScheduledQty,
//         this.suggestedActualQty,
//         this.suggestedBinLocation,
//         this.suggestedBundleId,
//         this.suggestedBundleQty,
//         this.status,
//     });

//     int fgPartNumber;
//     int orderId;
//     int cablePartNumber;
//     String cableType;
//     int length;
//     String wireCuttingColor;
//     int average;
//     String customerName;
//     String routeMaster;
//     int scheduledQty;
//     int actualQty;
//     String binId;
//     String binLocation;
//     List<String> bundleId;
//     int bundleQty;
//     int suggetedScheduledQty;
//     int suggestedActualQty;
//     String suggestedBinLocation;
//     String suggestedBundleId;
//     int suggestedBundleQty;
//     String status;

//     factory PostKittingIssuance.fromJson(Map<String, dynamic> json) => PostKittingIssuance(
//         fgPartNumber: json["fgPartNumber"],
//         orderId: json["orderId"],
//         cablePartNumber: json["cablePartNumber"],
//         cableType: json["cableType"],
//         length: json["length"],
//         wireCuttingColor: json["wireCuttingColor"],
//         average: json["average"],
//         customerName: json["customerName"],
//         routeMaster: json["routeMaster"],
//         scheduledQty: json["scheduledQty"],
//         actualQty: json["actualQty"],
//         binId: json["binId"],
//         binLocation: json["binLocation"],
//         bundleId: List<String>.from(json["bundleId"].map((x) => x)),
//         bundleQty: json["bundleQty"],
//         suggetedScheduledQty: json["SuggetedScheduledQty"],
//         suggestedActualQty: json["suggestedActualQty"],
//         suggestedBinLocation: json["SuggestedBinLocation"],
//         suggestedBundleId: json["suggestedBundleId"],
//         suggestedBundleQty: json["suggestedBundleQty"],
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fgPartNumber": fgPartNumber,
//         "orderId": orderId,
//         "cablePartNumber": cablePartNumber,
//         "cableType": cableType,
//         "length": length,
//         "wireCuttingColor": wireCuttingColor,
//         "average": average,
//         "customerName": customerName,
//         "routeMaster": routeMaster,
//         "scheduledQty": scheduledQty,
//         "actualQty": actualQty,
//         "binId": binId,
//         "binLocation": binLocation,
//         "bundleId": List<dynamic>.from(bundleId.map((x) => x)),
//         "bundleQty": bundleQty,
//         "SuggetedScheduledQty": suggetedScheduledQty,
//         "suggestedActualQty": suggestedActualQty,
//         "SuggestedBinLocation": suggestedBinLocation,
//         "suggestedBundleId": suggestedBundleId,
//         "suggestedBundleQty": suggestedBundleQty,
//         "status": status,
//     };
// }
