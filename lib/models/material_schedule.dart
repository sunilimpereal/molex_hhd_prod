class MaterialSchedule {
  String orderId;
  String fgPart;
  String scheduleId;
  String locationId;
  String totalBin;
  String routeId;
  String status;
  MaterialSchedule(
      {required this.fgPart,
      required this.locationId,
      required this.orderId,
      required this.routeId,
      required this.scheduleId,
      required this.totalBin,
      required this.status});
}

class KittingSchedule {
  String orderId;
  String fgPart;
  String scheduleId;
  String locationId;
  String binId;
  String totalBundles;
  String status;
  KittingSchedule(
      {required this.fgPart,
      required this.locationId,
      required this.orderId,
      required this.binId,
      required this.scheduleId,
      required this.totalBundles,
      required this.status});
}
