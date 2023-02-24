import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:molex_hhd/bundle_detail/data/bundle_bloc.dart';
import 'package:molex_hhd/bundle_detail/text_field.dart';

import 'data/bundle_model.dart';

enum BundleScreenState { scanner, bundleDetail }

class BundleDetailScreen extends StatefulWidget {
  const BundleDetailScreen({super.key});

  @override
  State<BundleDetailScreen> createState() => _BundleDetailScreenState();
}

class _BundleDetailScreenState extends State<BundleDetailScreen> {
  String bundleId = "";
  final TextEditingController _bundleIdController = TextEditingController();
  BundleScreenState _bundleScreenState = BundleScreenState.scanner;
  @override
  Widget build(BuildContext context) {
    switch (_bundleScreenState) {
      case BundleScreenState.scanner:
        return scanner();
      case BundleScreenState.bundleDetail:
        return detailScreen();
      default:
        return Container();
    }
  }

  Widget scanner() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
        title: Text(
          "Scan Bundle",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/scan-barcode.json', fit: BoxFit.contain),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: AppTextField(
                    label: "Scan Bundle",
                    onchanged: (sa) {},
                    controller: _bundleIdController,
                    onsubmited: (a) {
                      setState(() {
                        BundleProvider.of(context).getBundle(bundleId: _bundleIdController.text);
                        _bundleScreenState = BundleScreenState.bundleDetail;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailScreen() {
    return StreamBuilder<BundleModel>(
        stream: BundleProvider.of(context).bundleStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            BundleModel? bundle = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red.shade600,
                title: Text(
                  "Bundle Detail",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                ),
              ),
              body: Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            detailitem(name: "Bundle ID", data: bundle!.bundleIdentification.toString()),
                            detailitem(name: "Schedule ID", data: bundle.scheduledId.toString()),
                            detailitem(name: "Quantity", data: bundle.bundleQuantity.toString()),
                            detailitem(
                              name: "Machine ID",
                              data: bundle.machineIdentification.toString(),
                            ),
                            detailitem(name: "Operator ID", data: bundle.operatorIdentification.toString()),
                            detailitem(name: "FG", data: bundle.finishedGoodsPart.toString()),
                            detailitem(name: "Cable Part Number", data: bundle.cablePartNumber.toString()),
                            detailitem(name: "Cable part Description", data: bundle.cablePartDescription.toString()),
                            detailitem(name: "Cut Length Specification", data: bundle.cutLengthSpecificationInmm.toString()),
                            detailitem(name: "Color", data: bundle.color.toString()),
                            detailitem(name: "Bundle Status", data: bundle.cutLengthSpecificationInmm.toString()),
                            detailitem(name: "Bin Id", data: bundle.binId.toString()),
                            detailitem(name: "Location ID", data: bundle.cutLengthSpecificationInmm.toString()),
                            detailitem(name: "Order Id", data: bundle.orderId.toString()),
                            detailitem(name: "Update From Process", data: bundle.updateFromProcess.toString()),
                            detailitem(name: "AWG", data: bundle.awg),
                            detailitem(name: "Crimp From ScheduleID", data: bundle.crimpFromSchId),
                            detailitem(name: "Crimp To ScheduleID", data: bundle.crimpToSchId),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(body: Center(child: const CircularProgressIndicator()));
          }
        });
  }

  Widget detailitem({
    required String name,
    required String data,
  }) {
    return Container(
      width: (MediaQuery.of(context).size.width) - 8,
      padding: const EdgeInsets.all(0),
      child: ListTile(
        title: Text(
          name,
          textAlign: TextAlign.start,
        ),
        trailing: Text(
          data,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
