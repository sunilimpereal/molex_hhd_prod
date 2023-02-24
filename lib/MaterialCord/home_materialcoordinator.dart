import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex_hhd/MaterialCord/data/materialcord_bloc.dart';
import '../apiService.dart';
import 'pick_bins.dart';
import 'location.dart';
import '../model_api/materialCoordinator/material_cord_schedule_model.dart';

import '../models/material_schedule.dart';
import '../widgets/time.dart';

class HomeMaterialCoordinator extends StatefulWidget {
  String userId;
  String machineId;
  HomeMaterialCoordinator({required this.userId, required this.machineId});
  @override
  _HomeMaterialCoordinatorState createState() => _HomeMaterialCoordinatorState();
}

class _HomeMaterialCoordinatorState extends State<HomeMaterialCoordinator> {
  List<MaterialSchedule> materialSchedule = [];
  String _chosenValue = "Order ID";

  bool status = true;
  String type = 'matCord';
  TextEditingController _searchController = new TextEditingController();

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
          title: Text(
            type == 'matCord' ? "Material Coordinator" : "Kitting Coordinator",
            style: TextStyle(color: Colors.red, fontSize: 16),
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
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              widget.userId,
                              style: TextStyle(fontSize: 10, color: Colors.black),
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
            // Divider(
            //   color: Colors.redAccent,
            //   thickness: 2,
            // ),
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
        floatingActionButton: Padding(
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
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.red.shade100;
                          }
                          return Colors.red; // Use the component's default.
                        },
                      ),
                    ),
                    child: const Text(
                      "Pick",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarryBins(
                                    userId: widget.userId,
                                    machineId: '',
                                  )));
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
                    child: Text(
                      "Drop",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Location(
                                  userId: widget.userId,
                                  machineId: widget.machineId,
                                )),
                      );
                    },
                  ),
                )
              ],
            )

            //  Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //         Container(
            //         width: MediaQuery.of(context).size.width * 0.4,
            //         child: FloatingActionButton.extended(
            //             onPressed: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => CarryBins(
            //                             userId: widget.userId ?? "",
            //                           )));
            //             },
            //             label: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text('Pick'),
            //             )),
            //       ),
            //       SizedBox(width: 10),
            //       Container(
            //         width: MediaQuery.of(context).size.width * 0.4,
            //         child: FloatingActionButton.extended(
            //             backgroundColor: Colors.red,
            //             onPressed: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => Location(
            //                           userId: widget.userId,
            //                           machineId: widget.machineId,
            //                         )),
            //               );
            //             },
            //             label: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text('Drop'),
            //             )),
            //       ),

            //     ],
            //   ),
            // ),
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
      underline: Container(
        height: 2,
        color: Colors.red.shade100,
      ),
      iconEnabledColor: Colors.red,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        name,
        style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500),
      ),
      onChanged: (String? value) {
        setState(() {
          _chosenValue = value ?? '';
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
  String type = "Yet To Be Picked";
  @override
  void initState() {
    apiService = new ApiService();
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
    return
        // height: double.parse("${rowList.length*60}"),
        Column(
      children: [
        Container(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    type = "Yet To Be Picked";
                  });
                },
                child: Material(
                  elevation: type == "Yet To Be Picked" ? 6 : 2,
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: type == "Yet To Be Picked" ? Colors.red : Colors.white,
                        width: 3.0,
                      ),
                    )),
                    child: Center(
                      child: Text("Yet To Pick",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: type == "Yet To Be Picked" ? Colors.red : Colors.black,
                          )),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    type = "Picked";
                  });
                },
                child: Material(
                  elevation: type == "Picked" ? 6 : 2,
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: type == "Picked" ? Colors.red : Colors.white,
                        width: 3.0,
                      ),
                    )),
                    child: Center(
                      child: Text(
                        "Picked",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: type == "Picked" ? Colors.red : Colors.black,
                        )),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.70,
          child: StreamBuilder<List<MaterialCodinatorScheduler>>(
            stream: MaterialCordProvider.of(context).materialCordSchedulerStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MaterialCodinatorScheduler> materialCordList = searchfilter(snapshot.data!);
                materialCordList = type == "Yet To Be Picked"
                    ? materialCordList.where((element) => element.status == "Yet To Be Picked").toList()
                    : materialCordList.where((element) => element.status == "Picked").toList();
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
      ],
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
      padding: const EdgeInsets.all(2.5),
      child: Material(
        elevation: 5,
        color: Colors.transparent,
        shadowColor: Colors.grey.shade100,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(0)),
            // border: Border(
            //   left: BorderSide(
            //     color: materialSchedule.status == 'yettopick'
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
              SizedBox(width: 8),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 90,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    field(title: "Location ID", value: materialSchedule.location),
                    field(title: "Route ID", value: materialSchedule.routeId),
                    field(title: "Total Bundles", value: materialSchedule.totalBundle),
                  ],
                ),
              ),
              SizedBox(width: 10),

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
                      width: 70,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: materialSchedule.status == 'Yet To Be Picked' ? Colors.grey.shade100 : Colors.red.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          materialSchedule.status == 'Yet To Be Picked' ? "Yet To Pick" : "picked",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: materialSchedule.status == 'Yet To Be Picked' ? Colors.green : Colors.red),
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
//366130030