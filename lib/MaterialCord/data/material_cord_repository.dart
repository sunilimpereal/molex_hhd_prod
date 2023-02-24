import 'dart:developer';

import 'package:molex_hhd/utils/api_requests.dart';

import '../../model_api/materialCoordinator/material_cord_schedule_model.dart';

class MaterialCordRepository {
  Future<List<MaterialCodinatorScheduler>> getMaterialCordScheduelarData() async {
    GetMaterialCordSchedule? materialSchedualr = await ApiRequest<String, GetMaterialCordSchedule>()
        .get(url: "molex/material-codinator/material-codinator-schdeuler-data", reponseFromJson: getMaterialCordScheduleFromJson);
    List<MaterialCodinatorScheduler> scheduleList = materialSchedualr?.data.materialCodinatorSchedulerData ?? [];
    return scheduleList;
  }
}
