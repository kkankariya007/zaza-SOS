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
      backgroundColor: Colors.transparent,
      title: Text('Emergency'),
        elevation: 0,
      ),

      body:
      Center(
      child:Container(decoration: const BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.purpleAccent,
        Colors.redAccent,
        ],
      ),
      ),

      child:Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
      SizedBox(height: 200.0),

        RawMaterialButton(
        constraints: BoxConstraints.tight(Size(260,260)),
        fillColor: Colors.black.withOpacity(0.68),
      child: Center(
        child: Text('Send Noodes',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold, 
        ),),
      ),
      onPressed: () async {},
        elevation: 10.0,
      padding: const EdgeInsets.all(30.0),
      shape: const CircleBorder(),
    ),



                      ],
                  ),
                  ),
            ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
    );
  }
}
