import 'dart:developer';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../apiService.dart';
import '../model_api/kitting/bundle_detail_sts_model.dart';
import '../model_api/kitting/kittingall_model.dart';
import '../model_api/transfer_model/get_bundle_master.dart';

import '../models/material_schedule.dart';
import '../widgets/time.dart';
import 'kitting_wip.dart';
import 'kitting_issuancerepository.dart';

class KittingIssuanceHome extends StatefulWidget {
  String userId;
  String machineId;
  KittingIssuanceHome({Key? key, required this.userId, required this.machineId}) : super(key: key);
  @override
  _KittingIssuanceHomeState createState() => _KittingIssuanceHomeState();
}

class _KittingIssuanceHomeState extends State<KittingIssuanceHome> {
  List<MaterialSchedule> materialSchedule = [];
  String _chosenValue = "Order ID";

  bool status = true;
  String type = 'matCord';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String typeSearch = "Planned";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.red,
          ),
          backwardsCompatibility: false,
          leading: null,
          title: Text(
            "Kitting Issuance",
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: EdgeInsets.all(1),
              height: MediaQuery.of(context).size.height * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              widget.userId,
                              style: const TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            TimeDisplay(),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Select
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                dropdown(
                                    options: ["Order ID", "FG", "Schedule ID", "Location"],
                                    name: "Order ID"),
                                Container(
                                  height: 30,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          size: 20,
                                          color: Colors.red.shade400,
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          width: 130,
                                          height: 30,
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          child: TextField(
                                            controller: _searchController,
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            onTap: () {},
                                            style: TextStyle(fontSize: 14),
                                            decoration: new InputDecoration(
                                              hintText: "Search",
                                              hintStyle: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    fontSize: 10, fontWeight: FontWeight.w500),
                                              ),
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, bottom: 11, top: 11, right: 15),
                                              fillColor: Colors.white,
                                            ),
                                            //fillColor: Colors.green
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Scan
                          //Date
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.redAccent,
              thickness: 2,
            ),
            KittingCordSchedule(
                userId: widget.userId,
                searchType: _chosenValue,
                query: _searchController.text,
                setSearch: (String type) {
                  setState(() {
                    typeSearch = type;
                  });
                })
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget dropdown({required List<String> options, required String name}) {
    return Container(
        child: DropdownButton<String>(
      focusColor: Colors.white,
      value: _chosenValue,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            "$value",
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        "$name",
        style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500),
      ),
      onChanged: (String? value) {
        setState(() {
          _chosenValue = value ?? '';
        });
      },
    ));
  }
}

class KittingCordSchedule extends StatefulWidget {
  String userId;
  String searchType;
  String query;
  Function setSearch;
  KittingCordSchedule({
    required this.userId,
    required this.query,
    required this.searchType,
    required this.setSearch,
  });
  @override
  _KittingCordScheduleState createState() => _KittingCordScheduleState();
}

class _KittingCordScheduleState extends State<KittingCordSchedule> {
  late ApiService apiService;
  String type = "Planned";
  @override
  void initState() {
    apiService = ApiService();
    super.initState();
  }

  List<KittingDetail> searchfilter(List<KittingDetail> scheduleList) {
    switch (widget.searchType) {
      case "Order ID":
        return scheduleList
            .where((element) => element.kittingIssuance.orderId.toString().startsWith(widget.query))
            .toList();
        break;
      case "FG":
        return scheduleList
            .where((element) =>
                element.kittingIssuance.fgPartNumber.toString().startsWith(widget.query))
            .toList();
        break;
      case "Schedule ID":
        return scheduleList
            .where((element) =>
                element.kittingIssuance.scheduledQty.toString().startsWith(widget.query))
            .toList();
        break;
      case "Location":
        return scheduleList
            .where((element) =>
                element.kittingIssuance.binLocation.toString().startsWith(widget.query))
            .toList();
        break;
      default:
        return scheduleList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      type = "Planned";
                      widget.setSearch(type);
                    });
                  },
                  child: Material(
                    elevation: type == "Planned" ? 6 : 2,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: type == "Planned" ? Colors.red : Colors.white,
                          width: 3.0,
                        ),
                      )),
                      child: Center(
                          child: Text(
                        "Planned",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          color: type == "Planned" ? Colors.red : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      type = "Not Planned";
                      widget.setSearch(type);
                    });
                  },
                  child: Material(
                    elevation: type == "Not Planned" ? 6 : 2,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: type == "Not Planned" ? Colors.red : Colors.white,
                          width: 3.0,
                        ),
                      )),
                      child: Center(
                          child: Text(
                        "Direct",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: type == "Not Planned" ? Colors.red : Colors.black)),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
          // tableHeading(),
          type == "Planned"
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  // height: double.parse("${rowList.length*60}"),
                  child: FutureBuilder<List<KittingDetail>>(
                    future: apiService.getKittingIssuanceList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<KittingDetail> kittingList = KittingIssuanceRepository()
                            .convertToKittingPlanned(searchfilter(snapshot.data!));
                        log("message $kittingList");

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: kittingList.length,
                              itemBuilder: (context, index) {
                                return buildDataRow(kittingSchedule: kittingList[index]);
                              }),
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        ));
                      }
                    },
                  ),
                )
              : Container(
                  child: NotPlanned(
                    userId: widget.userId,
                    searchType: widget.searchType,
                    query: widget.query,
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildDataRow({required KittingDetail kittingSchedule, int? c}) {
    Widget field({required String title, required String value}) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "$title",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Material(
        elevation: 5,
        color: Colors.transparent,
        shadowColor: Colors.grey.shade100,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 140,
          decoration: const BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(0)),
            // border: Border(
            //   left: BorderSide(
            //     color: kittingSchedule.status == 'yettopick'
            //         ? Colors.greenAccent
            //         : Colors.redAccent,
            //     width: 4.0,
            //   ),
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // width: MediaQuery.of(context).size.width * 0.4,
                height: 120,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      field(title: "Order ID", value: kittingSchedule.kittingIssuance.orderId),
                      field(
                          title: "FG Number",
                          value: "${kittingSchedule.kittingIssuance.fgPartNumber}"),
                      field(
                          title: "Color", value: kittingSchedule.kittingIssuance.wireCuttingColor),
                      field(
                          title: "cut length", value: "${kittingSchedule.kittingIssuance.length}"),
                      // field(
                      //     title: "Schedule QTY",
                      //     value:
                      //         "${kittingSchedule.kittingIssuance.}"),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 120,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    field(title: "Location ID", value: kittingSchedule.bundleList[0].binLocation),
                    field(title: "Bin ID", value: kittingSchedule.bundleList[0].binId),
                    field(
                        title: "Bundle count / Qty",
                        value:
                            "${kittingSchedule.bundleList.length} / ${getTotalQuantityinKitting(kittingDetail: kittingSchedule)} "),
                    field(
                        title: "cable part No",
                        value: kittingSchedule.kittingIssuance.cablePartNumber),
                  ],
                ),
              ),
              SizedBox(width: 10),

              // button
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  Container(
                      width: 85,
                      padding: EdgeInsets.all(4),
                      child: Center(
                          child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) return Colors.white;
                              return Colors.white; // Use the component's default.
                            },
                          ),
                          elevation: MaterialStateProperty.resolveWith<double>(
                              (Set<MaterialState> states) {
                            return 10;
                          }),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) return Colors.green;
                              return Colors.red; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          KittingDetail postkittingSchedule = kittingSchedule;
                          postkittingSchedule.kittingIssuance.status = "Kitting";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KittingWIP(
                                        userId: widget.userId,
                                        kittingDetail: postkittingSchedule,
                                        machineId: '',
                                        issuanceType: "planned",
                                      ))).then((value) {
                            setState(() {
                              apiService.getKittingIssuanceList().then((value) {
                                List<KittingDetail> kittingList = searchfilter(value);
                                log("message $kittingList");
                              });
                            });
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Issue",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ))),
                  SizedBox(height: 5),
                ],
              ),
              const Divider(
                color: Colors.red,
                thickness: 21,
              )
            ],
          ),
        ),
      ),
    );
  }
}

int getTotalQuantityinKitting({required KittingDetail kittingDetail}) {
  int total = 0;
  for (BundleList bundle in kittingDetail.bundleList) {
    if (bundle.bundleQuantity != null) {
      total = total + bundle.bundleQuantity!.toInt();
    }
  }
  return total;
}

class NotPlanned extends StatefulWidget {
  String userId;
  String searchType;
  String query;
  NotPlanned({required this.userId, required this.searchType, required this.query});
  @override
  _NotPlannedState createState() => _NotPlannedState();
}

class _NotPlannedState extends State<NotPlanned> {
  String state = "fgInput";
  late ApiService apiService;
  List<BundlesRetrieved> bundleList = [];
  List<KittingDetail> kittingSchedule = [];
  String fgNum = "";
  @override
  void initState() {
    apiService = new ApiService();
    super.initState();
  }

  List<KittingDetail> searchfilter(List<KittingDetail> scheduleList) {
    switch (widget.searchType) {
      case "Order ID":
        return scheduleList
            .where((element) => element.kittingIssuance.orderId.toString().startsWith(widget.query))
            .toList();
        break;
      case "FG":
        return scheduleList
            .where((element) =>
                element.kittingIssuance.fgPartNumber.toString().startsWith(widget.query))
            .toList();
        break;
      case "Schedule ID":
        return scheduleList
            .where((element) =>
                element.kittingIssuance.scheduledQty.toString().startsWith(widget.query))
            .toList();
        break;
      case "Location":
        return scheduleList
            .where((element) =>
                element.kittingIssuance.binLocation.toString().startsWith(widget.query))
            .toList();
        break;
      default:
        return scheduleList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: state == "fgInput" ? fgNumber() : disp(),
    );
  }

  Widget fgNumber() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    fgNum = value;
                  });
                },
                onTap: () {},
                decoration: InputDecoration(
                  hintText: "Fg Number",
                  hintStyle: GoogleFonts.openSans(
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  // focusedBorder: InputBorder.none,
                  // enabledBorder: InputBorder.none,
                  // errorBorder: InputBorder.none,
                  // disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  fillColor: Colors.grey,
                ),
                //fillColor: Colors.green
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.white; // Use the component's default.
                  },
                ),
                elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                  return 10;
                }),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.red; // Use the component's default.
                  },
                ),
              ),
              onPressed: () {
                PostgetBundleMaster postgetBundleMaster = PostgetBundleMaster(
                    binId: 0,
                    finishedGoods: int.parse(fgNum),
                    status: "Kitting",
                    location: "",
                    cablePartNumber: 0,
                    orderId: "",
                    bundleId: "",
                    scheduleId: 0);
                apiService
                    .getBundlesFgpartNo(postgetBundleMaster: postgetBundleMaster)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      bundleList = value;
                      kittingSchedule =
                          KittingIssuanceRepository.convertToKittingDirect(bundleList, fgNum);
                      if (kittingSchedule.isNotEmpty) {
                        state = "list";
                      } else {
                        Fluttertoast.showToast(
                          msg: "No Kitting found",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    });
                  }
                });
              },
              child: const Text("Search"),
            )
          ],
        ),
      ),
    );
  }

  Widget disp() {
    List<KittingDetail> kittinglist = searchfilter(kittingSchedule);
    return Container(
      height: MediaQuery.of(context).size.height * 0.753,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: ListView.builder(
          itemCount: kittinglist.length,
          itemBuilder: (context, index) {
            return buildDataRow(
              kittingScheduleData: kittinglist[index],
              c: 0,
            );
          },
        ),
      ),
    );
  }

  // List<KittingDetail> getKitting() {
  //   List<KittingDetail> kittingScheduleList = [];
  //   List<BundlesRetrieved> fgBundles = bundleList;
  //   fgBundles = bundleList
  //       .where((element) => element.finishedGoodsPart.toString() == "$fgNum")
  //       .toList();
  //   log(fgNum);
  //   int i =0;

  //   for (BundlesRetrieved bundle in fgBundles) {
  //     log("${kittingSchedule.map((e) => e.kittingIssuance.orderId).toList()}");
  //     if (!kittingScheduleList.map((e) => e.kittingIssuance.orderId).toList().contains(bundle.orderId)) {
  //       log("${i++}");
  //       KittingDetail kitDet = KittingDetail(
  //         kittingIssuance: KittingIssuance(
  //           fgPartNumber: bundle.finishedGoodsPart,
  //           orderId: bundle.orderId,
  //           cablePartNumber: bundle.cablePartNumber.toString(),
  //           binLocation: bundle.locationId,
  //           binId: bundle.binId.toString(),
  //           bundleQty: bundleList.length,
  //           scheduledQty: '0'
  //         ),
  //         bundleList: fgBundles.map((e) {
  //           if (e.orderId == bundle.orderId &&
  //               e.cablePartNumber == bundle.cablePartNumber &&
  //               e.locationId == bundle.locationId) {
  //             log(bundle.binId.toString());
  //             return BundleList(
  //               id: e.id,
  //               fgPartNumber: e.finishedGoodsPart,
  //               orderId: e.orderId,
  //               cablePartNumber: e.cablePartNumber.toString(),
  //               cableType: "",
  //               length: e.cutLengthSpecificationInmm,
  //               wireCuttingColor: e.color,
  //               bundleId: e.bundleIdentification,
  //               binId: e.binId.toString(),
  //               binLocation: e.locationId,
  //             );
  //           }
  //         }).toList(),
  //       );
  //       log("${kitDet.bundleList.length}");
  //       //  log("Kitting Detail:${ List<dynamic>.from(kittingSchedule.map((x) => x.toJson()))}");
  //       setState(() {
  //          kittingScheduleList.add(kitDet);
  //       });

  //     }
  //   }
  //   return kittingScheduleList;
  // }

  Widget buildDataRow({required KittingDetail kittingScheduleData, required int c}) {
    Widget field({required String title, required String value}) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "$title",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Material(
        elevation: 5,
        color: Colors.transparent,
        shadowColor: Colors.grey.shade100,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 140,
          decoration: const BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(0)),
            // border: Border(
            //   left: BorderSide(
            //     color: kittingSchedule.status == 'yettopick'
            //         ? Colors.greenAccent
            //         : Colors.redAccent,
            //     width: 4.0,
            //   ),
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // width: MediaQuery.of(context).size.width * 0.4,
                height: 120,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      field(title: "Order ID", value: kittingScheduleData.kittingIssuance.orderId),
                      field(
                          title: "FG Number",
                          value: "${kittingScheduleData.kittingIssuance.fgPartNumber}"),
                      field(
                          title: "Color",
                          value: kittingScheduleData.kittingIssuance.wireCuttingColor),
                      field(
                          title: "cut length",
                          value: kittingScheduleData.kittingIssuance.cutLength ?? ""),
                      // field(
                      //     title: "Schedule QTY",
                      //     value:
                      //         "${kittingSchedule.kittingIssuance.}"),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 120,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    field(
                        title: "Location ID",
                        value: kittingScheduleData.kittingIssuance.binLocation),
                    field(title: "Bin ID", value: kittingScheduleData.kittingIssuance.binId),
                    field(
                        title: "Bundle count / Qty",
                        value:
                            "${kittingScheduleData.bundleList.length} / ${kittingScheduleData.kittingIssuance.bundleQty} "),
                    field(
                        title: "cable part No",
                        value: kittingScheduleData.kittingIssuance.cablePartNumber),
                  ],
                ),
              ),
              SizedBox(width: 10),

              // button
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  Container(
                      width: 85,
                      padding: EdgeInsets.all(4),
                      child: Center(
                          child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) return Colors.white;
                              return Colors.white; // Use the component's default.
                            },
                          ),
                          elevation: MaterialStateProperty.resolveWith<double>(
                              (Set<MaterialState> states) {
                            return 10;
                          }),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) return Colors.green;
                              return Colors.red; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KittingWIP(
                                        userId: widget.userId,
                                        kittingDetail: kittingScheduleData,
                                        machineId: '',
                                        issuanceType: "direct",
                                      ))).then((value) {
                            PostgetBundleMaster postgetBundleMaster = PostgetBundleMaster(
                                binId: 0,
                                finishedGoods: int.parse(fgNum),
                                status: "Kitting",
                                location: "",
                                cablePartNumber: 0,
                                orderId: "",
                                bundleId: "",
                                scheduleId: 0);
                            apiService
                                .getBundlesFgpartNo(postgetBundleMaster: postgetBundleMaster)
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  bundleList = value;
                                  kittingSchedule =
                                      KittingIssuanceRepository.convertToKittingDirect(
                                          bundleList, fgNum);
                                  if (kittingSchedule.length != 0) {
                                    state = "list";
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "No Kitting found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                });
                              }
                            });
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Issue",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ))),
                  SizedBox(height: 5),
                ],
              ),
              Divider(
                color: Colors.red,
                thickness: 21,
              )
            ],
          ),
        ),
      ),
    );
  }
}
//bin id
// 66
