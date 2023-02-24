import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/config.dart';
import '../widgets/loading_button.dart';
import 'home_materialcoordinator.dart';
import '../apiService.dart';
import '../model_api/get_bin_detail.dart';
import '../model_api/put_bundle_picked.dart';
import '../widgets/time.dart';

class Location extends StatefulWidget {
  String userId;
  String machineId;
  Location({required this.userId, required this.machineId});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _binController = TextEditingController();
  FocusNode _binFocus = new FocusNode();
  FocusNode _locationFocus = new FocusNode();
  // List<LocationBin> listLocation = [];
  List<PutBundlePicked> bundleList = [];
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
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: const Text(
          'Drop',
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: 140,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: RawKeyboardListener(
                              focusNode: FocusNode(),
                              onKey: (event) => handleKey(event.data),
                              child: TextFormField(
                                  focusNode: _locationFocus,
                                  autofocus: true,
                                  controller: _locationController,
                                  onTap: () {
                                    setState(() {
                                      SystemChannels.textInput.invokeMethod(keyboardType);
                                      _locationController.clear();
                                      _binController.clear();
                                      locationId = "";
                                      binId = "";
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      locationId = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      suffix: _locationController.text.length > 1
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _locationController.clear();
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
                                      labelText: 'Scan Location',
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 5.0))),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //     child: ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.red, // background
                      //     onPrimary: Colors.white,
                      //   ),
                      //   child: Text(
                      //     'Scan Location',
                      //   ),
                      //   onPressed: () {
                      //     setState(() {
                      //       hasLocation = true;
                      //       _binFocus.requestFocus();
                      //       Future.delayed(
                      //         const Duration(milliseconds: 50),
                      //         () {
                      //           SystemChannels.textInput
                      //               .invokeMethod(keyboardType);
                      //         },
                      //       );
                      //     });
                      //   },
                      // )),
                      SizedBox(width: 2),
                      bin(),
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
            //         child: Text('Confirm Drop')),
            //   ),
            // )
          ]),
          Container(child: SingleChildScrollView(child: dataTable())),
        ]),
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
            child: Text(
              "Confirm Drop",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _showConfirmationDialog();
            },
          ),
        ),
      ),
    );
  }

  Widget location() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 405,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 250,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => handleKey(event.data),
                      child: TextField(
                          focusNode: _locationFocus,
                          autofocus: true,
                          controller: _locationController,
                          onTap: () {
                            SystemChannels.textInput.invokeMethod(keyboardType);
                          },
                          onChanged: (value) {
                            setState(() {
                              locationId = value;
                            });
                          },
                          decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
                              ),
                              hintText: 'Scan Bin',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 5.0))),
                    ),
                  ),
                ),
              ),
              Container(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white,
                ),
                child: Text(
                  'Scan Location',
                ),
                onPressed: () {},
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

  Widget bin() {
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
                  width: 138,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => handleKey(event.data),
                      child: TextField(
                          focusNode: _binFocus,
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
                              labelText: 'Scan bin',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 5.0))),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2),
              Container(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        primary: Colors.red, // background
                        onPrimary: Colors.white,
                      ),
                      child: const Text(
                        'Scan',
                      ),
                      onPressed: () {
                        if (_locationController.text.length > 0) {
                          ApiService apiService = new ApiService();
                          apiService.getPickedBundleDetail(binId).then((value) {
                            setState(() {
                              if (!bundleList.map((e) => e.binIdentification).toList().contains(value![0].binId.toString())) {
                                bundleList.addAll(value.map((e) => PutBundlePicked(
                                      binIdentification: e.binId.toString(),
                                      bundleId: e.bundleIdentification,
                                      locationId: _locationController.text,
                                      userId: widget.userId,
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
                              binId = " ";
                              _binController.clear();
                            });
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Scan Location",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      })),
            ],
          ),
        ]),
      ),
    );
  }

  Widget locationdisplay(String loc) {
    return Container(
        height: 150,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Center(
          child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  color: Colors.white,
                  width: 250,
                  height: 40,
                  child: Center(
                      child: Text('Location ID',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ))),
                )),
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  color: Colors.white,
                  width: 250,
                  height: 50,
                  child: Center(child: Text(loc, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30, color: Colors.green))),
                ))
          ]),
        ));
  }

  Widget dataTable() {
    int a = 1;
    return Container(
      padding: EdgeInsets.only(bottom: 100),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          DataTable(
              columnSpacing: 22,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('S no.',
                      style: TextStyle(
                        fontSize: 10,
                      )),
                ),
                DataColumn(
                  label: Text('Location Id',
                      style: TextStyle(
                        fontSize: 10,
                      )),
                ),
                DataColumn(
                  label: Text('Bin Id',
                      style: TextStyle(
                        fontSize: 10,
                      )),
                ),
                DataColumn(
                  label: Text('Bundle Id',
                      style: TextStyle(
                        fontSize: 10,
                      )),
                ),
                DataColumn(
                  label: Text('Qty',
                      style: TextStyle(
                        fontSize: 10,
                      )),
                ),
                DataColumn(
                  label: Text('Remove',
                      style: TextStyle(
                        fontSize: 10,
                      )),
                ),
              ],
              rows: bundleList
                  .map(
                    (e) => DataRow(cells: <DataCell>[
                      DataCell(Text(
                        "${a++}",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )),
                      DataCell(Text(
                        "${e.locationId}",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )),
                      DataCell(Text("${e.binIdentification.toString()}",
                          style: TextStyle(
                            fontSize: 12,
                          ))),
                      DataCell(Text("${e.bundleId.toString()}",
                          style: TextStyle(
                            fontSize: 12,
                          ))),
                      DataCell(Text("${e..toString()}",
                          style: TextStyle(
                            fontSize: 12,
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
                  .toList())
        ],
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
          title: Text('Drop to location?'),
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
                // List<PutBundlePicked> bundlePickedList = [];
                // for (BundleDetail bundleDetail in bundleList) {
                //   bundlePickedList.add(PutBundlePicked(
                //       bundleId: bundleDetail.bundleIdentification,
                //       locationId: locationId,
                //       binIdentification: bundleDetail.binId.toString(),
                //       userId: widget.userId));
                // }
                apiService.dropBundles(bundleList).then((value) {
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
            //       // List<PutBundlePicked> bundlePickedList = [];
            //       // for (BundleDetail bundleDetail in bundleList) {
            //       //   bundlePickedList.add(PutBundlePicked(
            //       //       bundleId: bundleDetail.bundleIdentification,
            //       //       locationId: locationId,
            //       //       binIdentification: bundleDetail.binId.toString(),
            //       //       userId: widget.userId));
            //       // }
            //       apiService.dropBundles(bundleList).then((value) {
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
