import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'change_ip.dart';
import 'MaterialCord/home_materialcoordinator.dart';
import 'apiService.dart';
import 'utils/choose_type.dart';
import 'utils/config.dart';
import 'utils/updateapp.dart';
// import 'package:lottie/lottie.dart';

class LoginScan extends StatefulWidget {
  @override
  _LoginScanState createState() => _LoginScanState();
}

class _LoginScanState extends State<LoginScan> {
  TextEditingController _textController = new TextEditingController();
  FocusNode _textNode = new FocusNode();
  String userId = "";
  late ApiService apiService;

  @override
  void initState() {
    apiService = ApiService();
    _textNode.requestFocus();
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        SystemChannels.textInput.invokeMethod(keyboardType);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _textNode.dispose();
    super.dispose();
  }

  handleKey(RawKeyEventData key) {
    setState(() {
      SystemChannels.textInput.invokeMethod(keyboardType);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChannels.textInput.invokeMethod(keyboardType);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeMaterialCoordinator(
                                        userId: userId,
                                        machineId: '',
                                      )),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(30)), boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 5.0,
                            ),
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Lottie.asset('assets/lottie/scan-barcode.json', width: 350, fit: BoxFit.cover),
                                const Text(
                                  'Scan Id Card to Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                if (userId != '')
                                  Text(
                                    userId,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  )
                                else
                                  Container(
                                    width: 10,
                                  ),
                                SizedBox(height: 10),
                                Container(
                                  height: 40,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
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
                                            if (states.contains(MaterialState.pressed)) return Colors.green;
                                            return Colors.red; // Use the component's default.
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        if (userId.length > 1) {
                                          print('pressed');
                                          apiService.empIdlogin(userId).then((value) {
                                            if (value != null) {
                                              Fluttertoast.showToast(
                                                  msg: "logged In",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              print("userId:$userId");
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ChooseType(
                                                          userId: userId,
                                                        )),
                                              );
                                            } else {
                                              setState(() {
                                                userId = '';
                                                _textController.clear();
                                                _textNode.requestFocus();
                                              });
                                              Fluttertoast.showToast(
                                                  msg: "login Failed",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          });
                                        }
                                      },
                                      child: const Text('Login')),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    width: 0,
                                    height: 0,
                                    child: RawKeyboardListener(
                                      focusNode: FocusNode(),
                                      onKey: (event) async {
                                        if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
                                          Fluttertoast.showToast(
                                              msg: "Got tab at the end",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          setState(() {
                                            userId = '';
                                          });
                                        }
                                        handleKey(event.data);
                                      },
                                      child: TextField(
                                        textInputAction: TextInputAction.search,
                                        onSubmitted: (value) async {
                                          print('pressed');
                                          apiService.empIdlogin(userId).then((value) {
                                            if (value != null) {
                                              Fluttertoast.showToast(
                                                  msg: "logged In",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              print("userId:$userId");
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ChooseType(
                                                          userId: userId,
                                                        )),
                                              );
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "login Failed",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() {
                                                userId = '';
                                                _textController.clear();
                                                _textNode.requestFocus();
                                              });
                                            }
                                          });
                                        },
                                        onTap: () {
                                          SystemChannels.textInput.invokeMethod(keyboardType);
                                        },
                                        controller: _textController,
                                        //autofocus: true,
                                        focusNode: _textNode,
                                        onChanged: (value) {
                                          setState(() {
                                            userId = value;
                                          });
                                        },
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Material(
                                elevation: 10,
                                shadowColor: Colors.white,
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChangeIp()),
                                    );
                                  },
                                  splashRadius: 60,
                                  tooltip: "Change IP of the app",
                                  color: Colors.white,
                                  focusColor: Colors.white,
                                  splashColor: Colors.red,
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Stack(children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Material(
                                  elevation: 10,
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  shadowColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => UpdateApp()),
                                      );
                                    },
                                    splashRadius: 60,
                                    tooltip: "Upate App",
                                    color: Colors.white,
                                    focusColor: Colors.white,
                                    splashColor: Colors.red,
                                    icon: Icon(
                                      Icons.system_update,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //     top: 0,
                              //     right: 0,
                              //     child: Container(
                              //       padding: EdgeInsets.all(3),
                              //       decoration: BoxDecoration(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(50)),
                              //         color: Colors.red,
                              //       ),
                              //       child: Text(' 1 '),
                              //     ))
                            ])
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.all(Radius.circular(2))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("v 1.0.2+1"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
