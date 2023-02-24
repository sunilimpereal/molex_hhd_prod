import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../apiService.dart';
import '../model_api/get_bin_detail.dart';
import '../model_api/kitting/bundle_detail_sts_model.dart';
import '../model_api/kitting/update_bundle_transfer_model.dart';
import '../model_api/materialCoordinator/bin_tansfer_model.dart';
import '../model_api/transfer_model/get_bundle_master.dart';
import '../utils/config.dart';
import '../widgets/loading_button.dart';
import '../widgets/time.dart';

class KittingPick extends StatefulWidget {
  String userId;
  String machineId;
  KittingPick({required this.userId, required this.machineId});
  @override
  _KittingPickState createState() => _KittingPickState();
}

class _KittingPickState extends State<KittingPick> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _binController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  FocusNode _binFocus = new FocusNode();
  FocusNode _bundleFocus = new FocusNode();
  String binId = "";
  String locationId = "";
  bool hasBin = false;
  late String locationState;

  var status;
  late BinTransfer binTransfer;
  List<BundlesRetrieved> bundleList = [];
  late ApiService apiService;
  @override
  void initState() {
    apiService = ApiService();
    SystemChrome.setEnabledSystemUIOverlays([]);

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod(keyboardType);
      },
    );
    super.initState();
  }

//70065
  @override
  void dispose() {
    _binController.dispose();
    _binFocus.dispose();
    super.dispose();
  }

  void checkBin(String bundle) {}

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod(keyboardType);
      },
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: const Text(
          'Pick Bin',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        elevation: 0,
        actions: [
          TimeDisplay(),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 35,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: RawKeyboardListener(
                                  focusNode: FocusNode(),
                                  onKey: (event) => handleKey(event.data),
                                  child: TextField(
                                      focusNode: _bundleFocus,
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
                            SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // background
                                  onPrimary: Colors.white,
                                ),
                                child: const Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Scan',
                                  ),
                                ),
                                onPressed: () {
                                  PostgetBundleMaster postgetBundleMaster = PostgetBundleMaster(
                                      binId: int.parse(binId),
                                      finishedGoods: 0,
                                      status: "Dropped",
                                      location: "",
                                      cablePartNumber: 0,
                                      orderId: "",
                                      bundleId: "",
                                      scheduleId: 0);
                                  ApiService apiService = new ApiService();
                                  apiService.getBundlesinBinStatus(postgetBundleMaster).then((value) {
                                    List<BundlesRetrieved> addBundles = value!;
                                    addBundles = addBundles.where((element) => element.binId.toString() == binId.toString()).toList();
                                    setState(() {
                                      if (!bundleList.map((e) => e.binId).toList().contains(addBundles[0].binId)) {
                                        bundleList.addAll(addBundles);
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
                                },
                              )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            dataTable(),
          ]),
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
            child: const Text(
              "Pick Bin's",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _binFocus.unfocus();
                _binController.clear();
                binId = "";
              });
              _showConfirmationDialog();
            },
          ),
        ),
      ),
    );
  }

  Widget dataTable() {
    int a = 1;
    return Container(
      padding: EdgeInsets.only(bottom: 100),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DataTable(
              columnSpacing: 20,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'No.',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Location',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Bin ID',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Bundle ID',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Qty',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Remove',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ],
              rows: bundleList
                  .map(
                    (e) => DataRow(cells: <DataCell>[
                      DataCell(Text(
                        "${a++}",
                        style: TextStyle(fontSize: 13),
                      )),
                      DataCell(Text(
                        "${e.locationId}",
                        style: TextStyle(fontSize: 13),
                      )),
                      DataCell(Text(
                        "${e.binId.toString()}",
                        style: TextStyle(fontSize: 13),
                      )),
                      DataCell(Text(
                        "${e.bundleIdentification.toString()}",
                        style: TextStyle(fontSize: 13),
                      )),
                      DataCell(IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setState(() {
                            bundleList.remove(e);
                          });
                        },
                      )),
                    ]),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  handleKey(RawKeyEventData key) {
    setState(() {
      SystemChannels.textInput.invokeMethod(keyboardType);
    });
  }

  Future<void> _showConfirmationDialog() async {
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        SystemChannels.textInput.invokeMethod(keyboardType);
      },
    );
    return showDialog<void>(
      context: _scaffoldKey.currentContext!,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Carry BIN from this Location?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[],
            ),
          ),
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
                List<UpdateBundleTransfer> bundlePickedList = [];
                for (BundlesRetrieved bundleDetail in bundleList) {
                  bundlePickedList.add(UpdateBundleTransfer(
                      bundleId: bundleDetail.bundleIdentification,
                      locationId: bundleDetail.locationId,
                      binIdentification: bundleDetail.binId.toString(),
                      userId: widget.userId));
                }
                apiService.updateBundleKittingTransfer(bundlePickedList).then((value) {
                  if (value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
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
            //       List<UpdateBundleTransfer> bundlePickedList = [];
            //       for (BundlesRetrieved bundleDetail in bundleList) {
            //         bundlePickedList.add(UpdateBundleTransfer(
            //             bundleId: bundleDetail.bundleIdentification,
            //             locationId: bundleDetail.locationId,
            //             binIdentification: bundleDetail.binId.toString(),
            //             userId: widget.userId));
            //       }
            //       apiService
            //           .updateBundleKittingTransfer(bundlePickedList)
            //           .then((value) {
            //         if (value) {
            //           Navigator.pop(context);
            //           Navigator.pop(context);
            //         }
            //       });
            //     },
            //     child: Text('Confirm')),
          ],
        );
      },
    );
  }
}
