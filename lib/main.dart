import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home:SOS(),
  ));
}

class SOS extends StatefulWidget {
  const SOS({Key? key}) : super(key: key);

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.black,
      title: Text('Emergency'),
),
      body: Column(
      children: [
        Text('ds'),
      ],
      ),
    );
  }
}
