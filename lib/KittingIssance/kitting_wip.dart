// ignore_for_file: unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../apiService.dart';
import '../model_api/kitting/kittingall_model.dart';
import '../model_api/kitting/post_kitting_issuance.dart';
import '../utils/config.dart';
import '../widgets/time.dart';
import 'kittingissuancehome.dart';
import 'models/kitting_put_model.dart';

class KittingWIP extends StatefulWidget {
  final String userId;
  final String machineId;
  final KittingDetail kittingDetail;
  final String issuanceType;
  KittingWIP({required this.userId, required this.machineId, required this.kittingDetail, required this.issuanceType});
  @override
  _KittingWIPState createState() => _KittingWIPState();
}

class _KittingWIPState extends State<KittingWIP> {
  TextEditingController _binController = new TextEditingController();
  String binId = "";
  List<BundleList> bundleList = [];
  late ApiService apiService;
  bool issuebinloading = false;
  @override
  void initState() {
    apiService = ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChannels.textInput.invokeMethod(keyboardType);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.red,
        ),
        title: const Text(
          'Kitting',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                )
              ],
            ),
          ),
          TimeDisplay(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kittingDetail(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bin(),
              ],
            ),
            dataTable(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0), side: BorderSide(color: Colors.red)),
              ),
              shadowColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return Colors.white;
                  return Colors.white; // Use the component's default.
                },
              ),
              elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                return 10;
              }),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return Colors.red.shade300;
                  return Colors.red; // Use the component's default.
                },
              ),
            ),
            child: issuebinloading
                ? const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : const Text(
                    "Issue Bin",
                    style: TextStyle(color: Colors.white),
                  ),
            onPressed: () {
              saveKittingData();
            },
          ),
        ),
      ),
    );
  }

  saveKittingData() {
    List<KittingPutModel> kittingPutModelList = [];
    for (BundleList bundle in bundleList) {
      kittingPutModelList.add(KittingPutModel(
        id: bundle.id,
        fgPartNumber: widget.kittingDetail.kittingIssuance.fgPartNumber,
        orderId: widget.kittingDetail.kittingIssuance.orderId,
        cablePartNumber: widget.kittingDetail.kittingIssuance.cablePartNumber,
        cableType: widget.kittingDetail.kittingIssuance.cableType,
        length: widget.kittingDetail.kittingIssuance.length,
        wireCuttingColor: widget.kittingDetail.kittingIssuance.wireCuttingColor,
        average: widget.kittingDetail.kittingIssuance.average,
        customerName: widget.kittingDetail.kittingIssuance.customerName,
        routeMaster: widget.kittingDetail.kittingIssuance.routeMaster,
        scheduledQty: widget.kittingDetail.kittingIssuance.scheduledQty,
        actualQty: widget.kittingDetail.kittingIssuance.actualQty,
        binId: bundle.binId,
        binLocation: bundle.binLocation,
        bundleId: bundle.bundleId,
        bundleQty: bundle.bundleQuantity ?? 0,
        suggetedScheduledQty: 0,
        suggestedActualQty: widget.kittingDetail.kittingIssuance.actualQty,
        suggestedBinLocation: bundle.binLocation,
        suggestedBundleId: bundle.bundleId,
        suggestedBundleQty: widget.kittingDetail.kittingIssuance.suggestedBundleQty,
        status: "Dispatched",
        userId: widget.userId,
      ));
    }

    setState(() {
      issuebinloading = !issuebinloading;
    });
    apiService.postKittingIssuncePutMethod(kittingPutModelList).then((value) {
      if (value) {
        setState(() {
          issuebinloading = !issuebinloading;
        });
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: "Kitting Issue Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        setState(() {
          issuebinloading = !issuebinloading;
        });
      }
    });
  }

  ///Old Kitting post method
  // saveKittingData() {
  //   PostKittingIssuance postKittingIssuance = PostKittingIssuance(
  //     fgPartNumber: widget.kittingDetail.kittingIssuance.fgPartNumber,
  //     orderId: widget.kittingDetail.kittingIssuance.orderId,
  //     cablePartNumber: widget.kittingDetail.kittingIssuance.cablePartNumber,
  //     cableType: "",
  //     wireCuttingColor: widget.kittingDetail.kittingIssuance.wireCuttingColor,
  //     length: widget.kittingDetail.kittingIssuance.length,
  //     average: widget.kittingDetail.kittingIssuance.average,
  //     customerName: widget.kittingDetail.kittingIssuance.customerName,
  //     routeMaster: widget.kittingDetail.kittingIssuance.routeMaster,
  //     scheduledQty: int.parse(widget.kittingDetail.kittingIssuance.scheduledQty),
  //     actualQty: widget.kittingDetail.kittingIssuance.actualQty,
  //     binId: widget.kittingDetail.kittingIssuance.binId,
  //     binLocation: widget.kittingDetail.kittingIssuance.binLocation,
  //     bundleId: bundleList.map((e) => e.bundleId).toList(),
  //     bundleQty: widget.kittingDetail.kittingIssuance.bundleQty,
  //     suggetedScheduledQty: int.parse(widget.kittingDetail.kittingIssuance.suggetedScheduledQty),
  //     suggestedActualQty: int.parse(widget.kittingDetail.kittingIssuance.suggestedActualQty),
  //     suggestedBinLocation: widget.kittingDetail.kittingIssuance.suggestedBinLocation,
  //     suggestedBundleId: widget.kittingDetail.kittingIssuance.suggestedBundleId,
  //     suggestedBundleQty: int.parse(widget.kittingDetail.kittingIssuance.suggestedBundleQty),
  //     status: "Dispatched",
  //   );
  //   setState(() {
  //     issuebinloading = !issuebinloading;
  //   });
  //   apiService.postKittingIssunce([postKittingIssuance]).then((value) {
  //     if (value) {
  //       setState(() {
  //         issuebinloading = !issuebinloading;
  //       });
  //       Navigator.pop(context);
  //       Fluttertoast.showToast(
  //         msg: "Kitting Issue Saved",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //     } else {
  //       setState(() {
  //         issuebinloading = !issuebinloading;
  //       });
  //     }
  //   });
  // }

  Widget dataTable() {
    int a = 1;
    return Container(
      padding: EdgeInsets.only(bottom: 100),
      // height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          DataTable(
              columnSpacing: 20,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('No.',
                      style: TextStyle(
                        fontSize: 10,
                      )),
                ),
                DataColumn(
                  label: Text('Location ID',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
                DataColumn(
                  label: Text('Bin ID',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
                DataColumn(
                  label: Text('Bundle ID',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
                DataColumn(
                  label: Text('Qty',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
                DataColumn(
                  label: Text('Remove',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
              ],
              rows: bundleList
                  .map(
                    (e) => DataRow(cells: <DataCell>[
                      DataCell(Text(
                        "${a++}",
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      )),
                      DataCell(Text(
                        "${e.binLocation}",
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      )),
                      DataCell(Text(e.binId.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                          ))),
                      DataCell(Text("${e.bundleId.toString()}",
                          style: const TextStyle(
                            fontSize: 11,
                          ))),
                      DataCell(Text(widget.issuanceType != "planned" ? "${e.bundleQuantity.toString()}" : "${e.bundleQuantity.toString()}",
                          style: const TextStyle(
                            fontSize: 11,
                          ))),
                      DataCell(
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade400,
                            size: 15,
                          ),
                          onPressed: () {
                            setState(() {
                              bundleList.remove(e);
                            });
                          },
                        ),
                      ),
                    ]),
                  )
                  .toList())
        ],
      ),
    );
  }

  Widget kittingDetail() {
    Widget field({required String title, required String data, required double width}) {
      return Container(
        width: MediaQuery.of(context).size.width * width,
        padding: EdgeInsets.all(3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "$data",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    fontSize: 11,
                  )),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5),
                Column(
                  children: [
                    field(title: "Order ID", data: widget.kittingDetail.kittingIssuance.orderId, width: 0.21),
                    field(title: "Fg No.", data: widget.kittingDetail.kittingIssuance.fgPartNumber.toString(), width: 0.21),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    field(title: "color", data: widget.kittingDetail.kittingIssuance.wireCuttingColor.toString(), width: 0.1),
                    field(
                        title: "Bundle Count /Qty",
                        data: "${widget.kittingDetail.bundleList.length} /${getTotalQuantityinKitting(kittingDetail: widget.kittingDetail)}",
                        width: 0.3),
                  ],
                ),
                Column(
                  children: [
                    field(title: "Location", data: widget.kittingDetail.kittingIssuance.binLocation, width: 0.2),
                    field(title: "Bin ID", data: widget.kittingDetail.kittingIssuance.binId, width: 0.2),
                  ],
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bin() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 180,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => handleKey(event.data),
                      child: TextField(
                          style: TextStyle(fontSize: 13),
                          controller: _binController,
                          onTap: () {
                            SystemChannels.textInput.invokeMethod(keyboardType);
                          },
                          onChanged: (value) {
                            setState(() {
                              binId = value;
                            });
                          },
                          decoration: new InputDecoration(
                              suffix: _binController.text.length > 1
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _binController.clear();
                                        });
                                      },
                                      child: Icon(Icons.clear, size: 18, color: Colors.red))
                                  : Container(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
                              ),
                              labelText: 'Scan Bin',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 5.0))),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                  child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: Colors.transparent))),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) return Colors.red;
                      return Colors.red.shade500; // Use the component's default.
                    },
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) return Colors.green.shade600;
                      return Colors.green.shade300; // Use the component's default.
                    },
                  ),
                ),
                // style: ElevatedButton.styleFrom(
                //   padding: EdgeInsets.all(0),
                //   primary: Colors.red, // background
                //   onPrimary: Colors.white,
                // ),
                child: Text(
                  '  Scan BIN  ',
                ),
                onPressed: () {
                  List<BundleList> bundleList1 = widget.kittingDetail.bundleList;
                  log("${widget.kittingDetail.bundleList[0].binId}");

                  for (BundleList bundle in bundleList1) {
                    log("${bundle.binId}");
                    if (bundle.binId == binId) {
                      if (bundleList.contains(bundle)) {
                        Fluttertoast.showToast(
                          msg: "bundle already added",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        setState(() {
                          bundleList.add(bundle);
                        });
                      }
                    }
                  }
                },
              )),
            ],
          ),
        ]),
      ),
    );
  }

  handleKey(RawKeyEventData key) {
    setState(() {
      SystemChannels.textInput.invokeMethod(keyboardType);
    });
  }
}
