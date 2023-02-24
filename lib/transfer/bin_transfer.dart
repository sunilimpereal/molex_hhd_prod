import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../apiService.dart';
import '../model_api/transfer_model/bin_to_bundle_model.dart';
import '../utils/config.dart';

class BinTransferBundle extends StatefulWidget {
  String userID;

  BinTransferBundle({Key? key, required this.userID}) : super(key: key);

  @override
  _BinTransferBundleState createState() => _BinTransferBundleState();
}

class _BinTransferBundleState extends State<BinTransferBundle> {
  TextEditingController _binController = new TextEditingController();
  TextEditingController _bundleController = new TextEditingController();
  String binId = "";
  String bundleId = "";

  List<TransferBundleToBin> listBundleTransfertoBin = [];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      child: Column(
        children: [
          input(),
          dataTable(),
        ],
      ),
    );
  }

  Widget input() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Row(
          children: [
            Column(
              children: [
                bundle(),
                bin(),
              ],
            ),
            // transferButton(),
            confirmTransfer()
          ],
        ),
      ),
    );
  }

  Widget bundle() {
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
                    controller: _bundleController,
                    onTap: () {
                      SystemChannels.textInput.invokeMethod(keyboardType);
                    },
                    onChanged: (value) {
                      setState(() {
                        binId = value;
                      });
                    },
                    decoration: InputDecoration(
                        suffix: _bundleController.text.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _bundleController.clear();
                                  });
                                },
                                child: const Icon(Icons.clear, size: 18, color: Colors.red))
                            : Container(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
                        ),
                        labelText: 'Scan Bundle',
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
                    decoration: InputDecoration(
                        suffix: _binController.text.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _binController.clear();
                                  });
                                },
                                child: const Icon(Icons.clear, size: 18, color: Colors.red))
                            : Container(),
                        focusedBorder: const OutlineInputBorder(
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
        height: 45,
        width: MediaQuery.of(context).size.width * 0.25,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.green),
            ),
            onPressed: () {
              ApiService apiService = new ApiService();
              if (_bundleController.text.isNotEmpty) {
                if (_bundleController.text == getpostBundletoBin().bundleId) {
                  apiService.postTransferBundletoBin(transferBundleToBin: [getpostBundletoBin()]).then((value) {
                    if (value != null) {
                      BundleTransferToBin bundleTransferToBinTracking = value[0];
                      Fluttertoast.showToast(
                          msg: "Transfered Bundle-${bundleTransferToBinTracking.bundleIdentification} to Bin- ${_binController.text}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      setState(() {
                        listBundleTransfertoBin.add(TransferBundleToBin(
                            binIdentification: bundleTransferToBinTracking.binId.toString(),
                            bundleId: bundleTransferToBinTracking.bundleIdentification,
                            userId: widget.userID,
                            locationId: bundleTransferToBinTracking.locationId));
                        _binController.clear();
                        _bundleController.clear();
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: "Unable to transfer Bundle to Bin",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  });
                } else {
                  Fluttertoast.showToast(
                    msg: "Wrong Bundle Id",
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
                  msg: "Bundle Not Scanned",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            child: Text('Transfer')),
      ),
    );
  }

  TransferBundleToBin getpostBundletoBin() {
    TransferBundleToBin bundleToBin = TransferBundleToBin(
      binIdentification: _binController.text,
      bundleId: _bundleController.text,
      userId: widget.userID,
      locationId: '',
    );
    return bundleToBin;
  }

  Widget transferButton() {
    return Container(
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
      child: const Text(
        'Transfer ',
      ),
      onPressed: () {
        if (listBundleTransfertoBin.map((e) => e.bundleId).toList().contains(_bundleController.text)) {
          listBundleTransfertoBin.add(
              TransferBundleToBin(binIdentification: _binController.text, bundleId: _bundleController.text, locationId: "", userId: widget.userID));
        }
      },
    ));
  }

  Widget confirmtransfer() {
    return Container(
        child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: const BorderSide(color: Colors.transparent))),
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
      child: const Text(
        'Transfer ',
      ),
      onPressed: () {
        setState(() {
          listBundleTransfertoBin.add(
              TransferBundleToBin(binIdentification: _binController.text, bundleId: _bundleController.text, locationId: "", userId: widget.userID));
          if (!listBundleTransfertoBin.map((e) => e.bundleId).toList().contains(_bundleController.text)) {}
        });
      },
    ));
  }

  Widget dataTable() {
    int a = 1;
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: DataTable(
                columnSpacing: 30,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('No.', style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ),

                  DataColumn(
                    label: Text('Location ID', style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ),
                  DataColumn(
                    label: Text('Bin ID', style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ),
                  DataColumn(
                    label: Text('Bundle ID', style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ),
                  // DataColumn(
                  //   label: Text('Remove',
                  //       style: GoogleFonts.openSans(
                  //           textStyle: TextStyle(fontWeight: FontWeight.w600))),
                  // ),
                ],
                rows: listBundleTransfertoBin
                    .map(
                      (e) => DataRow(cells: <DataCell>[
                        DataCell(Text("${a++}",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                              fontSize: 11,
                            )))),
                        DataCell(Text("${e.locationId}",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                              fontSize: 11,
                            )))),
                        DataCell(Text("${e.binIdentification}",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                              fontSize: 11,
                            )))),
                        DataCell(Text("${e.bundleId}",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                              fontSize: 11,
                            )))),
                      ]),
                    )
                    .toList()),
          ),
        ));
  }

  handleKey(RawKeyEventData key) {
    setState(() {
      SystemChannels.textInput.invokeMethod(keyboardType);
    });
  }
}
