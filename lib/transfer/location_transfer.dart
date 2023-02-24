// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model_api/get_bin_detail.dart';
import '../model_api/kitting/bundle_detail_sts_model.dart';
import '../model_api/transfer_model/binto_location_transfer.dart';
import '../apiService.dart';
import '../model_api/transfer_model/get_bundle_master.dart';
import '../utils/config.dart';

class LocationTransferScreen extends StatefulWidget {
  String userid;
  LocationTransferScreen({Key? key, required this.userid}) : super(key: key);
  @override
  _LocationTransferScreenState createState() => _LocationTransferScreenState();
}

class _LocationTransferScreenState extends State<LocationTransferScreen> {
  final TextEditingController _binController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String binId = "";
  List<TransferBinToLocation> transferList = [];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Stack(
      children: [
        Container(
          child: Column(
            children: [input(), dataTable()],
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  completeTransfer(),
                ],
              ),
            ))
      ],
    );
  }

  Widget input() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Column(
              children: [
                location(),
                bin(),
              ],
            ),
            confirmTransfer()
          ],
        ),
      ),
    );
  }

  Widget location() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 190,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => handleKey(event.data),
                child: TextField(
                    style: TextStyle(fontSize: 13),
                    controller: _locationController,
                    onTap: () {
                      SystemChannels.textInput.invokeMethod(keyboardType);
                    },
                    onChanged: (value) {
                      setState(() {
                        binId = value;
                      });
                    },
                    decoration: new InputDecoration(
                        suffix: _locationController.text.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _locationController.clear();
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
                        labelText: 'Scan Location',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 5.0))),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bin() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 190,
            height: 40,
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
      ],
    );
  }

  Widget confirmTransfer() {
    SystemChannels.textInput.invokeMethod(keyboardType);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.25,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.green),
            ),
            onPressed: () {
              PostgetBundleMaster postgetBundleMaste = PostgetBundleMaster(
                scheduleId: 0,
                binId: int.parse(binId),
                bundleId: '',
                location: '',
                status: '',
                finishedGoods: 0,
                cablePartNumber: 0,
                orderId: "",
              );
              ApiService apiService = new ApiService();
              apiService.getBundlesinBinStatus(postgetBundleMaste).then((value) {
                if (value != null) {
                  List<BundlesRetrieved> bundleist = value;
                  bundleist = bundleist.where((element) => element.bundleStatus.toLowerCase() != "dispatched").toList();
                  if (bundleist.length > 0) {
                    for (BundlesRetrieved bundle in bundleist) {
                      if (!transferList.map((e) => e.bundleId).toList().contains(bundle.bundleIdentification)) {
                        setState(() {
                          transferList.add(TransferBinToLocation(
                              userId: widget.userid,
                              binIdentification: binId,
                              bundleId: bundle.bundleIdentification,
                              locationId: _locationController.text));
                        });
                      } else {
                        Fluttertoast.showToast(
                          msg: "Bundle already Present",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    }
                    setState(() {
                      _binController.clear();
                      binId = "";
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: "No bundles Found in BIN",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: "Invalid Bin Id",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              });

              // setState(() {
              //   _binController.clear();
              //   binId = null;
              // });
            },
            child: Text('Transfer')),
      ),
    );
  }

  Widget completeTransfer() {
    SystemChannels.textInput.invokeMethod(keyboardType);

    return transferList.length > 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.green),
                  ),
                  onPressed: () {
                    postCompleteTransfer();
                    // _showConfirmationDialog();
                  },
                  child: Text('Complete Transfer')),
            ),
          )
        : Container();
  }

  Widget dataTable() {
    int a = 1;
    return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: DataTable(
                columnSpacing: 20,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('No.', style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ),
                  DataColumn(
                    label: Text('Location Id', style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ),
                  DataColumn(
                    label: Text('Bin Id', style: GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ),
                  DataColumn(
                    label: Text('Bundles', style: GoogleFonts.openSans(fontSize: 11, textStyle: TextStyle(fontWeight: FontWeight.w600))),
                  ),
                  DataColumn(
                    label: Text('Remove', style: GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ),
                ],
                rows: transferList
                    .map(
                      (e) => DataRow(cells: <DataCell>[
                        DataCell(Text("${a++}",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontSize: 11,
                            )))),
                        DataCell(Text("${e.locationId}",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontSize: 11,
                            )))),
                        DataCell(Text("${e.binIdentification}",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontSize: 11,
                            )))),
                        DataCell(Text("${e.bundleId} ",
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                              fontSize: 11,
                            )))),
                        DataCell(
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                transferList.remove(e);
                              });
                            },
                          ),
                        ),
                      ]),
                    )
                    .toList()),
          ),
        ));
  }

  postCompleteTransfer() {
    ApiService apiService = ApiService();

    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        SystemChannels.textInput.invokeMethod(keyboardType);
      },
    );
    apiService.postTransferBinToLocation(transferList).then((value) {
      if (value != null) {
        Navigator.pop(context);
        return 0;
      }
    });
  }

  handleKey(RawKeyEventData key) {
    setState(() {
      SystemChannels.textInput.invokeMethod(keyboardType);
    });
  }
}
