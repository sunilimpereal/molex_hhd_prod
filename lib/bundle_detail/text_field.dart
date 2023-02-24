import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final Function(String)? onchanged;
  final Function(String)? onsubmited;
  const AppTextField({super.key, required this.label, required this.onchanged, required this.controller, this.onsubmited});

  @override
  State<AppTextField> createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: TextField(
            textAlign: TextAlign.center,
            controller: widget.controller,
            onChanged: (value) {},
            onSubmitted: widget.onsubmited,
            showCursor: false,
            decoration: InputDecoration(
              hintText: widget.label,
              enabledBorder: InputBorder.none,
              hintStyle: GoogleFonts.openSans(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
