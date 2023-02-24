// To parse this JSON data, do
//
//     final errorMsg = errorMsgFromJson(jsonString);

import 'dart:convert';

ErrorMsg errorMsgFromJson(String str) => ErrorMsg.fromJson(json.decode(str));

String errorMsgToJson(ErrorMsg data) => json.encode(data.toJson());

class ErrorMsg {
    ErrorMsg({
        required this.timestamp,
        required this.status,
        required this.error,
        required this.message,
        required this.path,
    });

    DateTime timestamp;
    int status;
    String error;
    String message;
    String path;

    factory ErrorMsg.fromJson(Map<String, dynamic> json) => ErrorMsg(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        error: json["error"],
        message: json["message"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "error": error,
        "message": message,
        "path": path,
    };
}
