import 'package:flutter/material.dart';

class Navigation   extends StatelessWidget {
  const Navigation({super.key, required this.identification});
  final String identification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: const Color(0xffd9d9d9),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        child: Center(
          child: Text(identification),
        ),
      ),
    );
  }
}
