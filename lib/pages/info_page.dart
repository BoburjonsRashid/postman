import 'package:flutter/material.dart';

class EmployeeInfoPage extends StatefulWidget {
  static const String id = 'EmployeeInfoPage';
  final String name;
  final String language;
  const EmployeeInfoPage({super.key, required this.name,required this.language});

  @override
  State<EmployeeInfoPage> createState() => _EmployeeInfoPageState();
}

class _EmployeeInfoPageState extends State<EmployeeInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Container(
            width: 400,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text(widget.language),
              ],
            ),
          )
        ),
      ),
    );
  }
}



