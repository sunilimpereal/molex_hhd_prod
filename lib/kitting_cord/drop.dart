import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../apiService.dart';
import '../model_api/kitting/bundle_detail_sts_model.dart';
import '../model_api/kitting/update_bundle_kitting_model.dart';
import '../model_api/transfer_model/get_bundle_master.dart';
import '../utils/config.dart';
import '../widgets/loading_button.dart';
import '../widgets/time.dart';

class KittingDrop extends StatefulWidget {
  String userId;
  String machineId;
  KittingDrop({required this.userId, required this.machineId});
  @override
  _KittingDropState createState() => _KittingDropState();
}

//369200603
class _KittingDropState extends State<KittingDrop> {
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _binController = TextEditingController();
  FocusNode _binFocus = FocusNode();
  FocusNode _locationFocus = FocusNode();
  // List<KittingDropBin> listKittingDrop = [];
  List<UpdateBundleKitting> bundleList = [];
  String locationId = "";
  String binId = "";
  bool hasLocation = false;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _locationFocus.requestFocus();
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod(keyboardType);
      },
    );
    super.initState();
  }

  void checkLocation(String l) {}

  void checkBin(String bi) {}

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod(keyboardType);
    checkLocation(locationId);
    checkBin(binId);
    return Scaffold(
      key: _scaffoldKey1,
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
          TimeDisplay(),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // location(),
                    SizedBox(width: 2),
                    Column(
                      children: [bin(), scanButton()],
                    ),
                  ],
                ),
              ]),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(0.0),
          //   child: Container(
          //     height: 40,
          //     child: ElevatedButton(
          //         style: ButtonStyle(
          //           backgroundColor: MaterialStateProperty.resolveWith(
          //               (states) => Colors.green),
          //         ),
          //         onPressed: () {

          //         },
          //         child: Text('Confirm Kitting')),
          //   ),
          // )
        ]),
        Container(child: SingleChildScrollView(child: dataTable())),
      ]),
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
            child: Text(
              "Kit  Bin's",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _showConfirmationDialog();
            },
          ),
        ),
      ),
      //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //       floatingActionButton: Container(
      //         child:Padding(
      //           padding: const EdgeInsets.all(10.0),
      //           child: ElevatedButton(
      //             onPressed: (){
      //  _showConfirmationDialog();
      //             },
      //             child: Padding(
      //               padding: const EdgeInsets.all(15.0),
      //               child: Text('Kit Bundles'),
      //             ),
      //           ),
      //         )
      //       ),
    );
  }

  handleKey(RawKeyEventData key) {
    setState(() {
      SystemChannels.textInput.invokeMethod(keyboardType);
    });
  }

  Widget bin() {
    SystemChannels.textInput.invokeMethod(keyboardType);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        location(),
        SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      width: 150,
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (event) => handleKey(event.data),
                          child: TextField(
                              style: TextStyle(fontSize: 12),
                              focusNode: _binFocus,
                              controller: _binController,
                              onTap: () {
                                setState(() {
                                  SystemChannels.textInput.invokeMethod(keyboardType);
                                });
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
                  SizedBox(width: 15),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget location() {
    SystemChannels.textInput.invokeMethod(keyboardType);
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 150,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => handleKey(event.data),
                      child: TextField(
                          style: TextStyle(fontSize: 12),
                          focusNode: _locationFocus,
                          controller: _locationController,
                          onTap: () {
                            setState(() {
                              SystemChannels.textInput.invokeMethod(keyboardType);
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              locationId = value;
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
          ),
        ]),
      ),
    );
  }

  Widget scanButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
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
        child: const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Scan',
          ),
        ),
        onPressed: () {
          if (_locationController.text.length > 0) {
            ApiService apiService = ApiService();
            PostgetBundleMaster postgetBundleMaster = PostgetBundleMaster(
                binId: int.parse(binId),
                finishedGoods: 0,
                status: "Transfer",
                location: "",
                cablePartNumber: 0,
                orderId: "",
                bundleId: "",
                scheduleId: 0);
            apiService.getBundlesinBinStatus(postgetBundleMaster).then((value) {
              List<BundlesRetrieved> addBundles = value!;
              // addBundles = addBundles
              //     .where(
              //         (element) => element.binId.toString() == binId.toString())
              //     .toList();
              setState(() {
                if (!bundleList.map((e) => e.binIdentification).toList().contains(addBundles[0].binId.toString())) {
                  bundleList.addAll(addBundles.map((e) => UpdateBundleKitting(
                        binIdentification: e.binId.toString(),
                        bundleId: e.bundleIdentification,
                        locationId: locationId,
                        userId: widget.userId,
                        quantity: e.bundleQuantity.toString(),
                      )));
                } else {
                  Fluttertoast.showToast(
                      msg: "Bin already added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                binId = "";
                _binController.clear();
              });
            });
          } else {
            Fluttertoast.showToast(
                msg: "Scan location",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
      ),
    );
  }

  Widget dataTable() {
    int a = 1;
    return Container(
      padding: EdgeInsets.only(bottom: 35),
      height: MediaQuery.of(context).size.height * 0.75,
      child: SingleChildScrollView(
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Theme(
              data: ThemeData(
                textTheme: TextTheme(
                  headline1: GoogleFonts.openSans(
                    textStyle: TextStyle(),
                  ),
                ),
              ),
              child: DataTable(
                  columnSpacing: 15,
                  columns: <DataColumn>[
                    DataColumn(
                        label: Text(
                      'No.',
                      style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    )),
                    DataColumn(
                        label: Text(
                      'Location ID',
                      style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    )),
                    DataColumn(
                        label: Text(
                      'Bin ID',
                      style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    )),
                    DataColumn(
                        label: Text(
                      'Bundle ID',
                      style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    )),
                    DataColumn(
                        label: Text(
                      'Qty',
                      style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    )),
                    DataColumn(
                        label: Text(
                      'Remove',
                      style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    )),
                  ],
                  rows: bundleList
                      .map(
                        (e) => DataRow(cells: <DataCell>[
                          DataCell(Text(
                            "${a++}",
                            style: TextStyle(fontSize: 11),
                          )),
                          DataCell(Text(
                            "${e.locationId}",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          )),
                          DataCell(Text("${e.binIdentification.toString()}",
                              style: TextStyle(
                                fontSize: 11,
                              ))),
                          DataCell(Text("${e.bundleId.toString()}",
                              style: TextStyle(
                                fontSize: 11,
                              ))),
                          DataCell(Text("${e.quantity.toString()}",
                              style: TextStyle(
                                fontSize: 11,
                              ))),
                          DataCell(
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey.shade400,
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
                      .toList()),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        SystemChannels.textInput.invokeMethod(keyboardType);
      },
    );
    return showDialog<void>(
      context: _scaffoldKey1.currentContext!,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kitting '),
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[Text('Confirm Location Transfer')],
          //   ),
          // ),
          actions: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () {
                      SystemChannels.textInput.invokeMethod(keyboardType);
                    },
                  );
                },
                child: Text('Cancel')),

            LoadingButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.green),
              ),
              child: Text('Confirm'),
              loading: false,
              loadingChild: Container(
                width: 30,
                height: 30,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Future.delayed(
                  const Duration(milliseconds: 50),
                  () {
                    SystemChannels.textInput.invokeMethod(keyboardType);
                  },
                );

                ApiService apiService = new ApiService();

                // for (BundlesRetrieved bundleDetail in bundleList) {
                //   bundlePickedList.add(UpdateBundleKitting(
                //       bundleId: bundleDetail.bundleIdentification,
                //       locationId: locationId,
                //       binIdentification: bundleDetail.binId.toString(),
                //       userId: widget.userId));
                // }
                apiService.updateBundleKitting(bundleList).then((value) {
                  if (value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {}
                });
              },
            )

            // ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.resolveWith(
            //           (states) => Colors.green),
            //     ),
            //     onPressed: () {
            //       Future.delayed(
            //         const Duration(milliseconds: 50),
            //         () {
            //           SystemChannels.textInput.invokeMethod(keyboardType);
            //         },
            //       );

            //       ApiService apiService = new ApiService();

            //       // for (BundlesRetrieved bundleDetail in bundleList) {
            //       //   bundlePickedList.add(UpdateBundleKitting(
            //       //       bundleId: bundleDetail.bundleIdentification,
            //       //       locationId: locationId,
            //       //       binIdentification: bundleDetail.binId.toString(),
            //       //       userId: widget.userId));
            //       // }
            //       apiService.updateBundleKitting(bundleList).then((value) {
            //         if (value) {
            //           Navigator.pop(context);
            //           Navigator.pop(context);
            //         } else {}
            //       });
            //     },
            //     child: Text('Confirm')),
          ],
        );
      },
    );
  }
}
