import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';


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

void sendSSMS() async {
  String message = "Hello, this is an automated message";
  List<String> recipients = ["+919347821062", "+919755344895"];

  String result = await sendSMS(message: message, recipients: recipients)
      .catchError((onError) {
    print(onError);
  });

  if (result != null) {
    print("SMS sent successfully");
  }
  else
    print("Error sending the SMS");
}

class _SOSState extends State<SOS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: Text('E'),
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
      SizedBox(height: 250.0),

        RawMaterialButton(
        constraints: BoxConstraints.tight(Size(300,300)),
        fillColor: Colors.black.withOpacity(0.68),
        child: Center(
        child: Text('Send',
        style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
                          ),
                    ),
        ),

          onPressed: () async {
            sendSSMS();
          },
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
