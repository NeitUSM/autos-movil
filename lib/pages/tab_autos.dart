import 'package:flutter/material.dart';


class TabAutos extends StatefulWidget {
  const TabAutos({super.key});

  @override
  State<TabAutos> createState() => _TabAutosState();
}

class _TabAutosState extends State<TabAutos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Autos'),
    );
  }
}