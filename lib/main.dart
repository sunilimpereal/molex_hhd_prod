import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molex_hhd/MaterialCord/data/materialcord_bloc.dart';
import 'package:molex_hhd/bundle_detail/data/bundle_bloc.dart';
import 'change_ip.dart';
import 'utils/shared_pref.dart';

SharedPref sharedPref = SharedPref();

void main() async {
  SharedPref sharedPref = SharedPref();
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPref.init();

  runApp(const AppProvider());
}

class AppProvider extends StatefulWidget {
  const AppProvider({super.key});

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  @override
  Widget build(BuildContext context) {
    return MaterialCordProvider(
      context: context,
      child: BundleProvider(
        context: context,
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp();
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // setWindow() async {
  //   Size size = await DesktopWindow.getWindowSize();
  //   print(size);
  //   await DesktopWindow.setWindowSize(Size(500, 500));
  // }

  @override
  void initState() {
    // Future.delayed(Duration(seconds: 4)).then((value) {
    //   setWindow();
    // });

    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Molex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeIp(),
      // Homepage(
      //   userId: "0123456789",
      //   machineId: "0123456789",
      // )
    );
  }
}
  // Homepage(
        //   userId: "21029493",
        //   machineId: "EMU-M/C-038A",
        // )