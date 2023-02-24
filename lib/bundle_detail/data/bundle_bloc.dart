import 'dart:async';

import 'package:flutter/material.dart';
import 'package:molex_hhd/bundle_detail/data/bundle_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/bloc.dart';
import 'bundle_model.dart';

class BundleBloc extends Bloc {
  BuildContext context;
  final BundelRepository _bundelRepository = BundelRepository();
  BundleBloc(this.context) {}

  //grade
  final _bundleController = BehaviorSubject<BundleModel>();
  Stream<BundleModel> get bundleStream => _bundleController.stream.asBroadcastStream();

  Future<bool> getBundle({required String bundleId}) async {
    final result = await _bundelRepository.getBundleDetail(bundleId: bundleId);
    result != null ? _bundleController.sink.add(result) : null;
    return true;
  }

  @override
  void dispose() {
    _bundleController.close();
  }
}

class BundleProvider extends InheritedWidget {
  late BundleBloc bloc;
  BuildContext context;
  BundleProvider({Key? key, required Widget child, required this.context}) : super(key: key, child: child) {
    bloc = BundleBloc(context);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static BundleBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BundleProvider>() as BundleProvider).bloc;
  }
}
