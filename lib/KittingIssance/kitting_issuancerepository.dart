import 'package:flutter/cupertino.dart';

import '../model_api/kitting/bundle_detail_sts_model.dart';
import '../model_api/kitting/kittingall_model.dart';

class KittingIssuanceRepository {
  static List<KittingDetail> convertToKittingDirect(List<BundlesRetrieved> bundles, String fgNum) {
    //confirming all bundles have same fg number
    bundles = bundles.where((element) => element.finishedGoodsPart.toString() == "$fgNum").toList();
    List<BundlesRetrieved> bundlesLopp = bundles;

    List<KittingDetail> kittingList = [];
    int i = 0;
    while (bundlesLopp.length > 0) {
      List<BundlesRetrieved> selectedbundles = [];
      BundlesRetrieved bundle = bundles[i];
      for (BundlesRetrieved bundleInList in bundlesLopp) {
        if (bundle.orderId == bundleInList.orderId &&
            bundle.locationId == bundleInList.locationId &&
            bundle.binId == bundleInList.binId &&
            bundle.color == bundleInList.color &&
            bundle.cablePartNumber == bundleInList.cablePartNumber &&
            bundle.cutLengthSpecificationInmm == bundleInList.cutLengthSpecificationInmm &&
            bundle.color == bundleInList.color) {
          selectedbundles.add(bundleInList);
        }
      }
      if (selectedbundles.length > 0) {
        KittingDetail kittingData = convertBundleListToKitting(bundle: bundle, selectedbundles: selectedbundles);
        kittingList.add(kittingData);
      }

      for (var bundl in selectedbundles) {
        bundlesLopp.remove(bundl);
      }
    }
    return kittingList;
  }

  static KittingDetail convertBundleListToKitting({
    required BundlesRetrieved bundle,
    required List<BundlesRetrieved> selectedbundles,
  }) {
    KittingDetail kitting = KittingDetail(
        kittingIssuance: KittingIssuance(
          fgPartNumber: bundle.finishedGoodsPart,
          orderId: bundle.orderId,
          cablePartNumber: bundle.cablePartNumber.toString(),
          binLocation: bundle.locationId,
          binId: bundle.binId.toString(),
          bundleQty: getsum(selectedbundles.map((e) => e.bundleQuantity).toList()),
          scheduledQty: bundle.bundleQuantity,
          status: bundle.bundleStatus,
          wireCuttingColor: bundle.color,
          cutLength: bundle.cutLengthSpecificationInmm.toString(),
          actualQty: 0,
          average: 0,
          bundleId: '0',
          cableType: '0',
          customerName: '0',
          id: 0,
          length: 0,
          routeMaster: '0',
          suggestedActualQty: '0',
          suggestedBinLocation: '0',
          suggestedBundleId: '0',
          suggestedBundleQty: 0,
          suggetedScheduledQty: '0',
        ),
        bundleList: selectedbundles
            .map((e) => BundleList(
                  id: 0,
                  fgPartNumber: e.finishedGoodsPart,
                  orderId: e.orderId,
                  cablePartNumber: e.cablePartNumber.toString(),
                  cableType: "",
                  length: e.cutLengthSpecificationInmm,
                  wireCuttingColor: e.color,
                  bundleId: e.bundleIdentification,
                  binId: e.binId.toString(),
                  binLocation: e.locationId,
                  average: 0,
                  bundleQuantity: e.bundleQuantity,
                ))
            .toList());
    return kitting;
  }

  static int getsum(List<int> list) {
    int sum = 0;
    for (int a in list) {
      sum = sum + a;
    }
    return sum;
  }

  List<KittingDetail> convertToKittingPlanned(List<KittingDetail> kittingList) {
    List<KittingDetail> newKittingList = [];
    List<KittingDetail> kittingLoop = kittingList;
    while (kittingLoop.length > 0) {
      KittingDetail selectedKitting = kittingLoop[0];
      List<KittingDetail> selectedKittingList = [];
      for (KittingDetail kittingDetail in kittingLoop) {
        if (selectedKitting.kittingIssuance.binId == kittingDetail.kittingIssuance.binId &&
            selectedKitting.kittingIssuance.binLocation == kittingDetail.kittingIssuance.binLocation) {
          if (selectedKitting.kittingIssuance.wireCuttingColor == kittingDetail.kittingIssuance.wireCuttingColor) {
            selectedKittingList.add(kittingDetail);
          }
        }
      }
      KittingDetail kittingDetail = convertKittingIssuanceListtokitting(selectedKittingList);
      newKittingList.add(kittingDetail);

      for (var kitting in selectedKittingList) {
        kittingLoop.remove(kitting);
      }
    }
    return newKittingList;
  }
}

KittingDetail convertKittingIssuanceListtokitting(List<KittingDetail> kittingList) {
  return KittingDetail(
      kittingIssuance: kittingList[0].kittingIssuance,
      bundleList: kittingList.map((e) {
        return BundleList(
            id: e.kittingIssuance.id,
            fgPartNumber: e.kittingIssuance.fgPartNumber,
            orderId: e.kittingIssuance.orderId,
            cablePartNumber: e.kittingIssuance.cablePartNumber,
            cableType: e.kittingIssuance.cableType,
            length: e.kittingIssuance.length,
            wireCuttingColor: e.kittingIssuance.wireCuttingColor,
            average: e.kittingIssuance.average,
            bundleId: e.kittingIssuance.bundleId,
            binId: e.kittingIssuance.binId,
            binLocation: e.kittingIssuance.binLocation,
            bundleQuantity: e.kittingIssuance.bundleQty);
      }).toList());
}
