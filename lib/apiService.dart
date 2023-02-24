// ignore_for_file: unused_local_variable, avoid_print, unnecessary_string_interpolations, file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'KittingIssance/models/kitting_put_model.dart';
import 'model_api/get_bin_detail.dart';
import 'model_api/kitting/bundle_detail_sts_model.dart';
import 'model_api/kitting/kittingall_model.dart';
import 'model_api/kitting/post_kitting_issuance.dart';
import 'model_api/kitting/update_bundle_kitting_model.dart';
import 'model_api/kitting/update_bundle_transfer_model.dart';
import 'model_api/login_model.dart';
import 'model_api/materialCoordinator/material_cord_schedule_model.dart';
import 'package:http/http.dart' as http;
import 'model_api/put_bundle_picked.dart';
import 'models/errormsg_model.dart';
import 'utils/shared_pref.dart';

import 'model_api/transfer_model/bin_to_bundle_model.dart';
import 'model_api/transfer_model/binto_location_transfer.dart';
import 'model_api/transfer_model/get_bundle_master.dart';

SharedPref sharedPref = new SharedPref();

class ApiService {
  String baseUrl = "${sharedPref.baseIp}";

  // String baseUrl = "http://justerp.in:8080/wipts/";
  // String baseUrl = "http://192.168.1.252:8080/wipts/";
  //  String baseUrl = "http://10.221.46.8:8080/wipts/";

  // String baseUrl = 'http://mlxbngvwqwip01.molex.com:8080/wipts/';
  Map<String, String> headerList = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    "Keep-Alive": "timeout=0",
  };

  Future<Employee?> empIdlogin(String empId) async {
    var url = Uri.parse(baseUrl + "molex/employee/get-employee-list/empid=$empId");
    var response = await http.get(url);
    print('Login  status Code ${response.statusCode}');
    if (response.statusCode == 200) {
      // try {
      Login login = loginFromJson(response.body);
      Employee empolyee = login.data.employeeList;
      return empolyee;
      // } catch (e) {
      //   print('err');
      //   return null;
      // }
    } else {
      return null;
    }
  }

//369200603
  // Future<List<MaterialCodinatorScheduler>> getMaterialCordScheduelarData() async {
  //   print("called api");
  //   var url = Uri.parse(baseUrl + "molex/material-codinator/material-codinator-schdeuler-data");
  //   var response = await http.get(url);
  //   log('Material schedular data ${response.body}');
  //   if (response.statusCode == 200) {
  //     GetMaterialCordSchedule materialSchedualr = getMaterialCordScheduleFromJson(response.body);
  //     log(response.body);
  //     List<MaterialCodinatorScheduler> scheduleList = materialSchedualr.data.materialCodinatorSchedulerData;
  //     return scheduleList;
  //   } else {
  //     return [];
  //   }
  // }

  //Get Bundle Detail
  Future<List<BundleDetail>?> getBinDetail(String binId) async {
    var url = Uri.parse(baseUrl + "molex/material-codinator/material-codinator-ytbp-data?binId=$binId");
    var response = await http.get(url);
    log('getBinDetail  status Code ${response.statusCode}');
    log('getBinDetail  status Code ${response.body}');
    if (response.statusCode == 200) {
      try {
        GetBinDetail getBinDetail = getBinDetailFromJson(response.body);
        List<BundleDetail> bundleList = getBinDetail.data.materialCodinatorSchedulerData;
        return bundleList;
      } catch (e) {
        print('$e');
        return null;
      }
    } else {
      return null;
    }
  }

  //Get Picked Bundle Detail
  Future<List<BundleDetail>?> getPickedBundleDetail(String binId) async {
    var url = Uri.parse(baseUrl + "molex/material-codinator/material-codinator-picked-data?binId=$binId");
    var response = await http.get(url);
    print('getPickedBundleDetail status Code ${response.statusCode}');
    if (response.statusCode == 200) {
      try {
        GetBinDetail getBinDetail = getBinDetailFromJson(response.body);
        List<BundleDetail> bundleList = getBinDetail.data.materialCodinatorSchedulerData;
        return bundleList;
      } catch (e) {
        print('err');
        return null;
      }
    } else {
      Fluttertoast.showToast(
          msg: "Bundles not found in Bin",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  //Update bundle status as picked
  Future<bool> pickedBundle(List<PutBundlePicked> bundleLIst) async {
    var url = Uri.parse(baseUrl + "molex/material-codinator/update-bundle-picked");
    var response = await http.put(url, body: putBundlePickedListToJson(bundleLIst), headers: headerList);
    log(' Post pickedBundle data status code ${response.statusCode}');
    log(' Post pickedBundle data body ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //Update bundle status as droped
  Future<bool> dropBundles(List<PutBundlePicked> bundleList) async {
    var url = Uri.parse(baseUrl + "molex/material-codinator/update-bundle-dropped");
    var response = await http.put(url, body: putBundlePickedListToJson(bundleList), headers: headerList);
    log(' dropBundles data status code ${putBundlePickedListToJson(bundleList)}');
    log(' dropBundles data status code ${response.statusCode}');
    log(' dropBundles data body ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<BundleDetail>?> getBundlesinBin(String binId) async {
    var url = Uri.parse(baseUrl + 'molex/material-codinator/material-codinator-ytbp-data?binId=$binId');
    var response = await http.get(url);
    log('Get Bundles From Bin status Code: ${response.statusCode}');
    log('Get Bundles From Bin  response body :${response.body}');
    if (response.statusCode == 200) {
      GetBinDetail getBinDetail = getBinDetailFromJson(response.body);
      List<BundleDetail> bundleList = getBinDetail.data.materialCodinatorSchedulerData;
      return bundleList;
    } else {
      Fluttertoast.showToast(
        msg: "Unable to Find Bin",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  //  localhost:9090/molex/bundlemaster?binId=1013&status=dropped
  //get bund;les in bin depending on status
  // {"binId":12004,"status":"Dropped","bundleId":"","location":"","finishedGoods":0,"cablePartNumber":0,"orderId":""}
  Future<List<BundlesRetrieved>?> getBundlesinBinStatus(PostgetBundleMaster postgetBundleMaster) async {
    log(' URL /molex/bundlemaster/');
    var url = Uri.parse(baseUrl + 'molex/bundlemaster');
    var response = await http.post(url, body: postgetBundleMasterToJson(postgetBundleMaster), headers: headerList);
    log('Get Bundles From Bins Status status Code: ${postgetBundleMasterToJson(postgetBundleMaster)}');
    log('Get Bundles From Bins Status status Code: ${response.statusCode}');
    log('Get Bundles From Bins  Status response body :${response.body}');
    if (response.statusCode == 200) {
      BundleDetailSts getBinDetail = bundleDetailStsFromJson(response.body);
      List<BundlesRetrieved> bundleList = getBinDetail.data.bundlesRetrieved;
      if (bundleList.length == 0) {
        Fluttertoast.showToast(
          msg: "No Bundles in BIN",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      return bundleList;
    } else {
      Fluttertoast.showToast(
        msg: "Unable to Find Bin",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

//   //Post Material Schedule
//   Future<bool> binTransferCarry(List<PutBundlePicked> bundlePickedList) async {
//     print("called api");
//     var url = Uri.parse(baseUrl + "molex/material-codinator/update-bundle-picked?bundleId=1234");
//     var response = await http.put(url,
//         body: putBundlePickedListToJson(bundlePickedList), headers: headerList);
//     print(' binTransferCarry data status code ${response.statusCode}');
//     print(' binTransferCarry body ${response.body}');
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }

  //Get Bin Detail
  Future<List<BundleDetail>?> getBindetail(String binId) async {
    var url = Uri.parse(baseUrl + "molex/material-codinator/material-codinator-picked-data?binId=$binId");
    var response = await http.get(url);
    log('getPickedBundleDetail status Code ${response.statusCode}');
    log('getPickedBundleDetail status Code ${response.body}');
    if (response.statusCode == 200) {
      try {
        GetBinDetail getBinDetail = getBinDetailFromJson(response.body);
        List<BundleDetail> bundleList = getBinDetail.data.materialCodinatorSchedulerData;
        return bundleList;
      } catch (e) {
        print('err');
        return null;
      }
    } else {
      return null;
    }
  }
  //Kitting Coordinator

  // UpdateKitting Bundle transfer
  //Update bundle status as picked
  Future<bool> updateBundleKittingTransfer(List<UpdateBundleTransfer> bundleLIst) async {
    var url = Uri.parse(baseUrl + "molex/material-codinator/update-bundle-transfer");
    var response = await http.put(url, body: updateBundleTransferToJson(bundleLIst), headers: headerList);
    log(' Post UpdateBundleTransfer data status code ${response.statusCode}');
    log(' Post UpdateBundleTransfer data body ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      Fluttertoast.showToast(
        msg: "Update bundle Transfer Status ${response.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  // /molex/material-codinator/update-bundle-transfer
  // /molex/material-codinator/update-bundle-kitting
  Future<bool> updateBundleKitting(List<UpdateBundleKitting> bundleLIst) async {
    var url = Uri.parse(baseUrl + "molex/material-codinator/update-bundle-kitting");
    log(' Post UpdateBundleKitting data P body ${updateBundleKittingToJson(bundleLIst)}');
    var response = await http.put(url, body: updateBundleKittingToJson(bundleLIst), headers: headerList);
    log(' Post UpdateBundleKitting data status code ${response.statusCode}');
    log(' Post UpdateBundleKitting data body ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      Fluttertoast.showToast(
        msg: "Update bundle Transfer Status ${response.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

// /molex/bundlemaster/binid/{binid}/status/{status}

//Get kitting issuance list
  Future<List<KittingDetail>> getKittingIssuanceList() async {
    print("called kitting issuance api");
    var url = Uri.parse(baseUrl + "molex/kitting/all");
    var response = await http.get(url);
    log('Kitting issuance schedular data ${url} ${response.body}');
    if (response.statusCode == 200) {
      try {
        GetKittingAll kittingAll = getKittingAllFromJson(response.body);
        print(response.body);
        List<KittingDetail> scheduleList = kittingAll.data.kittingDetail;
        return scheduleList;
      } catch (e) {
        log(e.toString());
        Fluttertoast.showToast(
          msg: "Get kitting failed $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return [];
      }
    } else {
      return [];
    }
  }

  //Post Kitting Issuance
  Future<bool> postKittingIssunce(List<PostKittingIssuance> postKittingIssuance) async {
    log(postKittingIssuanceToJson(postKittingIssuance));
    var url = Uri.parse(baseUrl + "molex/kitting");
    var response = await http.put(url, body: postKittingIssuanceToJson(postKittingIssuance), headers: headerList);
    log(' post Kitting issunace data post body ${postKittingIssuanceToJson(postKittingIssuance)}');
    log(' post Kitting issunace data status code ${response.statusCode}');
    log('  post Kitting issunace datadata body ${response.body}');
    if (response.statusCode == 200) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          Fluttertoast.showToast(
            msg: " post Kitting issunace data saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
      );

      return true;
    } else {
      ErrorMsg error = errorMsgFromJson(response.body);
      Fluttertoast.showToast(
        msg: " post Kitting issunace data status code ${response.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  //Post Kitting Issuance new api put method
  Future<bool> postKittingIssuncePutMethod(List<KittingPutModel> kittingPutModelList) async {
    log(kittingPutModelToJson(kittingPutModelList));
    var url = Uri.parse(baseUrl + "molex/kitting");
    var response = await http.put(url, body: kittingPutModelToJson(kittingPutModelList), headers: headerList);
    log(' post Kitting issunace data post body ${kittingPutModelToJson(kittingPutModelList)}');
    log(' post Kitting issunace data status code ${response.statusCode}');
    log('  post Kitting issunace datadata body ${response.body}');
    if (response.statusCode == 200) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          Fluttertoast.showToast(
            msg: " post Kitting issunace data saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
      );

      return true;
    } else {
      ErrorMsg error = errorMsgFromJson(response.body);
      Fluttertoast.showToast(
        msg: " post Kitting issunace data status code ${response.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

// localhost:9090/molex/bundlemaster?binId=1013&status=dropped&bundleId=1234&location=2345&finishedGoods=8756&cablePartNumber=9876&orderId=4567
  Future<List<BundlesRetrieved>?> getBundlesFgpartNo({required PostgetBundleMaster postgetBundleMaster}) async {
    log(' URL /molex/bundlemaster/');
    var url = Uri.parse(baseUrl + '/molex/bundlemaster');
    var response = await http.post(url, body: postgetBundleMasterToJson(postgetBundleMaster), headers: headerList);
    log('Get Bundlesabc From Bin  Status response body :${postgetBundleMasterToJson(postgetBundleMaster)}');
    log('Get Bundlesabc From Bin Status status Code: ${response.statusCode}');
    log('Get Bundlesabc From Bin  Status response body :${response.body}');
    if (response.statusCode == 200) {
      BundleDetailSts getBinDetail = bundleDetailStsFromJson(response.body);
      List<BundlesRetrieved> bundleList = getBinDetail.data.bundlesRetrieved.where((element) => element.bundleStatus == 'Kitting').toList();
      if (bundleList.length == 0) {
        // Fluttertoast.showToast(
        //   msg: "No Bundles in BIN",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.red,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      }
      return bundleList;
    } else {
      Fluttertoast.showToast(
        msg: "Unable to Find Bin",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  //Transfer Bundle to bin
  Future<List<BundleTransferToBin>?> postTransferBundletoBin({required List<TransferBundleToBin> transferBundleToBin}) async {
    var url = Uri.parse(baseUrl + 'molex/bin-tracking/transfer-bundle-to-bin-tracking');
    print('post Transfer Bundle to bin :${transferBundleToBinToJson(transferBundleToBin)} ');
    var response = await http.post(url, body: transferBundleToBinToJson(transferBundleToBin), headers: headerList);
    log("status post Transfer Bundle to bin ${response.statusCode}");
    log("response post Transfer Bundle to bin ${response.body}");
    if (response.statusCode == 200) {
      try {
        List<BundleTransferToBin> b = responseTransferBundletoBinFromJson(response.body).data.bundleTransferToBinTracking;
        return b;
      } catch (e) {
        Fluttertoast.showToast(
          msg: "status : parse error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return null;
      }
    } else {
      Fluttertoast.showToast(
        msg: "bundle transfer failed,status code ${response.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  //Post transfer bin to location
  Future<List<BundleTransferToBinTracking>?> postTransferBinToLocation(List<TransferBinToLocation> transferBinToLocationList) async {
    var url = Uri.parse(baseUrl + 'molex/bin-tracking/update-bin-location-in-bin');
    log('post Transfer BIn to Location :${transferBinToLocationToJson(transferBinToLocationList)} ');
    var response = await http.post(url, body: transferBinToLocationToJson(transferBinToLocationList), headers: headerList);
    print("status post Transfer Bin To Location ${response.statusCode}");
    log("response post Transfer Bin to Location ${response.body}");
    if (response.statusCode == 200) {
      try {
        List<BundleTransferToBinTracking> b = responseTransferBinToLocationFromJson(response.body).data.bundleTransferToBinTracking;
        return b;
      } catch (e) {
        print(e);
        ErrorTransferBinToLocation errorTransferBinToLocation = errorTransferBinToLocationFromJson(response.body);
        Fluttertoast.showToast(
          msg: "Error : Transfer Bin To Location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return null;
      }
    } else {
      return null;
    }
  }
}
