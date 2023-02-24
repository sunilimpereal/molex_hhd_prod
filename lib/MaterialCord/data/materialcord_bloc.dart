import 'dart:async';

import 'package:flutter/material.dart';
import 'package:molex_hhd/MaterialCord/data/material_cord_repository.dart';
import 'package:molex_hhd/model_api/materialCoordinator/material_cord_schedule_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/bloc.dart';

class MaterialCordBloc extends Bloc {
  BuildContext context;
  final MaterialCordRepository _materialCordRepository = MaterialCordRepository();
  MaterialCordBloc(this.context) {
    getMaterialCordScheduler();
  }

  //grade
  final _materialCordSchedulerController = BehaviorSubject<List<MaterialCodinatorScheduler>>();
  Stream<List<MaterialCodinatorScheduler>> get materialCordSchedulerStream => _materialCordSchedulerController.stream.asBroadcastStream();

  Future<bool> getMaterialCordScheduler() async {
    final result = await _materialCordRepository.getMaterialCordScheduelarData();
    _materialCordSchedulerController.sink.add(result);
    return result.isEmpty ? false : true;
  }

  @override
  void dispose() {
    _materialCordSchedulerController.close();
  }
}

class MaterialCordProvider extends InheritedWidget {
  late MaterialCordBloc bloc;
  BuildContext context;
  MaterialCordProvider({Key? key, required Widget child, required this.context}) : super(key: key, child: child) {
    bloc = MaterialCordBloc(context);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static MaterialCordBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MaterialCordProvider>() as MaterialCordProvider).bloc;
  }
}
