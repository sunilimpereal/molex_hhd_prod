import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDisplay extends StatefulWidget {
  @override
  _TimeDisplayState createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 1000)),
        builder: (context, snapshot) {
          return Container(
            width: 73,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('MM-dd-yyyy').format(DateTime.now()),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      DateFormat('hh:mm').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10)
              ],
            ),
          );
        });
  }
}
