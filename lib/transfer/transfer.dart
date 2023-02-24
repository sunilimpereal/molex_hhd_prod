import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model_api/materialCoordinator/bin_tansfer_model.dart';
import '../model_api/transfer_location_model.dart';
import 'bin_transfer.dart';
import 'location_transfer.dart';
import '../widgets/time.dart';

enum Type { bin, location }

class TransferBundles extends StatefulWidget {
  String userId;
  TransferBundles({required this.userId});

  @override
  _TransferBundlesState createState() => _TransferBundlesState();
}

class _TransferBundlesState extends State<TransferBundles> {
  Type type = Type.bin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.red,
        ),
        backwardsCompatibility: false,
        leading: null,
        title: const Text(
          "Transfer",
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: const EdgeInsets.all(1),
            height: MediaQuery.of(context).size.height * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            padding:
                                EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            widget.userId ,
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
      body: Container(
          child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                      type = Type.bin;
                  });
                },
                child: Material(
                  elevation: type == Type.bin ? 6 : 2,
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: type == Type.bin ? Colors.red : Colors.white,
                        width: 3.0,
                      ),
                    )),
                    child: Center(
                        child: Text(
                      "Bin",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: type == Type.bin
                                  ? Colors.red
                                  : Colors.black)),
                    )),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    type = Type.location;
                  });
                },
                child: Material(
                  elevation: type == Type.location ? 6 : 2,
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: type == Type.location ? Colors.red : Colors.white,
                        width: 3.0,
                      ),
                    )),
                    child: Center(
                        child: Text(
                      "Location",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: type == Type.location
                                  ? Colors.red
                                  : Colors.black)),
                    )),
                  ),
                ),
              )
            ],
          ),
          type == Type.bin?BinTransferBundle(
            userID: widget.userId,
          ):LocationTransferScreen(
            userid: widget.userId,
          ),
        ],
      )),
    );
  }
}
