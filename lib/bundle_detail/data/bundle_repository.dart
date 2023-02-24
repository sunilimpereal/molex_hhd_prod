import '../../utils/api_requests.dart';
import 'bundle_model.dart';

class BundelRepository {
  Future<BundleModel?> getBundleDetail({required String bundleId}) async {
    BundlesResponseModel? getBundleListGl = await ApiRequest<PostgetBundleMaster, BundlesResponseModel>().post(
      url: "molex/bundlemaster/",
      reponseFromJson: bundlesResponseModelFromJson,
      request: PostgetBundleMaster(
        binId: 0,
        bundleId: bundleId,
        location: "",
        finishedGoods: 0,
        cablePartNumber: 0,
        orderId: "",
        scheduleId: 0,
        status: '',
      ),
      requestToJson: postgetBundleMasterToJson,
    );
    BundleModel? bundleList = getBundleListGl?.data.bundlesRetrieved[0];
    return bundleList;
  }
}
