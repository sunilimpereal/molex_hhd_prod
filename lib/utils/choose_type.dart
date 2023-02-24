import 'package:flutter/material.dart';
import '../KittingIssance/kittingissuancehome.dart';
import '../MaterialCord/home_materialcoordinator.dart';
import '../bundle_detail/bundle_det_screen.dart';
import '../kitting_cord/kittingcordinator_home.dart';
import '../model_api/transfer_bundle_model.dart';
import '../transfer/transfer.dart';

class ChooseType extends StatefulWidget {
  String userId;
  ChooseType({required this.userId});
  @override
  _ChooseTypeState createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeMaterialCoordinator(
                                    userId: widget.userId,
                                    machineId: '',
                                  )),
                        );
                      },
                      child: Text("Material Coordinator")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KittingCordHome(
                                    userId: widget.userId,
                                    machineId: '',
                                  )),
                        );
                      },
                      child: Text("Kitting Coordinator")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KittingIssuanceHome(
                                    userId: widget.userId,
                                    machineId: '',
                                  )),
                        );
                      },
                      child: Text("Kitting Issuance")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransferBundles(
                                    userId: widget.userId,
                                  )),
                        );
                      },
                      child: Text("Transfer")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BundleDetailScreen()),
                        );
                      },
                      child: Text("Bundle Detail")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
