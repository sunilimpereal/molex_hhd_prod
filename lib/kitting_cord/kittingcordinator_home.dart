import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex_hhd/MaterialCord/data/materialcord_bloc.dart';

import '../model_api/materialCoordinator/material_cord_schedule_model.dart';
import '../models/material_schedule.dart';
import 'drop.dart';
import 'transfer.dart';
import '../apiService.dart';
import '../widgets/time.dart';

class KittingCordHome extends StatefulWidget {
  String userId;
  String machineId;
  KittingCordHome({required this.userId, required this.machineId});
  @override
  _KittingCordHomeState createState() => _KittingCordHomeState();
}

class _KittingCordHomeState extends State<KittingCordHome> {
  List<MaterialSchedule> materialSchedule = [];
  String _chosenValue = "Order ID";

  bool status = true;
  String type = 'matCord';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
          title: const Text(
            "Kitting Coordinator",
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            // Switch(
            //   activeColor: Colors.red,
            //   inactiveThumbColor: Colors.redAccent,
            //   value: status,
            //   onChanged: (value) {
            //     print("VALUE : $value");

            //     if (value == true) {
            //       setState(() {
            //         status = value;
            //         type = 'matCord';
            //       });
            //     } else {
            //       setState(() {
            //         status = value;
            //         type = 'knitCord';
            //       });
            //     }
            //   },
            // ),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(
                                Icons.person,
                                size: 14,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              widget.userId,
                              style: TextStyle(fontSize: 12, color: Colors.black),
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
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.05,
            //   width: MediaQuery.of(context).size.width,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Select
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                dropdown(options: ["Order ID", "FG", "Schedule ID", "Location"], name: "Order ID"),
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
                                            decoration: new InputDecoration(
                                              hintText: "Search",
                                              hintStyle: GoogleFonts.openSans(
                                                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                              ),
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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
            MaterialcordSchedule(
              materialScheduleList: materialSchedule,
              userId: widget.userId,
              searchType: _chosenValue,
              query: _searchController.text,
            )
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.47,
                  height: 45,
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
                          if (states.contains(MaterialState.pressed)) return Colors.red.shade100;
                          return Colors.red; // Use the component's default.
                        },
                      ),
                    ),
                    child: Text(
                      "Pick",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KittingPick(
                                  userId: widget.userId,
                                  machineId: widget.machineId,
                                )),
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.47,
                  height: 45,
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
                          if (states.contains(MaterialState.pressed)) return Colors.red.shade200;
                          return Colors.red; // Use the component's default.
                        },
                      ),
                    ),
                    child: const Text(
                      "Kit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KittingDrop(
                                    userId: widget.userId,
                                    machineId: '',
                                  )));
                    },
                  ),
                )
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.4,
                //   child: FloatingActionButton.extended(
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => KittingPick(
                //                     userId: widget.userId,
                //                     machineId: widget.machineId,
                //                   )),
                //         );
                //       },
                //       label: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text('Pick'),
                //       )),
                // ),
                // SizedBox(width: 10),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.4,
                //   child: FloatingActionButton.extended(
                //       backgroundColor: Colors.red,
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => KittingDrop(
                //                       userId: widget.userId ?? "",
                //                     )));
                //       },
                //       label: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text('Kit'),
                //       )),
                // ),
              ],
            ),
          ),
        ),
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
            value,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        name,
        style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500),
      ),
      onChanged: (String? value) {
        setState(() {
          _chosenValue = value ?? "";
        });
      },
    ));
  }
}

class MaterialcordSchedule extends StatefulWidget {
  List<MaterialSchedule> materialScheduleList;
  String userId;
  String searchType;
  String query;
  MaterialcordSchedule({
    required this.materialScheduleList,
    required this.userId,
    required this.query,
    required this.searchType,
  });
  @override
  _MaterialcordScheduleState createState() => _MaterialcordScheduleState();
}

class _MaterialcordScheduleState extends State<MaterialcordSchedule> {
  late ApiService apiService;
  String type = "Staging";
  @override
  void initState() {
    apiService = ApiService();
    super.initState();
  }

  List<MaterialCodinatorScheduler> searchfilter(List<MaterialCodinatorScheduler> scheduleList) {
    switch (widget.searchType) {
      case "Order ID":
        return scheduleList.where((element) => element.orderId.toString().startsWith(widget.query)).toList();
        break;
      case "FG":
        return scheduleList.where((element) => element.fgNo.toString().startsWith(widget.query)).toList();
        break;
      case "Schedule ID":
        return scheduleList.where((element) => element.scheduleId.toString().startsWith(widget.query)).toList();
        break;
      case "Location":
        return scheduleList.where((element) => element.location.toString().startsWith(widget.query)).toList();
        break;
      default:
        return scheduleList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      type = "Staging";
                    });
                  },
                  child: Material(
                    elevation: type == "Staging" ? 6 : 2,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: type == "Staging" ? Colors.red : Colors.white,
                          width: 3.0,
                        ),
                      )),
                      child: Center(
                          child: Text(
                        "Staging Location",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: type == "Staging" ? Colors.red : Colors.black,
                        )),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      type = "Yet To Kit";
                    });
                  },
                  child: Material(
                    elevation: type == "Yet To Kit" ? 6 : 2,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: type == "Yet To Kit" ? Colors.red : Colors.white,
                          width: 3.0,
                        ),
                      )),
                      child: Center(
                          child: Text(
                        "Yet To Kit",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          fontSize: 12,
                          color: type == "Yet To Kit" ? Colors.red : Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.72,
              child: StreamBuilder<List<MaterialCodinatorScheduler>>(
                stream: MaterialCordProvider.of(context).materialCordSchedulerStream,
                builder: (context, snapshot) {
                  List<String> locations = ["LOKITTEMP01", "LOKITTEMP02", "LOKITTEMP03", "LOKITTEMP04", "LOKITTEMP05"];
                  if (snapshot.hasData) {
                    List<MaterialCodinatorScheduler> materialCordList = searchfilter(snapshot.data!);

                    materialCordList =
                        type == "Staging" ? materialCordList.where((element) => locations.contains(element.location)).toList() : materialCordList;
                    materialCordList = type == "Staging"
                        ? materialCordList.where((element) => element.status.toLowerCase() == "Dropped".toLowerCase()).toList()
                        : materialCordList.where((element) => element.status.toLowerCase() == "transfer".toLowerCase()).toList();
                    return ListView.builder(
                        padding: EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        itemCount: materialCordList.length,
                        itemBuilder: (context, index) {
                          return buildDataRow(materialSchedule: materialCordList[index]);
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDataRow({required MaterialCodinatorScheduler materialSchedule, int? c}) {
    Widget field({required String title, required String value}) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(3),
      child: Material(
        elevation: 5,
        color: Colors.transparent,
        shadowColor: Colors.grey.shade100,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(4),
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 100,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      field(title: "Order ID", value: "${materialSchedule.orderId}"),
                      field(title: "FG Number", value: materialSchedule.fgNo),
                      field(title: "Schedule ID", value: materialSchedule.scheduleId),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 90,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    field(title: "Location ID", value: materialSchedule.location),
                    field(title: "RouteId", value: materialSchedule.routeId),
                    field(title: "Total Bundles", value: materialSchedule.totalBundle),
                  ],
                ),
              ),
              SizedBox(width: 0),

              // button
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  Text(
                    "Bin ID",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${materialSchedule.binId}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: 85,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: materialSchedule.status == 'Dropped' ? Colors.grey.shade100 : Colors.red.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          "${materialSchedule.status}",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold, color: materialSchedule.status == 'Dropped' ? Colors.green : Colors.red),
                        ),
                      )),
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
// 369100004